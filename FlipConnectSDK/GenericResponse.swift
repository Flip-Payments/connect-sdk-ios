//
//  GenericResponse.swift
//  FlipConnectSDK
//
//  Created by Munir Wanis on 27/07/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import Foundation

struct GenericResponse: Response {
    var operationReport: [Report] = []
    var success: Bool = false
    
    init(json: JSON) {
        initializeResponse(json: json)
    }
}
