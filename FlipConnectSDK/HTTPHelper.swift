//
//  HTTPHelper.swift
//  FlipConnectSDK
//
//  Created by Munir Wanis on 07/06/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import Foundation

enum HTTPVerb: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

typealias Parameters = [String: String]

typealias Headers = [String: String]
