//
//  Telephone.swift
//  FlipConnectSDK
//
//  Created by Munir Wanis on 27/06/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import Foundation

struct Phone {
    var id: String
    var type: PhoneType
    var typeFriendlyName: String
    var fullNumber: String
    var isValidated: Bool
    var isPrimary: Bool
    
    init?(json: JSON) {
        guard let id = (json["id"] as? String ?? json["key"] as? String),
            let phoneType = PhoneType(rawValue: (json["phoneType"] as? String)!),
            let phoneTypeFriendlyName = json["phoneTypeFriendlyName"] as? String,
            let fullNumber = json["fullNumber"] as? String,
            let isValidated = json["isValidated"] as? Bool,
            let isPrimary = json["isPrimary"] as? Bool
            else {
                return nil
        }
        
        self.id = id
        self.type = phoneType
        self.typeFriendlyName = phoneTypeFriendlyName
        self.fullNumber = fullNumber
        self.isPrimary = isPrimary
        self.isValidated = isValidated        
    }
}

enum PhoneType: String {
    case home
    case mobile
    case work
}
