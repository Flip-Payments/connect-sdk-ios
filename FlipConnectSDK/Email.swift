//
//  Email.swift
//  FlipConnectSDK
//
//  Created by Munir Wanis on 27/06/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import Foundation

public struct Email {
    public private(set) var key: String?
    public private(set) var address: String?
    public private(set) var isValidated: Bool?
    public private(set) var isPrimary: Bool?
    
    init?(json: JSON) {
        guard let key = json["key"] as? String,
            let address = json["address"] as? String,
            let isValidated = json["isValidated"] as? Bool,
            let isPrimary = json["isPrimary"] as? Bool
            else {
                return nil
        }
        
        self.key = key
        self.address = address
        self.isValidated = isValidated
        self.isPrimary = isPrimary
        
        if isEntityNull() { return nil }
    }
    
    public init?(address: String? = nil) {
        self.address = address
        
        if isEntityNull() { return nil }
    }
    
    func isEntityNull() -> Bool {
        if key == nil,
            address == nil,
            isValidated == nil,
            isPrimary == nil {
            return true
        }
        return false
    }
    
    func toDictionary() -> JSON {
        return [
            "address": self.address as Any
        ]
    }
}
