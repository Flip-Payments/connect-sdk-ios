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
    var operationReport: [Report] { get set }
}

struct Report {
    var field: String
    var message: String
}
