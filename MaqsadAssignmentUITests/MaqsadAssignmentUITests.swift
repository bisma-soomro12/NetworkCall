//
//  MaqsadAssignmentUITests.swift
//  MaqsadAssignmentUITests
//
//  Created by Bisma Soomro on 23/09/2022.
//

import XCTest

class MaqsadAssignmentUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
        
    }
    
    func testEmptyTextFieldOnAlertBox(){
        let app = XCUIApplication()
        app.launch()
        let elementsQuery = app.scrollViews.otherElements
        let submitButton = elementsQuery.buttons["Submit"]
        let searchHereTextField = elementsQuery.textFields["Search here"]
        let okButton = app.alerts["Alert"].scrollViews.otherElements.buttons["OK"]
        
        searchHereTextField.tap()
        searchHereTextField.typeText("c")
        submitButton.tap()
        okButton.tap()
        XCTAssertEqual(searchHereTextField.value as! String, "Search here")
    }
    

    
    func testTextFieldInitiallyEmpty() {
        let app = XCUIApplication()
        app.launch()
        
        let searchHereTextField = app.scrollViews.otherElements.textFields["Search here"]
        searchHereTextField.tap()
        searchHereTextField.typeText("")
      //  submitButton.tap()
      XCTAssertEqual(searchHereTextField.value as! String, "Search here")
    }

//    func testLaunchPerformance() throws {
//        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
//            // This measures how long it takes to launch your application.
//            measure(metrics: [XCTApplicationLaunchMetric()]) {
//                XCUIApplication().launch()
//            }
//        }
//    }
}
