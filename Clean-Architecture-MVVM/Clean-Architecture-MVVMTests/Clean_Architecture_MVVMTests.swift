//
//  Clean_Architecture_MVVMTests.swift
//  Clean-Architecture-MVVMTests
//
//  Created by Kim dohyun on 2022/04/20.
//

import XCTest
@testable import Clean_Architecture_MVVM

class NetworkLayerMock: AdressAPI {
    
}


class AdressRepository: AdressNetworkRepository {
    var recentQueries: Adress = Adress()
    
    func fetchSearchAdress(requestValue: RequestValue, completion: @escaping (Result<Adress, Error>) -> Void) {
        completion(.success(recentQueries))
    }
}



class Clean_Architecture_MVVMTests: XCTestCase {
    var networkTest: DefaultAdressSearchUseCase?
    lazy var repository: AdressRepository = AdressRepository()
    lazy var networkLayerMock: NetworkLayerMock = NetworkLayerMock()
    
    override func setUpWithError() throws {

        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let requestExpectation = expectation(description: "Request should finish")
        networkTest = DefaultAdressSearchUseCase.init(adressRepository: repository, adressNetworkLayer: networkLayerMock)
        
        
        let value = RequestValue(confmKey: "devU01TX0FVVEgyMDIyMDQyODE4NDMwMTExMjUxNTA=", currentPage: "1", countPerPage: "10", keyword: "강남", resultType: "json")
        
        networkTest?.excute(request: value, completion: { result in
            XCTAssertNil(result)
            requestExpectation.fulfill()
        })
        waitForExpectations(timeout: 100.0, handler: nil)
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
