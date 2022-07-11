//
//  DisneyTakeHomeUITests.swift
//  DisneyTakeHomeUITests
//
//  Created by Rick W. on 7/4/22.
//

import XCTest

//class DisneyTakeHomeUITests: XCTestCase {
//
//    override func setUpWithError() throws {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//
//        // In UI tests it is usually best to stop immediately when a failure occurs.
//        continueAfterFailure = false
//
//        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
//    }
//
//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }
//
//    func testExample() throws {
//        // UI tests must launch the application that they test.
//        let app = XCUIApplication()
//        app.launch()
//
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//    }
//
//    func testLaunchPerformance() throws {
//        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
//            // This measures how long it takes to launch your application.
//            measure(metrics: [XCTApplicationLaunchMetric()]) {
//                XCUIApplication().launch()
//            }
//        }
//    }
//}
//



class OnLaunchTest: XCTestCase {
  

      func test_is_correct_view_displayed() {
   
        let app = XCUIApplication()
        app.launch()
        
        app.tabBars.buttons.element(boundBy: 1).tap()

    
        let marvelCharactersLabel = app.staticTexts["Marvel Characters"]
        XCTAssert(marvelCharactersLabel.exists)
      }
  
  
  func text_SearchBarIsPresent(){


  }
}
