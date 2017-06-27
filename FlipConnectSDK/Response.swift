//
//  Response.swift
//  FlipConnectSDK
//
//  Created by Munir Wanis on 26/06/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import Foundation

protocol Response {
    var success: Bool { get set }
    var operationReport: [Report]? { get set }
}

struct Report {
    var field: String
    var message: String
    
    init?(json: [String:Any]) {
        guard let field = json["field"] as? String,
        let message = json["message"] as? String
            else {
                return nil
        }
        
        self.field = field
        self.message = message
    }
}
