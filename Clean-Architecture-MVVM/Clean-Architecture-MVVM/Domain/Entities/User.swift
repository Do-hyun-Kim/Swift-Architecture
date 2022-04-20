//
//  User.swift
//  Clean-Architecture-MVVM
//
//  Created by Kim dohyun on 2022/04/20.
//

import Foundation


struct Adress: Codable {
    var result: [AdressCommon]
    var juso: [AdressResult]
}


struct AdressCommon: Codable {
    var errorMessage,errorCode: String
    var countPerPage, totalCount, currentPage: String
}

struct AdressResult: Codable {
    var jibunAddr: String
    var roadAddr: String
}
