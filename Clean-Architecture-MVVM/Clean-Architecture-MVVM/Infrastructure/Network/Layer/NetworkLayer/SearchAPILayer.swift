//
//  SearchAPILayer.swift
//  Clean-Architecture-MVVM
//
//  Created by Kim dohyun on 2022/04/28.
//

import Alamofire


final class SearchAPILayer: AdressAPI {
    public var requestValue: RequestValue
    
    init(requestValue: RequestValue) {
        self.requestValue = requestValue
    }
    
    func getAdress(completion: @escaping (Result<Adress, Error>) -> Void) {
        AF.request(AdressRouter.getAdress(requestValue.confmKey, requestValue.keyword, requestValue.countPerPage, requestValue.currentPage, requestValue.resultType))
            .responseDecodable { (response: DataResponse<Adress, AFError>) in
                switch response.result {
                case .success(let value):
                    print(" Success : Value | \(value)")
                    debugPrint(value)
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                }
            }
        
    }
    
}
