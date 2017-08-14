//
//  UsersResponse.swift
//  FlipConnectSDK
//
//  Created by Munir Wanis on 06/07/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import Foundation

public struct AccountResponse: Response {
    public var operationReport: [Report] = []
    
    public var success: Bool = false
    
    public private(set) var account: Account?
    
    public init(json: JSON) {
        self.initializeResponse(json: json)
        
        guard let account = (json["account"] as? JSON) else {
            return
        }
        
        self.account = Account(json: account)
    }
}
