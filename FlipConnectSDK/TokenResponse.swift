//
//  TokenResponse.swift
//  FlipConnectSDK
//
//  Created by Munir Wanis on 09/08/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import Foundation

public struct TokenResponse: Response {
    public var operationReport: [Report] = []
    
    public var success: Bool = false
    
    public var accessToken: String? = nil
    
    public var refreshToken: String? = nil
    
    public var userKey: String? = nil
    
    public init(json: JSON) {
        self.initializeResponse(json: json)
        
        self.userKey = json["userKey"] as? String
        self.accessToken = json["accessToken"] as? String
        self.refreshToken = json["refreshToken"] as? String
    }
}
