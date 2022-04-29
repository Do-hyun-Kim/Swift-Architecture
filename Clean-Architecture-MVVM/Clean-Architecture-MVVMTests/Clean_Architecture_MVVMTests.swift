//
//  Clean_Architecture_MVVMTests.swift
//  Clean-Architecture-MVVMTests
//
//  Created by Kim dohyun on 2022/04/20.
//

import XCTest
@testable import Clean_Architecture_MVVM



class Clean_Architecture_MVVMTests: XCTestCase {
    var searchViewModel: SearchViewModel?
    var searchLayer: SearchAPILayer?
    var requestValue: RequestValue?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        requestValue = nil
        searchLayer = nil
        searchViewModel = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        //given
        requestValue = RequestValue(confmKey: "devU01TX0FVVEgyMDIyMDQyODE4NDMwMTExMjUxNTA=", keyword: "강남", countPerPage: "10", currentPage: "1", resultType: "json")
        searchLayer = SearchAPILayer(requestValue: requestValue!)
        searchViewModel = SearchViewModel(searchLayer: searchLayer!)
        
        //when
        let requestExpectation = expectation(description: "Search Reqeust finish")
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) { [weak self] in
            guard let `self` = self else { return }
            self.searchViewModel?.fetchSearchAdress(completion: { result in
                switch result {
                case .success(let value):
                    XCTAssertNotNil(value)
                case .failure(let error):
                   XCTAssertThrowsError(error, "search Error")
                }
            })
            requestExpectation.fulfill()
        }
        
        //then
        wait(for: [requestExpectation], timeout: 82.0)
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
