//
//  DiskCacheManager.swift
//  UikitPlayground
//
//  Created by yongbeomkwak on 2023/06/03.
//

import Foundation

class DiskCacheManager {

    private let cache = FileManager.default
    
    func isExistData(url:String) ->Bool { // 캐시 존재 여부
        cache.fileExists(atPath: url)
    }

    
    func getFilePath(url:String) -> URL { // 저장 경로
        guard let cacheDirectory = cache.urls(for: .cachesDirectory, in: .userDomainMask).first else {return URL(fileURLWithPath: url)}
        
        return cacheDirectory.appending(path: url) // 캐시 디렉토리에 url을 이용하여 경로를 생성
    }
    
    func saveData(url:String,data:Data?) { // 저장
        cache.createFile(atPath: url, contents: data)
    }
    
}
