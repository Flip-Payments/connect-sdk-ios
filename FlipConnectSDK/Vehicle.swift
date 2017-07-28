//
//  Vehicle.swift
//  FlipConnectSDK
//
//  Created by Munir Wanis on 28/07/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import Foundation

public struct Vehicle {
    public private(set) var licensePlate: String? = nil
    public private(set) var licensePlateCity: String? = nil
    public private(set) var licensePlateState: String? = nil
    public private(set) var licensePlateCountry: String? = nil
    
    init?(json: JSON) {
        self.licensePlate = json["licensePlate"] as? String
        self.licensePlateCity = json["licensePlateCity"] as? String
        self.licensePlateState = json["licensePlateState"] as? String
        self.licensePlateCountry = json["licensePlateCountry"] as? String
        
        if self.isEntityNull() { return nil }
    }
    
    init?(licensePlate: String? = nil,
        licensePlateCity: String? = nil,
        licensePlateState: String? = nil,
        licensePlateCountry: String? = nil) {
        
        self.licensePlate = licensePlate
        self.licensePlateCity = licensePlateCity
        self.licensePlateState = licensePlateState
        self.licensePlateCountry = licensePlateCountry
        
        if self.isEntityNull() { return nil }
    }
    
    private func isEntityNull() -> Bool {
        if licensePlate == nil,
            licensePlateCity == nil,
            licensePlateState == nil,
            licensePlateCountry == nil {
            return true
        }
        return false
    }
    
    func toDictionary() -> JSON {
        return [
            "licensePlate": self.licensePlate as Any,
            "licensePlateCity": self.licensePlateCity as Any,
            "licensePlateState": self.licensePlateState as Any,
            "licensePlateCountry": self.licensePlateCountry as Any
        ]
    }
}
