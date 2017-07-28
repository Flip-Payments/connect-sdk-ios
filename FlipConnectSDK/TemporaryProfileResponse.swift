//
//  TemporaryProfileResponse.swift
//  FlipConnectSDK
//
//  Created by Munir Wanis on 28/07/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import Foundation

struct TemporaryProfileResponse: Response {
    var operationReport: [Report] = []
    var success: Bool = false
    var dataKey: String? = nil
    
    init(json: JSON) {
        initializeResponse(json: json)
        
        self.dataKey = json["dataKey"] as? String
    }
}
