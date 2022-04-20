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
            return []
        }
    }
    
    public func asURLRequest() throws -> URLRequest {
        let url = try AdressRouter.baseURL.asURL()
        var urlRequest = try URLRequest(url: url, method: method, headers: headers)
        urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        
        return urlRequest
        
    }
    
}
