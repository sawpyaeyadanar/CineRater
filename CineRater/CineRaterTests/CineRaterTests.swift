//
//  CineRaterTests.swift
//  CineRaterTests
//
//  Created by Saw Pyae Yadanar on 9/8/23.
//

import XCTest
@testable import CineRater
@MainActor
final class CineRaterTests: XCTestCase {
    
    var sot: MovieDiscoverViewModel!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sot = .init(apiService: APIPreviewClient())
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sot = nil
    }
    
    func test_getTrendingData() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        sot.loadTrending()
        debugPrint(sot.trending.count)
         XCTAssertEqual(sot.trending.count, 20)
        
    }
    
    
    
}
