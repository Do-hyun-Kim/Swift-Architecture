//
//  AdressAPI.swift
//  Clean-Architecture-MVVM
//
//  Created by Kim dohyun on 2022/04/20.
//

import Foundation
import Alamofire


protocol DefaultAPI: URLRequestConvertible {
    static var baseURL: String {get}
    var method: HTTPMethod {get}
    var parameters: Parameters? {get}
    var parameterEncode: ParameterEncoding { get }
}

enum AdressRouter: DefaultAPI {
    case getAdress(String, String, String, String, String)
    
    static let baseURL: String = "https://www.juso.go.kr/addrlink/addrLinkApi.do"
    
    
    var method: HTTPMethod {
        switch self {
        case .getAdress:
            return .get
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .getAdress(let confmKey, let keyword, let countPerPage, let currentPage, let resultType):
            return ["confmKey":confmKey,
                    "keyword":keyword,
                    "countPerPage":countPerPage,
                    "currentPage":currentPage,
                     "resultType": resultType
            ]
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
        let urlRequest = try URLRequest(url: url, method: method)
        
        if let parameters = parameters {
            return try parameterEncode.encode(urlRequest, with: parameters)
        }
    
        return urlRequest
    }
    
}


protocol AdressAPI {
    func getAdress(completion: @escaping (Result<Adress, Error>) -> Void)
}
