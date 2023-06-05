//
//  RecentSearchResultViewModel.swift
//  UikitPlayground
//
//  Created by yongbeomkwak on 2023/06/04.
//

import Foundation

class RecentSearchResultViewModel {
    
    var filteredData:[String] = []
    
    
    func filteredBy(text:String){
        
        guard let data = PreferenceManager.recentRecords else {return}
        
        filteredData = data.filter({$0.localizedCaseInsensitiveContains(text)})
        
        
        
    }
    
    func remove(text:String){
        
        if let i = filteredData.firstIndex(where: { $0 == text }){
            filteredData.remove(at: i)
        }
    }
}
