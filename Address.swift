//
//  Address.swift
//  FlipConnectSDK
//
//  Created by Munir Wanis on 26/06/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import Foundation

struct Address {
    var id: Int
    var street: String
    var number: String
    var complement: String?
    var addressType: String
    var addressTypeFriendlyName: String?
    var district: String?
    var city: String
    var state: String
    var zipCode: String
    var addressReference: String?
    var country: String
    
    init?(json: [String:Any]) {
        guard let id = json["id"] as? Int,
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
        
        self.id = id
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
    }
}
