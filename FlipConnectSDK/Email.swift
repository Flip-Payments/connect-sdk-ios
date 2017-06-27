//
//  Email.swift
//  FlipConnectSDK
//
//  Created by Munir Wanis on 27/06/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import Foundation

struct Email {
    var id: Int
    var email: String
    
    init?(json: JSON) {
        guard let id = json["id"] as? Int,
            let email = json["email"] as? String
            else {
                return nil
        }
        
        self.id = id
        self.email = email
    }
}
