//
//  ImageCacheManager.swift
//  UikitPlayground
//
//  Created by yongbeomkwak on 2023/06/02.
//

import Foundation
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


/* 💾 Cache
 
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

/*

 🌀 우선 캐시처리에 대한 구현은 3번의 분기를 해야 한다고 생각해요

  
 1. 이미지가 memory cache(NSCache)에 있는지 확인하고

 원하는 이미지가 없다면

 2. disk cache(UserDefault 혹은 기기Directory에있는 file형태)에서 확인하고

 있다면 memory cache에 추가해주고 다음에는 더 빨리 가져 올수 있도록 할 수 있어요

 이마저도 없다면

 3. 서버통신을 통해서 받은 URL로 이미지를 가져와야해요

 이때 서버통신을 통해서 이미지를 가져왔으면 memory와 disk cache에 저장해줘야 캐시처리가 되겠죠?!
 
*/

class ImageCacheManager {
    
    static let shared =  ImageCacheManager()
    
    private let cache = NSCache<NSString,NSData>()
    
   // func loadImage()
    
    
    
}
