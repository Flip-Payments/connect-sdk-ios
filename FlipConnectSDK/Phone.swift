//
//  Telephone.swift
//  FlipConnectSDK
//
//  Created by Munir Wanis on 27/06/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import Foundation

public struct Phone {
    public private(set) var key: String
    public private(set) var type: PhoneType
    public private(set) var typeFriendlyName: String
    public private(set) var fullNumber: String
    public private(set) var isValidated: Bool
    public private(set) var isPrimary: Bool
    
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
        self.type = phoneType
        self.typeFriendlyName = phoneTypeFriendlyName
        self.fullNumber = fullNumber
        self.isPrimary = isPrimary
        self.isValidated = isValidated        
    }
}

public enum PhoneType: String {
    case home
    case mobile
    case work
}
