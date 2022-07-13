//
//  UITestingTutorialUITests.swift
//  UITestingTutorialUITests
//
//  Created by Tatsuya Moriguchi on 7/12/22.
//  Copyright © 2022 Code Pro. All rights reserved.
//

import XCTest

class UITestingTutorialUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
    func testInvalidLogin_progressSpinnersIsHidden() {
        
        
        let app = XCUIApplication()
        app.activate()
        
        app.navigationBars["Mockify Music"].buttons["Profile"].tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["Login"]/*[[".buttons[\"Login\"].staticTexts[\"Login\"]",".staticTexts[\"Login\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.alerts["Missing Credentials"].scrollViews.otherElements.buttons["Ok"].tap()
        let activityIndicatorView = app.activityIndicators["In progress"]
        XCTAssertFalse(activityIndicatorView.exists)

        
    }
    
    
    func testInvalidLogin_missingCredentialAlertIsShown() {
        
        let app = XCUIApplication()
        app.activate()
        app.navigationBars["Mockify Music"].buttons["Profile"].tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["Login"]/*[[".buttons[\"Login\"].staticTexts[\"Login\"]",".staticTexts[\"Login\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let alertDialog = app.alerts["Missing Credentials"]
        XCTAssertTrue(alertDialog.exists)
        alertDialog.buttons["Ok"].tap()
        
        
    }

    func testValidLoginSuccess() {
        
        let validUserName = "CodePro"
        let validPassword = "abc123"
        
        
        let app = XCUIApplication()
        app.activate()
        
        app.navigationBars["Mockify Music"].buttons["Profile"].tap()
        
        let userNameTextField =  app.textFields["Username"]
        XCTAssertTrue(userNameTextField.exists)
        userNameTextField.tap()
        userNameTextField.typeText(validUserName)
        
        
        let passwordSecureTextField = app.secureTextFields["Password"]
        XCTAssertTrue(passwordSecureTextField.exists)
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText(validPassword)

        
        app/*@START_MENU_TOKEN@*/.staticTexts["Login"]/*[[".buttons[\"Login\"].staticTexts[\"Login\"]",".staticTexts[\"Login\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let downloadCell = app.tables.staticTexts["My Downloads"]
        
        expectation(for: NSPredicate(format: "exists == 1"), evaluatedWith: downloadCell, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertTrue(downloadCell.exists)

    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
