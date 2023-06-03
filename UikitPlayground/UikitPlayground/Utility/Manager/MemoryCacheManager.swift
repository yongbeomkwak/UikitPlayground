//
//  MemoryCacheManager.swift
//  UikitPlayground
//
//  Created by yongbeomkwak on 2023/06/03.
//

import Foundation

class MemoryCacheManager {
    
    static let shared = MemoryCacheManager()
    private let cache = NSCache<NSString,NSData>() // 메모리 캐시
    
    
    func fatchData(key:NSString) -> NSData? { // 가져오기
        return cache.object(forKey: key)
    }
    
    func saveData(data:NSData,key:NSString) {
        cache.setObject(data, forKey: key) // 메모리 캐시 업데이트
    }
    

}
