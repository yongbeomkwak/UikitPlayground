//
//  RecentSearchResultViewModel.swift
//  UikitPlayground
//
//  Created by yongbeomkwak on 2023/06/04.
//

import Foundation

class RecentSearchResultViewModel {
    var dataSource: [String] = []
    
    func filteredBy(text:String, isFiltering: Bool){
        
        /// 필터링 중이면 , 필터링된 값을 상용하고 , 아니면 raw 값을 사용한다.
        
        let recentRecords: [String] = PreferenceManager.recentRecords ?? []
        dataSource = isFiltering ?
            recentRecords.filter({$0.localizedCaseInsensitiveContains(text)}) :
            recentRecords
    }
    
    func remove(text:String){
        if let i = dataSource.firstIndex(where: { $0 == text }){
            /// 보여진는 값과 실제 DB 값 제거 
            dataSource.remove(at: i)
            PreferenceManager.shared.removeRecentRecords(word: text)
        }
    }
}
