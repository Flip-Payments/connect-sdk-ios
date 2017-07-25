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
        
        let addresses = AddressesResponse(json: json)
        
        XCTAssertTrue(addresses.success)
    }
    
    func testJSONtoTelephoneConversion() {
        let telephoneJSON = "{\"key\":\"8d6dc241-2f5c-e711-80c2-0003ff345086\",\"phoneType\":\"mobile\",\"phoneTypeFriendlyName\":\"Celular\",\"fullNumber\":\"+5521987654321\",\"isValidated\":false,\"isPrimary\":false}"
        
        let data = telephoneJSON.data(using: String.Encoding.utf8)
        let json = try! JSONSerialization.jsonObject(with: data!, options: []) as! JSON
        
        let telephone = Phone(json: json)
        
        XCTAssertTrue(telephone?.type == .mobile)
    }
    
    func testJSONtoDocumentConversion() {
        let documentJSON = "{\"id\":86,\"documentType\":\"cpf\",\"documentTypeFriendlyName\":\"CPF\",\"documentNumber\":\"37692802963\",\"documentData\":{}}"
        
        let data = documentJSON.data(using: String.Encoding.utf8)!
        let json = try! JSONSerialization.jsonObject(with: data, options: []) as! JSON
        
        let document = Document(json: json)
        
        XCTAssertTrue(document?.type == .cpf)
    }
    
    func testJSONtoDocumentsConversion() {
        let documentsJSON = "{\"documents\":[{\"id\":86,\"documentType\":\"cpf\",\"documentTypeFriendlyName\":\"CPF\",\"documentNumber\":\"37692802963\",\"documentData\":{}},{\"id\":115,\"documentType\":\"cnpj\",\"documentTypeFriendlyName\":\"CNPJ\",\"documentNumber\":\"23873167000162\",\"documentData\":{}},{\"id\":116,\"documentType\":\"cnh\",\"documentTypeFriendlyName\":\"CNH\",\"documentNumber\":\"1234567901\",\"documentData\":{}}],\"success\":true,\"operationReport\":[]}"
        
        let data = documentsJSON.data(using: String.Encoding.utf8)!
        let json = try! JSONSerialization.jsonObject(with: data, options: []) as! JSON
        
        let documents = DocumentsResponse(json: json)
        
        XCTAssertTrue(documents.documents[0].id == 86)
        XCTAssertTrue(documents.success)
        XCTAssertTrue(documents.documents[0].type == .cpf)

    }
    
    func testJSONtoPublicProfileConversion() {
        let ppJSON = "{\"name\": \"Cesar Maia\",\"pictureUrl\": null }"
        
        let dataPP = ppJSON.data(using: String.Encoding.utf8)!
        let jsonPP = try! JSONSerialization.jsonObject(with: dataPP, options: []) as! JSON
        
        let pp = PublicProfile(json: jsonPP)
        
        XCTAssertNil(pp?.pictureURL)
        XCTAssert(pp?.name == "Cesar Maia")
        
        let ppNilJSON = "{\"name\": null,\"pictureUrl\": null }"
        
        let dataNilPP = ppNilJSON.data(using: String.Encoding.utf8)!
        let jsonNilPP = try! JSONSerialization.jsonObject(with: dataNilPP, options: []) as! JSON
        
        let ppNil = PublicProfile(json: jsonNilPP)
        
        XCTAssertNil(ppNil)
    }
    
    func testJSONtoPublicTelephoneConversion() {
        let telephoneJSON = "{\"key\":\"8e6dc241-2f5c-711-80c2-0003ff345086\",\"phoneType\":\"home\",\"phoneTypeFriendlyName\":\"Residencial\",\"fullNumber\":\"+5521123456789\",\"isValidated\":false,\"isPrimary\":false}"
        
        let data = telephoneJSON.data(using: String.Encoding.utf8)!
        let json = try! JSONSerialization.jsonObject(with: data, options: []) as! JSON
        
        let telephone = Phone(json: json)
        
        XCTAssert(telephone?.type == .home)
    }
    
    func testJSONtoUserEntityConversion() {
        let userJSON = "{\"accountKey\":\"5e2e42ce-0985-4d0c-88d3-0a02aed397b1\",\"isEnabled\":true,\"membershipCreateDate\":\"6/22/2017 10:04:37 PM\",\"isNewsLetterAllowed\":true,\"publicProfile\":{\"name\":\"Cesar Maia\",\"pictureUrl\":null},\"personalData\":null,\"emails\":[{\"key\":\"d16fc241-2f5c-e711-80c2-0003ff345086\",\"address\":\"h797176@mvrht.net\",\"isValidated\":true,\"isPrimary\":true}],\"phones\":[{\"key\":\"8d6dc241-2f5c-e711-80c2-0003ff345086\",\"phoneType\":\"mobile\",\"phoneTypeFriendlyName\":\"Celular\",\"fullNumber\":\"+5521987654321\",\"isValidated\":false,\"isPrimary\":false},{\"key\":\"8e6dc241-2f5c-e711-80c2-0003ff345086\",\"phoneType\":\"home\",\"phoneTypeFriendlyName\":\"Residencial\",\"fullNumber\":\"+5521123456789\",\"isValidated\":false,\"isPrimary\":false}]}"
        
        let data = userJSON.data(using: String.Encoding.utf8)!
        let json = try! JSONSerialization.jsonObject(with: data, options: []) as! JSON
        
        let user = User(json: json)
        
        XCTAssert(user?.accountKey == "5e2e42ce-0985-4d0c-88d3-0a02aed397b1")
    }
    
    func testJSONtoUserResponseConversion() {
        let userJSON = "{\"user\":{\"accountKey\":\"5e2e42ce-0985-4d0c-88d3-0a02aed397b1\",\"isEnabled\":true,\"membershipCreateDate\":\"6/22/2017 10:04:37 PM\",\"isNewsLetterAllowed\":true,\"publicProfile\":{\"name\":\"Cesar Maia\",\"pictureUrl\":null},\"personalData\":null,\"emails\":[{\"key\":\"d16fc241-2f5c-e711-80c2-0003ff345086\",\"address\":\"h797176@mvrht.net\",\"isValidated\":true,\"isPrimary\":true}],\"phones\":[{\"key\":\"8d6dc241-2f5c-e711-80c2-0003ff345086\",\"phoneType\":\"mobile\",\"phoneTypeFriendlyName\":\"Celular\",\"fullNumber\":\"+5521987654321\",\"isValidated\":false,\"isPrimary\":false},{\"key\":\"8e6dc241-2f5c-e711-80c2-0003ff345086\",\"phoneType\":\"home\",\"phoneTypeFriendlyName\":\"Residencial\",\"fullNumber\":\"+5521123456789\",\"isValidated\":false,\"isPrimary\":false}]},\"success\":true,\"operationReport\":[]}"
        
        let data = userJSON.data(using: String.Encoding.utf8)!
        let json = try! JSONSerialization.jsonObject(with: data, options: []) as! JSON
        
        let user = UserResponse(json: json)
        
        XCTAssert(user.user?.accountKey == "5e2e42ce-0985-4d0c-88d3-0a02aed397b1")
        XCTAssertTrue(user.success)
    }
    
    func testJSONtoAccountResponseConversion() {
        let accountJSON = "{\"account\":{\"accountKey\":\"83159889-b4a5-48ca-bb01-6ebaf3418bb1\",\"isEnabled\":true,\"isNewsLetterAllowed\":false,\"publicProfile\":{\"name\":\"Ganondorf Dragmire\",\"pictureUrl\":null},\"personalData\":{\"birthdate\":\"1985-05-15\",\"genderType\":\"masculine\",\"genderTypeFriendlyName\":\"Masculino\",\"dependentCount\":0,\"country\":null},\"emails\":[{\"key\":\"8e6fc241-2f5c-e711-80c2-0003ff345086\",\"address\":\"ipiranga@mailinator.com\",\"isValidated\":true,\"isPrimary\":false}],\"phones\":[{\"key\":\"466dc241-2f5c-e711-80c2-0003ff345086\",\"phoneType\":\"mobile\",\"phoneTypeFriendlyName\":\"Celular\",\"fullNumber\":\"+5521999999999\",\"isValidated\":false,\"isPrimary\":false}]},\"success\":true,\"operationReport\":[]}"
        
        let data = accountJSON.data(using: String.Encoding.utf8)!
        let json = try! JSONSerialization.jsonObject(with: data, options: []) as! JSON
        
        let account = AccountResponse(json: json)
        
        XCTAssert(account.account?.accountKey == "83159889-b4a5-48ca-bb01-6ebaf3418bb1")
        XCTAssertTrue(account.success)
    }
    
    func testPatchesToJSONConversion() {
        let patches = Patches()
        patches.publicProfile = PublicProfilePatchRequest()
        patches.publicProfile?.add(operation: .replace, path: .name, value: "John")
        patches.publicProfile?.add(operation: .remove, path: .pictureUrl, value: "")
        let json = SerializationHelper.composeJSONStringFrom(dictionary: patches.createDictionary())
        print(json ?? "f o d e u")
        XCTAssertNotNil(json)
        XCTAssertTrue(json!.contains("/name"))
    }
}
