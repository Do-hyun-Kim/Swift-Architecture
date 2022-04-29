//
//  SearchViewModel.swift
//  Clean-Architecture-MVVM
//
//  Created by Kim dohyun on 2022/04/28.
//

import Foundation


final class SearchViewModel {
    
    private let entities: Adress = Adress()
    let searchLayer: SearchAPILayer
    
    
    init(searchLayer: SearchAPILayer) {
        self.searchLayer = searchLayer
    }
    
    
    public func fetchSearchAdress( completion: @escaping (Result<Adress,Error>) -> Void) {
        return searchLayer
            .getAdress { result in
                switch result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
}
