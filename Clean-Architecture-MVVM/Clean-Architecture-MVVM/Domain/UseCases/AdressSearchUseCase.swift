//
//  AdressSearchUseCase.swift
//  Clean-Architecture-MVVM
//
//  Created by Kim dohyun on 2022/04/20.
//

import Foundation


protocol AdressSearchUseCase {
//    func excute(request: RequestValue)
}



struct RequestValue {
    var confmKey: String
    var currentPage: String
    var countPerPage: String
    var keyword: String
    var resultType: String
}

