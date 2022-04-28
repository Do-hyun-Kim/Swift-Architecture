//
//  SearchViewModel.swift
//  Clean-Architecture-MVVM
//
//  Created by Kim dohyun on 2022/04/28.
//

import Foundation


final class SearchViewModel {
    
    let entities: Adress
    let searchLayer: SearchAPILayer
    
    
    init(entities: Adress, searchLayer: SearchAPILayer) {
        self.entities = entities
        self.searchLayer = searchLayer
    }
    
    
}
