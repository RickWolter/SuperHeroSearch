//
//  DisneyTakeHomeTests.swift
//  DisneyTakeHomeTests
//
//  Created by Rick W. on 7/4/22.
//

import XCTest
@testable import DisneyTakeHome

class DisneyTakeHomeTests: XCTestCase {

  
  
    override func setUpWithError() throws {
      try super.setUpWithError()
       
    }

    override func tearDownWithError() throws {
     
    }
      
      func testApiCallCompletes() throws {
        
      var sut = URLSession(configuration: .default)
        
        // given
        let publicKey = "bcef02a63819df04b8fa913013e4568a"
        //let privateKey = "5b53459fba33e82de4ae470a758d0a8ed3f2121c"
        //let hash = MD5(data: "\(ts)\(privateKey)\(publicKey)")
        //got this hash from an online tool (although not techincally a hash)
        let MD5HashString = "016a43cf34bab3d9f1862138b005ca8b"
        let domain = "https://gateway.marvel.com:443/v1/public/"
        let ts = "1"
        let comicsQuery = "/comics?"
        let url = "\(domain)\(comicsQuery)&limit=50&ts=\(ts)&apikey=\(publicKey)&hash=\(MD5HashString)"
        
        let promise = expectation(description: "Completion handler invoked")
        var statusCode: Int?
        var responseError: Error?

        // when
        
        let dataTask =  sut.dataTask(with: URL(string: url)!) { (data, response, error) in
           // then
           if let error = error {
             XCTFail("Error: \(error.localizedDescription)")
             return
           } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
             if statusCode == 200 {
               // 2
               promise.fulfill()
             } else {
               XCTFail("Status code: \(statusCode)")
             }
           }
         }
         dataTask.resume()
         // 3
         wait(for: [promise], timeout: 5)
       }
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
      
    }

