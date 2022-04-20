//
//  AdressAPI.swift
//  Clean-Architecture-MVVM
//
//  Created by Kim dohyun on 2022/04/20.
//

import Foundation
import Alamofire


protocol DefaulAPI: URLRequestConvertible {
    static var baseURL: String {get}
    var method: HTTPMethod {get}
    var parameters: Parameters {get}
    var headers: HTTPHeaders {get}
    var parameterEncode: ParameterEncoding { get }
}

enum AdressRouter: DefaulAPI {
    case getAdress(String, String, String, String, String)
    
    static let baseURL: String = "http://www.juso.go.kr/addrlink/addrLinkApiJsonp.do"
    
    
    var method: HTTPMethod {
        switch self {
        case .getAdress:
            return .get
        }
    }
    
    var parameters: Parameters {
        switch self {
        case .getAdress(let confmKey, let currentPage, let countPerPage, let resultType, let keyword):
            return ["confmKey":confmKey,
                    "currentPage":currentPage,
                    "countPerPage":countPerPage, "resultType": resultType, "keyword": keyword
            ]
        }
    }
    
    var headers: HTTPHeaders {
        switch self {
        case .getAdress:
            return ["Content-Type":"application/json"]
        }
    }
    
    var parameterEncode: ParameterEncoding {
        switch self {
        case .getAdress:
            return URLEncoding.default
        }
    }
    
    public func asURLRequest() throws -> URLRequest {
        let url = try AdressRouter.baseURL.asURL()
        let urlRequest = try URLRequest(url: url, method: method, headers: headers)
    

        return urlRequest
        
    }
    
}


protocol AdressAPI {
    func getAdress(requestValue: RequestValue, completion: @escaping (Result<Adress, Error>) -> Void)
}

extension AdressAPI {
    public func getAdress(requestValue: RequestValue, completion: @escaping (Result<Adress, Error>) -> Void) {
        AF.request(AdressRouter.getAdress(requestValue.confmKey, requestValue.currentPage, requestValue.countPerPage, requestValue.resultType, requestValue.keyword))
            .validate(statusCode: 200...300)
            .responseDecodable { (response: AFDataResponse<Adress>) in
                switch response.result {
                case .success:
                    guard let data = response.value else { return }
                    print(" Value : \(response.value)")
                    completion(.success(data))
                case .failure(let errorCode):
                    print(" Error code \(errorCode)")
                    completion(.failure(errorCode))
                }
                
            }
            
    }
    
}
