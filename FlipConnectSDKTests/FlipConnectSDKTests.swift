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
            let result = try FCRedirectHandler(bundle: bundle.infoDictionary)
            XCTAssertTrue(result.urlScheme == "testuri")
        } catch {
            print("\(error)")
            XCTFail()
        }
    }
    
    func testWebUrlMount() {
        let bundle = Bundle.init(for: type(of: self))
        do {
            let redirectHandler = try FCRedirectHandler(bundle: bundle.infoDictionary)
            
            let testRedirectUri = "testing://test"
            let urlRequest = URL(string: FCApiUrls.connectWebUrl)!
            let clientID = UUID().uuidString

            let url = redirectHandler.mountWebURL(url: urlRequest, withRedirectUri: testRedirectUri, andID: clientID)
            
            let expected = "\(FCApiUrls.connectWebUrl)?client_id=\(clientID)&redirect_uri=\(testRedirectUri)&state=\(UserDefaults.standard.state!)&response_type=code"
            
            XCTAssertTrue(expected == url.absoluteString)
        } catch {
            print("\(error)")
            XCTFail()
        }
    }
    
    func testApiRequest() {
        let parameters: Parameters = [
            "grantType": "authorization_code",
            "authorizationCode": "29bd29a5-b62c-4876-9e5f-572ee9c53ed9",
            "redirectUri": "https://www.ipiranga.com.br"
        ]
        
        let requestExpectation = expectation(description: "Make successful API Call")
        
        FCApi.request(toURL: URL(string: "\(FCApiUrls.connectApiUrl)oauth/token")!, withVerb: .post, withParameters: parameters) { response, error in
            XCTAssertTrue(response.count > 0)
            XCTAssertNil(error)
            requestExpectation.fulfill()
        }
        waitForExpectations(timeout: 60, handler: nil)
    }
    
    func testNSLocaleExtenstion() {
        let locales = NSLocale.locales()
        for locale in locales {
            print("\(locale.countryCode) - \(locale.countryName)")
        }
        
        let isBrazil = locales.contains(where: { $0.countryName == "Brazil" })
        XCTAssertTrue(isBrazil)
    }
}
