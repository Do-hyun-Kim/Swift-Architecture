//
//  SearchAPILayer.swift
//  Clean-Architecture-MVVM
//
//  Created by Kim dohyun on 2022/04/28.
//

import Alamofire


final class SearchAPILayer: AdressAPI {
    
    func getAdress(requestValue: RequestValue, completion: @escaping (Result<Adress, Error>) -> Void) {
        AF.request(AdressRouter.getAdress(requestValue.confmKey, requestValue.keyword, requestValue.countPerPage, requestValue.countPerPage, requestValue.currentPage))
            .responseDecodable(of: Adress.self) { response in
                switch response.result {
                case .success(let value):
                    debugPrint(value)
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                }
            }
        
    }
    
}


//extension AdressAPI {
//    public func getAdress(requestValue: RequestValue, completion: @escaping (Result<Adress, Error>) -> Void) {
//        AF.request(AdressRouter.getAdress(requestValue.confmKey, requestValue.keyword, requestValue.countPerPage, requestValue.currentPage, requestValue.resultType))
//            .responseDecodable(of: Adress.self) { response in
//                switch response.result {
//                case .success:
//                    guard let data = response.value else { return }
//                    print(" Value : \(response.value)")
//                    completion(.success(data))
//                case .failure(let errorCode):
//                    print(" Error code \(errorCode)")
//                    completion(.failure(errorCode))
//                }
//
//            }
//
//    }
//
//}
