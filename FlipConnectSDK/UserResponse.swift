//
//  UsersResponse.swift
//  FlipConnectSDK
//
//  Created by Munir Wanis on 06/07/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import Foundation

public struct UserResponse: Response {
    public var operationReport: [Report] = []
    
    public var success: Bool = false
    
    public private(set) var user: User?
    
    public init(json: JSON) {
        self.initializeResponse(json: json)
        
        guard let user = (json["user"] as? JSON ?? json["account"] as? JSON) else {
            return
        }
        
        self.user = User(json: user)
    }
}
