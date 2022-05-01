//
//  SearchViewModel.swift
//  Clean-Architecture-MVVM
//
//  Created by Kim dohyun on 2022/04/28.
//

import Foundation


final class SearchViewModel {
    
    public var entities: Adress = Adress()
    public var searchLayer: SearchAPILayer
    
    
    init(searchLayer: SearchAPILayer) {
        self.searchLayer = searchLayer
    }
    
    
    public func fetchSearchAdress( completion: @escaping () -> Void) {
        return searchLayer
            .getAdress { result in
                switch result {
                case .success(let value):
                    self.entities = value
                    completion()
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
}
