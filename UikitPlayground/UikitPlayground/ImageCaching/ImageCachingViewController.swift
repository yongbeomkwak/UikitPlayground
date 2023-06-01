//
//  ImageCachingViewController.swift
//  UikitPlayground
//
//  Created by yongbeomkwak on 2023/05/30.
//

import Foundation
import UIKit

/* 🔥 URLSession
 
 
 🌀 URLSession은 HTTP/HTTPS를 통해 콘텐츠 및 데이터를 주고받기 위해 API를 제공하는 클래스

 1️⃣ Request
 - URL 객체와 직접 통신하는 형태
 - URLRequest 객체를 직접 만들어서 옵션을 설정해서 통신하는 형태

 2️⃣ Response
 - Task의 Completion Handler를 통해서 응답 받는 방식
 - URLSessionDelegate의 메소드를 통해서 응답 받는 방식
 
 API
 
 🌀 URLSession은 request를 보내고 받는 주요 객체인데 이건 URLSessionConfiguration을 통해서 생성할 수 있다.

 - URLsession 개체를 사용하여 데이터를 업로드 및 다운로드할 때 사용할 동작과 정책을 정의한다.
 - 또한, configure session 프로퍼티에 timeout 값이나 캐싱 정책, 헤더값 등 기타 정보 유형들을 적어줄 수 있다.
 - session을 이니셜라이징해주기 전에 적절하게 작성해줘야 한다.

 1️⃣ Default Session (기본 세션)
 : 디스크가 포함된 글로벌 캐시, 자격 증명 및 쿠키 저장소 개체를 사용하는 개체 생성

 2️⃣ Ephemeral Session (임시 세션)
 : 캐시, 쿠키 또는 credential과 같이 영구 저장소를 사용하지 않는 세션 구성 개체 생성

 3️⃣ Background Session (백그라운드 세션)
 : HTTP 및 HTTPS 업로드 또는 다운로드를 백그라운드에서 수행할 수 있는 세션 구성 개체를 생성
 

 🌀 URLSession Task
 1️⃣ URLSessionDataTask
 : 서버에서 메모리로 데이터를 받아오는 작업 수행

 2️⃣ URLSessionUploadTask
 : 데이터를 파일로 변환 후 업로드하는 작업 수행

 3️⃣ URLSessionDownloadTask
 : 데이터를 파일로 변환 후 다운로드하는 작업 수행
 
 🌀 URLSession 통신 단계
 1️⃣  Create a URL
 2️⃣  Create a URLSession
 3️⃣  Give URLSession a task
 4️⃣  Start a task
 
 */


/* 💾 NSCache
 
 1. memory cache(메모리에 존재하는지 체크) 없다면 > disk cache(디스크에 존재하는지 체크) 있으면 Memory에 저장 후 캐싱, 없다면 > 서버통신
 
- memory cache 방법 중 하나는 NSCache 사용
 
 NSCache란?
 
 key-value쌍을 임시로 저장하는데 사용되는 변경 가능한 Collection

 NSCache는 자체적으로 시스템 메모리를 너무 많이 사용하지 않도록 자동으로 제거되는 정책을 소유
 다른 응용 프로그램에서 메모리가 필요한 경우 이러한 정책은 캐시에서 일부 항목을 제거하여 메모리 사용 공간을 최소화
 객체와 달리 캐시는 저장된 key 객체를 복사하지 않는 특징이 존재
 디폴트로 캐시 객체는 컨텐츠가 삭제되면 자동으로 제거 (변경 가능)
 
2. disk cache는 보통 FileManager객체를 사용하여 데이터를 파일 형태로 디스크에 저장하거나 UserDefaults, CoreData 사용
 
*/

class ImageCacheManager {
    static let shared = NSCache<NSString,UIImage>()
}


class ImageCachingViewController : UIViewController,ViewControllerFromStoryBoard {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DEBUG_LOG("SecondVC DidLoad")
        
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DEBUG_LOG("SecondVC WillAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        DEBUG_LOG("SecondVC WillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        DEBUG_LOG("SecondVC DidDisappear")
    }
    
    public static func viewController() -> ImageCachingViewController {
        
        let vc = ImageCachingViewController.viewController(storyBoardName: "Main", bundle: .main)
        
        return vc
    }
    
}
 
extension ImageCachingViewController{
    private func configureUI(){
        self.imageView.setImageUrl(.t1)
    }
}

enum TestUrl:String {
    case t1 = "https://is2-ssl.mzstatic.com/image/thumb/Purple113/v4/41/19/5c/41195c0e-da2f-de45-6924-325e2fab279d/mzl.dgcmevrw.png/576x768bb.png"
    case t2 = "https://is5-ssl.mzstatic.com/image/thumb/Purple116/v4/cf/17/6d/cf176d08-a7c8-23c4-3d7f-9f4ad3658998/AppIcon-0-0-1x_U007emarketing-0-0-0-7-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/60x60bb.jpg"
    case t3 = "https://is1-ssl.mzstatic.com/image/thumb/Purple113/v4/df/59/d2/df59d230-8ae2-5952-d2c1-257cbb8cc428/mzl.ffvcvidd.png/392x696bb.png"
    case t4 = "https://is4-ssl.mzstatic.com/image/thumb/Purple113/v4/7f/39/5a/7f395a0f-81cc-ed23-4f17-c705214c9171/mzl.iwsiuhbr.png/392x696bb.png"
    case t5 = "https://is5-ssl.mzstatic.com/image/thumb/Purple123/v4/64/be/aa/64beaad6-a327-ab3e-7f65-b628ae41abca/mzl.ucpwajol.png/576x768bb.png"
    case y6 = " https://is5-ssl.mzstatic.com/image/thumb/Purple116/v4/cf/17/6d/cf176d08-a7c8-23c4-3d7f-9f4ad3658998/AppIcon-0-0-1x_U007emarketing-0-0-0-7-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/512x512bb.jpg"
    
}

extension UIImageView{
    func setImageUrl(_ url: TestUrl){
        DispatchQueue.global(qos: .background).async {
            
             let cachedKey = NSString(string: url.rawValue)

              /// cache된 이미지가 존재하면 그 이미지를 사용 (API 호출안하는 형태)
              if let cachedImage = ImageCacheManager.shared.object(forKey: cachedKey) {
                  DEBUG_LOG("Load from Cache")
                  DispatchQueue.main.async {
                      self.image = cachedImage
                  }
                  
                  return
              }
            
            
            guard let url = URL(string: url.rawValue) else {return}
            let task = URLSession.shared.dataTask(with: url) {[weak self] (data, result, error) in
                
                guard let self else {return}
                
                guard  error == nil else {
                    
                    DispatchQueue.main.async {
                        self.image = UIImage()
                    }
                     return
                }
                
                
                DispatchQueue.main.async {
                    if let data = data, let image = UIImage(data: data) {
                        DEBUG_LOG("Load from Server")
                        ImageCacheManager.shared.setObject(image, forKey: cachedKey)
                        self.image = image
                    }
                }
 
            }
            
            
            task.resume()
        }
        
    }
}
