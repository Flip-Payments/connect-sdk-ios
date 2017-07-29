//
//  PhonePatchRequest.swift
//  FlipConnectSDK
//
//  Created by Munir Wanis on 26/07/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import Foundation

class PhonePatchRequest: BasePatchRequest, PatchRequestProtocol {
    func add(operation: Operation, path: PhonePathEnum, value: String? = nil) {
        if patches == nil {
            patches = []
        }
        
        let patch = Patch(operation, path.rawValue, value)
        patches!.append(patch)
    }
}

enum PhonePathEnum: String {
    case phoneType = "/phoneType"
    case fullNumber = "/fullNumber"
    case isPrimary = "/isPrimary"
}
