//
//  EntitiesTests.swift
//  FlipConnectSDK
//
//  Created by Munir Wanis on 27/06/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import XCTest
import Foundation
@testable import FlipConnectSDK

class EntitiesTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testJSONtoAddressesConversion() {
        let addressesJSON = "{\"addresses\":[{\"id\":38,\"street\":\"Rua Balde Dagua\",\"number\":\"1200\",\"complement\":\"Apt 157\",\"addressType\":\"shipping\",\"addressTypeFriendlyName\":\"Shipping\",\"district\":\"Jigjoy\",\"city\":\"Rio de Janeiro\",\"state\":\"RJ\",\"zipCode\":\"12345-000\",\"addressReference\":null,\"country\":\"BR\"},{\"id\":63,\"street\":\"Rua do Catete\",\"number\":\"90\",\"complement\":\"Apt 171\",\"addressType\":\"home\",\"addressTypeFriendlyName\":\"Home\",\"district\":\"Ipanema\",\"city\":\"Rio de Janeiro\",\"state\":\"RJ\",\"zipCode\":\"22220-000\",\"addressReference\":null,\"country\":\"BR\"},{\"id\":64,\"street\":\"Rua Marquês de Abrantes\",\"number\":\"200\",\"complement\":\"Apt 157\",\"addressType\":\"work\",\"addressTypeFriendlyName\":\"Work\",\"district\":\"Ipanema\",\"city\":\"Rio de Janeiro\",\"state\":\"RJ\",\"zipCode\":\"22220-000\",\"addressReference\":null,\"country\":\"BR\"}],\"success\":true,\"operationReport\":[]}"
        
        let data = addressesJSON.data(using: String.Encoding.utf8)
        let json = try! JSONSerialization.jsonObject(with: data!, options: []) as! JSON
        
        let addresses = Addresses(json: json)
        
        XCTAssertTrue(addresses.success)
    }
    
    func testJSONtoTelephoneConversion() {
        let telephoneJSON = "{\"id\":193,\"phoneType\":\"mobile\",\"phoneTypeFriendlyName\":\"Celular\",\"fullNumber\":\"+5521987654321\",\"IsValidated\":false,\"isPrimary\":false}"
        
        let data = telephoneJSON.data(using: String.Encoding.utf8)
        let json = try! JSONSerialization.jsonObject(with: data!, options: []) as! JSON
        
        let telephone = Telephone(json: json)
        
        XCTAssertTrue(telephone?.type == .mobile)
    }
    
//    func testJSONtoDocumentConversion() {
//        let documentJSON = "{\"id\":86,\"documentType\":\"cpf\",\"documentTypeFriendlyName\":\"CPF\",\"documentNumber\":\"37692802963\",\"documentData\":{}"
//        
//        let data = documentJSON.data(using: String.Encoding.utf8)!
//        let json = try! JSONSerialization.jsonObject(with: data, options: []) as! JSON
//        
//        let document = Document(json: json)
//        
//        XCTAssertTrue(document?.type == .cpf)
//    }
    
    func testAPICallToCollectAddresses() {
        let requestExpectation = expectation(description: "Get addresses collection")
        
        FCApi.getAddresses(accessToken: "DF27C1F5237D3E1B9B3313C7543F04DD50642E87C560F7542498103A65981C16") { addresses, error in
            XCTAssertTrue(addresses.success)
            XCTAssertNil(error)
            requestExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 60, handler: nil)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
