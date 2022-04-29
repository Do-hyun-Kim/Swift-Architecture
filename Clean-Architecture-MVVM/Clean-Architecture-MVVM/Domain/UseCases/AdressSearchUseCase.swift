//
//  AdressSearchUseCase.swift
//  Clean-Architecture-MVVM
//
//  Created by Kim dohyun on 2022/04/20.
//

import Foundation


protocol AdressSearchUseCase {
    func excute(request: RequestValue, completion: @escaping(Result<Adress, Error>) -> Void)
    
}


final class DefaultAdressSearchUseCase: AdressSearchUseCase {
    
    private let adressRepository: AdressNetworkRepository
    private let adressNetworkLayer: AdressAPI
    
    init(adressRepository: AdressNetworkRepository, adressNetworkLayer: AdressAPI) {
        self.adressRepository = adressRepository
        self.adressNetworkLayer = adressNetworkLayer
    }
    
    
    func excute(request: RequestValue, completion: @escaping (Result<Adress, Error>) -> Void) {
        return adressRepository.fetchSearchAdress(requestValue: request) { result in
            switch result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
}


struct RequestValue {
    var confmKey: String
    var keyword: String
    var countPerPage: String
    var currentPage: String
    var resultType: String
}

