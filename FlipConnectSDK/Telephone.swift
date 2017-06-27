//
//  Telephone.swift
//  FlipConnectSDK
//
//  Created by Munir Wanis on 27/06/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import Foundation

struct Telephone {
    var id: Int
    var phoneType: PhoneType
    var phoneTypeFriendlyName: String
    var fullNumber: String
    
    init?(json: JSON) {
        guard let id = json["id"] as? Int,
            let phoneType = PhoneType(rawValue: (json["phoneType"] as? String)!),
            let phoneTypeFriendlyName = json["phoneTypeFriendlyName"] as? String,
            let fullNumber = json["fullNumber"] as? String
            else {
                return nil
        }
        
        self.id = id
        self.phoneType = phoneType
        self.phoneTypeFriendlyName = phoneTypeFriendlyName
        self.fullNumber = fullNumber
        
    }
}

enum PhoneType: String {
    case home
    case mobile
    case work
}
