//
//  UsersResponse.swift
//  FlipConnectSDK
//
//  Created by Munir Wanis on 06/07/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import Foundation

struct UserResponse: Response {
    var operationReport: [Report] = []
    
    var success: Bool = false
    
    var user: User?
    
    init(json: JSON) {
        self.initializeResponse(json: json)
        
        guard let user = json["user"] as? JSON else {
            return
        }
        
        self.user = User(json: user)
    }
}

struct UsersResponse: Response {
    var operationReport: [Report] = []
    
    var success: Bool = false
    
    var users: [User] = []
    
    init(json: JSON) {
        self.initializeResponse(json: json)
        
        guard let users = json["users"] as? [JSON] else {
            return
        }
        
        let user = users.flatMap{ User(json: $0) }
        
        self.users = user
    }
}
