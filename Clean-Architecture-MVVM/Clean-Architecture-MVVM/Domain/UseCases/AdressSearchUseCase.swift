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
        return adressNetworkLayer.getAdress(requestValue: request) { result in
            if case .success = result {
                completion(result)
            }
        }
    }
    
    
}


struct RequestValue {
    var confmKey: String
    var currentPage: String
    var countPerPage: String
    var keyword: String
    var resultType: String
}

