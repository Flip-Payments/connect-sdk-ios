//
//  Address.swift
//  FlipConnectSDK
//
//  Created by Munir Wanis on 26/06/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import Foundation

public struct Address {
    public private(set) var key: String
    public private(set) var street: String
    public private(set) var number: String
    public private(set) var complement: String?
    public private(set) var type: String
    public private(set) var typeFriendlyName: String?
    public private(set) var district: String?
    public private(set) var city: String
    public private(set) var state: String
    public private(set) var zipCode: String
    public private(set) var addressReference: String?
    public private(set) var country: String
    
    public init?(json: JSON) {
        guard let key = json["key"] as? String,
        let street = json["street"] as? String,
        let number = json["number"] as? String,
        let addressType = json["addressType"] as? String,
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
        self.type = addressType
        self.typeFriendlyName = json["addressTypeFriendlyName"] as? String
        self.district = json["district"] as? String
        self.city = city
        self.state = state
        self.zipCode = zipCode
        self.addressReference = json["addressReference"] as? String
        self.country = country
    }
}
