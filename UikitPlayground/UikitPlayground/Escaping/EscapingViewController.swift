//
//  EscapingViewController.swift
//  UikitPlayground
//
//  Created by yongbeomkwak on 2023/06/01.
//

import UIKit

/*

 🔥 Escaping 클로저
 
 Escaping 클로저는 클로저가 함수의 인자로 전달됐을 때, 함수의 실행이 종료된 후 실행되는 클로저 입니다.
 Non-Escaping 클로저는 이와 반대로 함수의 실행이 종료되기 전에 실행되는 클로저 입니다.
 
 이렇게 escaping, non-escaping 클로저를 나눠서 사용하는 이유는 컴파일러의 퍼포먼스와 최적화 때문입니다.

 non-escaping 클로저는 컴파일러가 클로저의 실행이 언제 종료되는지 알기 때문에,
 때에 따라 클로저에서 사용하는 특정 객체에 대한 retain, release 등의 처리를 생략해
 객체의 라이프싸이클(life-cycle)을 효율적으로 관리할 수 있습니다.

 반면 esacping 클로저는 함수 밖에서 실행되기 때문에 클로저가 함수 밖에서도 적절히 실행되는 것을 보장하기 위해,
 클로저에서 사용하는 객체에 대한 추가적인 참조싸이클(reference cycles) 관리 등을 해줘야 합니다.
 이 부분이 컴파일러의 퍼포먼스와 최적화에 영향을 끼치기 때문에 Swift에서는 필요할 때만 escaping 클로저를 사용하도록 구분해 두었습니다.
 
 
*/


class EscapingViewController: UIViewController,ViewControllerFromStoryBoard {
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    
    var vm = EscapingViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nonEscapingClosure {
            DEBUG_LOG("1️⃣ Run nonEscape Deliver Closure")
            self.label1.text = "Run nonEscape Deliver Closure"
        }
        DEBUG_LOG("4️⃣ Terminate nonEscape Deliver Closure")
        
        
        vm.escapeClosure {
            DEBUG_LOG("1️⃣ Run Escape Deliver Closure")
            self.label2.text = "Run Escape Deliver Closure"
        }
        
        DEBUG_LOG("4️⃣ Terminate Escape Deliver Closure")
        
        vm.optionalClosure {
            DEBUG_LOG("1️⃣ Run Optional Deliver Closure")
            self.label3.text = "Run Optional Deliver Closure"
        }
        
        DEBUG_LOG("4️⃣ Terminate Optional Deliver Closure")
        
        
    }
    
    public static func viewController() -> EscapingViewController {
        
        let vc = EscapingViewController.viewController(storyBoardName: "Main", bundle: .main)
        
        return vc
    }
    


}

extension EscapingViewController {
    
    
    func nonEscapingClosure(closure: () -> Void) {
        /*
         클로저가 runClosure() 함수의 closure 인자로 전달됨
         함수 안에서 closure() 가 실행됨
         runClosure() 함수가 값을 반환하고 종료됨
         이렇게 클로저가 함수가 종료되기 전에 실행되기 때문에 closure는 Non-Escaping 클로저 입니다.
         */
        DEBUG_LOG("2️⃣ Run nonEscape")
        closure()
        DEBUG_LOG("3️⃣ Exit nonEscape")
    }
    

    
}

class EscapingViewModel {
    /*
     클로저가 escapeClosure() 함수의 completion 인자로 전달됨
     
     클로저 completion이 completionHandler 변수에 저장됨
     
     fetchData() 함수가 값을 반환하고 종료됨
     
     클로저 completion은 아직 실행되지 않음
     
     completion은 함수의 실행이 종료되기 전에 실행되지 않기 때문에 escaping 클로저,
     다시말해 함수 밖(escaping)에서 실행되는 클로저 입니다.
     
     */
    var completionHandler: (()-> Void)? = nil
    
    func escapeClosure(completion: @escaping () ->Void){
        DispatchQueue.main.asyncAfter(deadline: .now()+3, execute: {
            DEBUG_LOG("2️⃣ Run Escape")
            completion()
            DEBUG_LOG("3️⃣ Exit Escape")
        })
    }
    /*
     파라미터 타입이 Optional Closure일 경우,  더이상 Closure 파라미터 타입이 아닌 Optional 파라미터 타입이다.
     
     기본적으로 파라미터로 받는 "클로저"는 함수 흐름을 탈출하지 못한다

      

     위 조건에서 "클로저"조건이 벗어나버린 것임!!!!

     근데 이렇게 함수 파라미터의 클로저가 Optional Type인 경우엔

     자동으로 escaping으로 동작하나봄!! 따라서 @escaping을 지우라는 듯..?
     
     */
    
    func optionalClosure(completion:(() -> ())?) {
        DispatchQueue.main.asyncAfter(deadline: .now()+3, execute: {
            DEBUG_LOG("2️⃣ Run Optional")
            completion?()
            DEBUG_LOG("3️⃣ Exit Optional")
        })
    }
    
}

/* 결과

 기본 클로저

 [EscapingViewController.swift] nonEscapingClosure(86): 2️⃣ Run nonEscape
 [EscapingViewController.swift] viewDidLoad(42): 1️⃣ Run nonEscape Deliver Closure
 [EscapingViewController.swift] nonEscapingClosure(88): 3️⃣ Exit nonEscape
 [EscapingViewController.swift] viewDidLoad(45): 4️⃣ Terminate nonEscape Deliver Closure
 
 탈출 클로저
 
 [EscapingViewController.swift] viewDidLoad(53): 4️⃣ Terminate Escape Deliver Closure [탈출 클로저 완전 종료]
 [EscapingViewController.swift] viewDidLoad(60): 4️⃣ Terminate Optional Deliver Closure[옵셔널 클로저 완전 종료]
 [EscapingViewController.swift] escapeClosure(113): 2️⃣ Run Escape
 [EscapingViewController.swift] viewDidLoad(49): 1️⃣ Run Escape Deliver Closure
 [EscapingViewController.swift] escapeClosure(115): 3️⃣ Exit Escape
 [EscapingViewController.swift] optionalClosure(135): 2️⃣ Run Optional
 [EscapingViewController.swift] viewDidLoad(56): 1️⃣ Run Optional Deliver Closure
 [EscapingViewController.swift] optionalClosure(137): 3️⃣ Exit Optional
 
 */
