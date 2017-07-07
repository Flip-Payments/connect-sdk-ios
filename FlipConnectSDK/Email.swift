//
//  Email.swift
//  FlipConnectSDK
//
//  Created by Munir Wanis on 27/06/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import Foundation

struct Email {
    var key: String
    var address: String
    var isValidated: Bool
    var isPrimary: Bool
    
    init?(json: JSON) {
        guard let id = (json["id"] as? String ?? json["key"] as? String),
            let address = json["address"] as? String,
            let isValidated = json["isValidated"] as? Bool,
            let isPrimary = json["isPrimary"] as? Bool
            else {
                return nil
        }
        
        self.key = id
        self.address = address
        self.isValidated = isValidated
        self.isPrimary = isPrimary
    }
}
