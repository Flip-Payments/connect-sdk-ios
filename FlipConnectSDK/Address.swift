//
//  Address.swift
//  FlipConnectSDK
//
//  Created by Munir Wanis on 26/06/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import Foundation

public struct Address {
    public private(set) var key: String?
    public private(set) var street: String?
    public private(set) var number: String?
    public private(set) var complement: String?
    public private(set) var addressType: AddressTypeEnum?
    public private(set) var addressTypeFriendlyName: String?
    public private(set) var district: String?
    public private(set) var city: String?
    public private(set) var state: String?
    public private(set) var zipCode: String?
    public private(set) var addressReference: String?
    public private(set) var country: String?
    
    init?(json: JSON) {
        guard let key = json["key"] as? String,
        let street = json["street"] as? String,
        let number = json["number"] as? String,
        let addressTypeString = json["addressType"] as? String,
        let addressType = AddressTypeEnum(rawValue: addressTypeString),
        let city = json["city"] as? String,
        let state = json["state"] as? String,
        let zipCode = json["zipCode"] as? String,
        let country = json["country"] as? String
            else {
                return nil
        }
        
        self.key = key
        self.street = street
        self.number = number
        self.complement = json["complement"] as? String
        self.addressType = addressType
        self.addressTypeFriendlyName = json["addressTypeFriendlyName"] as? String
        self.district = json["district"] as? String
        self.city = city
        self.state = state
        self.zipCode = zipCode
        self.addressReference = json["addressReference"] as? String
        self.country = country
        
        if isEntityNull() { return nil }
    }
    
    public init?(street: String? = nil,
                 number: String? = nil,
                 complement: String? = nil,
                 addressType: AddressTypeEnum? = nil,
                 district: String? = nil,
                 city: String? = nil,
                 state: String? = nil,
                 zipCode: String? = nil,
                 addressReference: String? = nil,
                 country: String? = nil) {
        
        self.street = street
        self.number = number
        self.complement = complement
        self.addressType = addressType
        self.district = district
        self.city = city
        self.state = state
        self.zipCode = zipCode
        self.addressReference = addressReference
        self.country = country
        
        if isEntityNull() { return nil }
    }
    
    func isEntityNull() -> Bool {
        if street == nil,
            number == nil,
            complement == nil,
            addressType == nil,
            district == nil,
            city == nil,
            state == nil,
            zipCode == nil,
            addressReference == nil,
            country == nil{
            
            return true
        }
        return false
    }
    
    func toDictionary() -> JSON {
        return [
            "street": self.street as Any,
            "number": self.number as Any,
            "complement": self.complement as Any,
            "addressType": self.addressType?.rawValue as Any,
            "district": self.district as Any,
            "city": self.city as Any,
            "state": self.state as Any,
            "addressReference": self.addressReference as Any,
            "country": self.country as Any
        ]
    }
}
