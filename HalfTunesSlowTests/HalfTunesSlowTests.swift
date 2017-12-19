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
    let url = URL(string: "https://itunes.apple.com/search?media=music&entity=song&term=abba");
    
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
  
  func testCallToiTunesCompletes() {
    let url = URL(string: "https://itunes.apple.com/search?media=music&entity=song&term=abba");
    
    let promise = expectation(description: "Completion handler invoked");
    var statusCode: Int?
    var responseError: Error?
    
    let dataTask = sessionUnderTest.dataTask(with: url!) { data, response, error in
      statusCode = (response as? HTTPURLResponse)?.statusCode;
      responseError = error;
      promise.fulfill(); /// Fulfills whether there exists an error or nah
    }
    dataTask.resume();
    /// Waits here until expectation is fulfilled or timeout exceeds, then executes following code
    waitForExpectations(timeout: 5, handler: nil);
    
    XCTAssertNil(responseError); // responseError should be nil; otherwise fail
    XCTAssertEqual(statusCode, 200); // statusCode = 200; otherwise fail
  }
}
