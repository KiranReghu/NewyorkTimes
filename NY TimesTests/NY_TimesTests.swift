//
//  NY_TimesTests.swift
//  NY TimesTests
//
//  Created by Kiran R on 18/09/21.
//

import XCTest
@testable import NY_Times

class NY_TimesTests: XCTestCase {

    var articleListViewController: ArticleListViewController!
    
    override func setUpWithError() throws {
        articleListViewController = ArticleListViewController()
    }

    override func tearDownWithError() throws {
        articleListViewController = nil
        try super.tearDownWithError()
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testGetListUrlSuccess () throws {
        
      
    }
    
    func testGetListUrlFailure () throws {
        
        
    }
    
    func testLoadArticleListSuccess() throws {
    
    }
    
    func testLoadArticleListFailure() throws {
        
    }
    

}
