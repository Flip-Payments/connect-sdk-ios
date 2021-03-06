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
        let addressesJSON = "{\"addresses\":[{\"key\":\"8d6dc241-2f5c-e711-80c2-0003ff345086\",\"street\":\"Rua Balde Dagua\",\"number\":\"1200\",\"complement\":\"Apt 157\",\"addressType\":\"shipping\",\"addressTypeFriendlyName\":\"Shipping\",\"district\":\"Jigjoy\",\"city\":\"Rio de Janeiro\",\"state\":\"RJ\",\"zipCode\":\"12345-000\",\"addressReference\":null,\"country\":\"BR\"},{\"id\":63,\"street\":\"Rua do Catete\",\"number\":\"90\",\"complement\":\"Apt 171\",\"addressType\":\"home\",\"addressTypeFriendlyName\":\"Home\",\"district\":\"Ipanema\",\"city\":\"Rio de Janeiro\",\"state\":\"RJ\",\"zipCode\":\"22220-000\",\"addressReference\":null,\"country\":\"BR\"},{\"id\":64,\"street\":\"Rua Marquês de Abrantes\",\"number\":\"200\",\"complement\":\"Apt 157\",\"addressType\":\"work\",\"addressTypeFriendlyName\":\"Work\",\"district\":\"Ipanema\",\"city\":\"Rio de Janeiro\",\"state\":\"RJ\",\"zipCode\":\"22220-000\",\"addressReference\":null,\"country\":\"BR\"}],\"success\":true,\"operationReport\":[]}"
        
        let data = addressesJSON.data(using: String.Encoding.utf8)
        let json = try! JSONSerialization.jsonObject(with: data!, options: []) as! JSON
        
        let addresses = AddressesResponse(json: json)
        
        XCTAssertTrue(addresses.success)
        XCTAssertTrue(addresses.addresses.first?.key == "8d6dc241-2f5c-e711-80c2-0003ff345086")
    }
    
    func testJSONtoTelephoneConversion() {
        let telephoneJSON = "{\"key\":\"8d6dc241-2f5c-e711-80c2-0003ff345086\",\"phoneType\":\"mobile\",\"phoneTypeFriendlyName\":\"Celular\",\"fullNumber\":\"+5521987654321\",\"isValidated\":false,\"isPrimary\":false}"
        
        let data = telephoneJSON.data(using: String.Encoding.utf8)
        let json = try! JSONSerialization.jsonObject(with: data!, options: []) as! JSON
        
        let telephone = Phone(json: json)
        
        XCTAssertTrue(telephone?.phoneType == .mobile)
    }
    
    func testJSONtoDocumentConversion() {
        let documentJSON = "{\"key\":\"ea6dc241-2f5c-e711-80c2-0003ff345086\",\"documentType\":\"cpf\",\"documentTypeFriendlyName\":\"CPF\",\"documentNumber\":\"10916033759\",\"documentData\":{}}"
        
        let data = documentJSON.data(using: String.Encoding.utf8)!
        let json = try! JSONSerialization.jsonObject(with: data, options: []) as! JSON
        
        let document = Document(json: json)
        
        XCTAssertTrue(document?.documentType == .cpf)
    }
    
    func testJSONtoDocumentsConversion() {
        let documentsJSON = "{\"documents\":[{\"key\":\"ea6dc241-2f5c-e711-80c2-0003ff345086\",\"documentType\":\"cpf\",\"documentTypeFriendlyName\":\"CPF\",\"documentNumber\":\"10916033759\",\"documentData\":{}}],\"success\":true,\"operationReport\":[]}"
        
        let data = documentsJSON.data(using: String.Encoding.utf8)!
        let json = try! JSONSerialization.jsonObject(with: data, options: []) as! JSON
        
        let documents = DocumentsResponse(json: json)
        
        XCTAssertTrue(documents.documents[0].key == "ea6dc241-2f5c-e711-80c2-0003ff345086")
        XCTAssertTrue(documents.success)
        XCTAssertTrue(documents.documents[0].documentType == .cpf)

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
        
        XCTAssert(telephone?.phoneType == .home)
    }
    
    func testJSONtoUserEntityConversion() {
        let userJSON = "{\"accountKey\":\"5e2e42ce-0985-4d0c-88d3-0a02aed397b1\",\"isEnabled\":true,\"membershipCreateDate\":\"6/22/2017 10:04:37 PM\",\"isNewsLetterAllowed\":true,\"publicProfile\":{\"name\":\"Cesar Maia\",\"pictureUrl\":null},\"personalData\":null,\"emails\":[{\"key\":\"d16fc241-2f5c-e711-80c2-0003ff345086\",\"address\":\"h797176@mvrht.net\",\"isValidated\":true,\"isPrimary\":true}],\"phones\":[{\"key\":\"8d6dc241-2f5c-e711-80c2-0003ff345086\",\"phoneType\":\"mobile\",\"phoneTypeFriendlyName\":\"Celular\",\"fullNumber\":\"+5521987654321\",\"isValidated\":false,\"isPrimary\":false},{\"key\":\"8e6dc241-2f5c-e711-80c2-0003ff345086\",\"phoneType\":\"home\",\"phoneTypeFriendlyName\":\"Residencial\",\"fullNumber\":\"+5521123456789\",\"isValidated\":false,\"isPrimary\":false}]}"
        
        let data = userJSON.data(using: String.Encoding.utf8)!
        let json = try! JSONSerialization.jsonObject(with: data, options: []) as! JSON
        
        let user = Account(json: json)
        
        XCTAssert(user?.accountKey == "5e2e42ce-0985-4d0c-88d3-0a02aed397b1")
    }
    
    func testJSONtoUserResponseConversion() {
        let userJSON = "{\"account\":{\"accountKey\":\"5e2e42ce-0985-4d0c-88d3-0a02aed397b1\",\"isEnabled\":true,\"membershipCreateDate\":\"6/22/2017 10:04:37 PM\",\"isNewsLetterAllowed\":true,\"publicProfile\":{\"name\":\"Cesar Maia\",\"pictureUrl\":null},\"personalData\":null,\"emails\":[{\"key\":\"d16fc241-2f5c-e711-80c2-0003ff345086\",\"address\":\"h797176@mvrht.net\",\"isValidated\":true,\"isPrimary\":true}],\"phones\":[{\"key\":\"8d6dc241-2f5c-e711-80c2-0003ff345086\",\"phoneType\":\"mobile\",\"phoneTypeFriendlyName\":\"Celular\",\"fullNumber\":\"+5521987654321\",\"isValidated\":false,\"isPrimary\":false},{\"key\":\"8e6dc241-2f5c-e711-80c2-0003ff345086\",\"phoneType\":\"home\",\"phoneTypeFriendlyName\":\"Residencial\",\"fullNumber\":\"+5521123456789\",\"isValidated\":false,\"isPrimary\":false}]},\"success\":true,\"operationReport\":[]}"
        
        let data = userJSON.data(using: String.Encoding.utf8)!
        let json = try! JSONSerialization.jsonObject(with: data, options: []) as! JSON
        
        let user = AccountResponse(json: json)
        
        XCTAssert(user.account?.accountKey == "5e2e42ce-0985-4d0c-88d3-0a02aed397b1")
        XCTAssertTrue(user.success)
    }
    
    func testGetCountryName() {
        let countryName = PersonalData.getCountryName(countryCode: "BR")
        
        XCTAssert(countryName == "Brazil")
    }
    
    func testVehicleToJSONString() {
        let vehicle = Vehicle(licensePlate: "LNY-4266", licensePlateCity: "Rio de Janeiro", licensePlateState: "RJ")!
        let json = SerializationHelper.composeJSONStringFrom(dictionary: vehicle.toDictionary(), prettify: true)
        print(json ?? "nil vehicle")
        XCTAssertNotNil(json)
    }
    
    func testPersonalDataToJSONSring() {
        let personalData = PersonalData(genderType: .masculine, country: "BR", dependentCount: 3)!
        let json = SerializationHelper.composeJSONStringFrom(dictionary: personalData.toDictionary(), prettify: true)
        print(json ?? "nil personal data")
        XCTAssertNotNil(json)
    }
    
    func testAddressToJSONString() {
        let address = Address(street: "Conde de Bonfim", number: "800", addressType: .work, city: "Rio de Janeiro", state: "RJ", country: "Brazil")!
        let json = SerializationHelper.composeJSONStringFrom(dictionary: address.toDictionary(), prettify: true)
        print(json ?? "nil address")
        XCTAssertNotNil(json)
    }
    
    func testPhoneToJSONString() {
        let phone = Phone(fullNumber: "26113328")!
        let json = SerializationHelper.composeJSONStringFrom(dictionary: phone.toDictionary(), prettify: true)
        print(json ?? "nil phone")
        XCTAssertNotNil(json)
    }
    
    func testDocumentToJSONString() {
        let document = Document(documentType: .cpf, documentNumber: "12345678901")!
        let json = SerializationHelper.composeJSONStringFrom(dictionary: document.toDictionary(), prettify: true)
        print(json ?? "nil document")
        XCTAssertNotNil(json)
    }
    
    func testEmailToJSONString() {
        let email = Email(address: "some@email.com")!
        let json = SerializationHelper.composeJSONStringFrom(dictionary: email.toDictionary(), prettify: true)
        print(json ?? "nil email")
        XCTAssertNotNil(json)
    }
    
    func testTemporaryProfileToJSONString() {
        let personalData = PersonalData(genderType: .masculine, country: "BR", dependentCount: 3)!
        let vehicle = Vehicle(licensePlate: "LNY-4266", licensePlateCity: "Rio de Janeiro", licensePlateState: "RJ")!
        let vehicle2 = Vehicle(licensePlate: "LNY-4266", licensePlateCity: "Rio de Janeiro", licensePlateState: "RJ")!
        let document = Document(documentType: .cpf, documentNumber: "12345678901")!
        let phone = Phone(fullNumber: "26113328")!
        let phone2 = Phone(fullNumber: "26113328")!
        let address = Address(street: "Conde de Bonfim", number: "800", addressType: .work, city: "Rio de Janeiro", state: "RJ", country: "Brazil")!
        let address2 = Address(street: "Conde de Bonfim", number: "800", addressType: .work, city: "Rio de Janeiro", state: "RJ", country: "Brazil")!
        
        let temporaryProfileRequest = TemporaryProfile()
        temporaryProfileRequest.addresses = [address, address2]
        temporaryProfileRequest.documents = [document]
        temporaryProfileRequest.personalData = personalData
        temporaryProfileRequest.phones = [phone, phone2]
        temporaryProfileRequest.vehicles = [vehicle, vehicle2]
        
        let json = SerializationHelper.composeJSONStringFrom(dictionary: temporaryProfileRequest.toDictionary(), prettify: true)
        print(json ?? "nil temporaryProfileData")
        XCTAssertNotNil(json)
    }
    
    func testTemporaryProfileRequestToJSONString() {
        let personalData = PersonalData(genderType: .masculine, country: "BR", dependentCount: 3)!
        let vehicle = Vehicle(licensePlate: "LNY-4266", licensePlateCity: "Rio de Janeiro", licensePlateState: "RJ")!
        let vehicle2 = Vehicle(licensePlate: "LNY-4266", licensePlateCity: "Rio de Janeiro", licensePlateState: "RJ")!
        let document = Document(documentType: .cpf, documentNumber: "12345678901")!
        let phone = Phone(fullNumber: "26113328")!
        let phone2 = Phone(fullNumber: "26113328")!
        let address = Address(street: "Conde de Bonfim", number: "800", addressType: .work, city: "Rio de Janeiro", state: "RJ", country: "Brazil")!
        let address2 = Address(street: "Conde de Bonfim", number: "800", addressType: .work, city: "Rio de Janeiro", state: "RJ", country: "Brazil")!
        
        let temporaryProfile = TemporaryProfile()
        temporaryProfile.addresses = [address, address2]
        temporaryProfile.documents = [document]
        temporaryProfile.personalData = personalData
        temporaryProfile.phones = [phone, phone2]
        temporaryProfile.vehicles = [vehicle, vehicle2]
        
        var temporaryProfileRequest = TemporaryProfileRequest()
        temporaryProfileRequest.clientID = "ahsdfklahsdklf"
        temporaryProfileRequest.data = temporaryProfile
        
        let json = SerializationHelper.composeJSONStringFrom(dictionary: temporaryProfileRequest.toDictionary(), prettify: true)
        print(json ?? "nil temporaryProfileData")
        XCTAssertNotNil(json)
    }
}
