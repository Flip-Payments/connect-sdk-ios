//
//  Response.swift
//  FlipConnectSDK
//
//  Created by Munir Wanis on 26/06/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import Foundation

public protocol Response {
    var success: Bool { get set }
    var operationReport: [Report] { get set }
    
    init(json: JSON)
}

extension Response {
    mutating func initializeResponse(json: JSON) {
        guard let success = json["success"] as? Bool else {
            self.success = false
            return
        }
        
        self.success = success
        
        guard let operationReportJSON = json["operationReport"] as? [JSON] else {
            self.operationReport = []
            return
        }
        
        self.operationReport = []

        let operationReport = operationReportJSON.flatMap({ operationReport in
            return Report(json: operationReport)
        })
        
        self.operationReport = operationReport
    }
}
