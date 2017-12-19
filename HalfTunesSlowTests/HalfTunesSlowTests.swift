//
//  HalfTunesSlowTests.swift
//  HalfTunesSlowTests
//
//  Created by Kevin Largo on 12/18/17.
//  Copyright © 2017 Ray Wenderlich. All rights reserved.
//

import XCTest

class HalfTunesSlowTests: XCTestCase {
  
  var sessionUnderTest: URLSession!
  
  override func setUp() {
    super.setUp()
    sessionUnderTest = URLSession(configuration: .default);
  }
  
  override func tearDown() {
    sessionUnderTest = nil;
    super.tearDown()
  }
  
  func testValidCallToiTunesGetsHHTTPStatusCode200() {
    let url = URL(string: "https://itunes.apple.com/search?media=music&entity");
    
    let promise = expectation(description: "Status code: 200");
    
    /// Asynchronous
    let dataTask = sessionUnderTest.dataTask(with: url!) { data, response, error in
      if let error = error {
        XCTFail("Error: \(error.localizedDescription)");
        return;
      } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
        if statusCode == 200 {
          /// statusCode is correct; signify promsie to be fulfilled()
          promise.fulfill();
        } else {
          XCTFail("Status code: \(statusCode)");
        }
      }
    }
    
    dataTask.resume();
    
    /// Keep test running until all expectations are fulfilled or timeout interval ends
    waitForExpectations(timeout: 5, handler: nil);
  }
  
}
