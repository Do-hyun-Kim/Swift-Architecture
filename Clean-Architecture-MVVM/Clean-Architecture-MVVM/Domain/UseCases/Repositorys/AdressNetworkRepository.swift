//
//  AdressNetworkRepository.swift
//  Clean-Architecture-MVVM
//
//  Created by Kim dohyun on 2022/04/27.
//

import Foundation


protocol AdressNetworkRepository {
    func fetchSearchAdress(requestValue: RequestValue, completion: @escaping(Result<Adress, Error>) -> Void)
}
