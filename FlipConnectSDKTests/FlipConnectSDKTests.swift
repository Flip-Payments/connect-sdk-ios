//
//  FlipConnectSDKTests.swift
//  FlipConnectSDKTests
//
//  Created by Munir Wanis on 06/06/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import XCTest
@testable import FlipConnectSDK

class FlipConnectSDKTests: XCTestCase {
    
    struct testConsts {
        static let authorizationCodeKey = "FCAuthorizationCode"
        static let authorizationCode = "test"
    }
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        UserDefaults.standard.set(testConsts.authorizationCode, forKey: testConsts.authorizationCodeKey)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        UserDefaults.standard.removeObject(forKey: testConsts.authorizationCodeKey)
    }
    
    func testSaveAuthCodeBeingSavedOnLocalStorage() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertFalse(UserDefaults.standard.authorizationCode == nil, "AuthorizationCode was not suposed to be nil")
        
        if let authCode = UserDefaults.standard.authorizationCode {
            XCTAssertTrue(authCode == testConsts.authorizationCode, "AuthorizationCode should be equal to the constant authorizationCode:\(testConsts.authorizationCode)")
        }
    }
    
    func testAuthCodeThatDontExistYet() {
        UserDefaults.standard.removeObject(forKey: testConsts.authorizationCodeKey)
        XCTAssertTrue(UserDefaults.standard.authorizationCode == nil, "AuthorizationCode should be nil since it was deleted")
        UserDefaults.standard.set(testConsts.authorizationCode, forKey: testConsts.authorizationCodeKey)
    }
    
    func testBundle() {
        let bundle = Bundle.init(for: type(of: self))
        do {
            let result = try Utils(jsonArray: bundle.infoDictionary)
            XCTAssertTrue(result.urlScheme == "testuri")
        } catch let error {
            print(error.localizedDescription)
            XCTAssertTrue(false)
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
