//
//  AccountResponse.swift
//  FlipConnectSDK
//
//  Created by Munir Wanis on 24/07/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import Foundation

struct AccountResponse: Response {
    var operationReport: [Report] = []
    
    var success: Bool = false
    
    internal private(set) var account: Account?
    
    init(json: JSON) {
        self.initializeResponse(json: json)
        
        guard let account = (json["account"] as? JSON) else {
            return
        }
        
        self.account = Account(json: account)
    }
}
