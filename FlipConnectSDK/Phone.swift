//
//  Telephone.swift
//  FlipConnectSDK
//
//  Created by Munir Wanis on 27/06/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import Foundation

public struct Phone {
    public private(set) var key: String?
    public private(set) var phoneType: PhoneType?
    public private(set) var phoneTypeFriendlyName: String?
    public private(set) var fullNumber: String?
    public private(set) var isValidated: Bool?
    public private(set) var isPrimary: Bool?
    
    init?(json: JSON) {
        guard let key = json["key"] as? String,
            let phoneType = PhoneType(rawValue: (json["phoneType"] as? String)!),
            let phoneTypeFriendlyName = json["phoneTypeFriendlyName"] as? String,
            let fullNumber = json["fullNumber"] as? String,
            let isValidated = json["isValidated"] as? Bool,
            let isPrimary = json["isPrimary"] as? Bool
            else {
                return nil
        }
        
        self.key = key
        self.phoneType = phoneType
        self.phoneTypeFriendlyName = phoneTypeFriendlyName
        self.fullNumber = fullNumber
        self.isPrimary = isPrimary
        self.isValidated = isValidated
        
        if isEntityNull() { return nil }
    }
    
    public init?(phoneType: PhoneType? = nil,
          fullNumber: String? = nil) {
        self.fullNumber = fullNumber
        self.phoneType = phoneType
        
        if isEntityNull() { return nil }
    }
    
    private func isEntityNull() -> Bool {
        if key == nil,
            phoneType == nil,
            phoneTypeFriendlyName == nil,
            fullNumber == nil,
            isValidated == nil,
            isPrimary == nil {
            return true
        }
        return false
    }
    
    func toDictionary() -> JSON {
        return [
            "phoneType": self.phoneType?.rawValue as Any,
            "fullNumber": self.fullNumber as Any
        ]
    }
}

public enum PhoneType: String {
    case home
    case mobile
    case work
}
