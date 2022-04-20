//
//  User.swift
//  Clean-Architecture-MVVM
//
//  Created by Kim dohyun on 2022/04/20.
//

import Foundation


struct Adress: Codable {
    var results: AdressResponse?
}

struct AdressResponse: Codable {
    var common: AdressCommon?
    var juso: [AdressResult]?
}


struct AdressCommon: Codable {
    var errorMessage, errorCode: String?
    var countPerPage, totalCount, currentPage: String?
}

struct AdressResult: Codable {
    var detBdNmList: String
    var engAddr: String
    var rn: String
    var emdNm: String
    var zipNo: String
    var roadAddrPart2: String
    var emdNo: String
    var sggNm: String
    var jibunAddr: String
    var siNm: String
    var roadAddrPart1: String
    var bdNm: String
    var admCd: String
    var udrtYn: String
    var lnbrMnnm: String
    var roadAddr: String
    var lnbrSlno: String
    var buldMnnm: String
    var bdKdcd: String
    var liNm: String
    var rnMgtSn: String
    var mtYn: String
    var bdMgtSn: String
    var buldSlno: String
}
