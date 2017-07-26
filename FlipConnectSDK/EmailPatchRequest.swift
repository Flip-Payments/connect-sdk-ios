//
//  EmailPatchRequest.swift
//  FlipConnectSDK
//
//  Created by Munir Wanis on 26/07/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import Foundation

class EmailPatchRequest: BasePatchRequest, PatchRequestProtocol {
    func add(operation: Operation, path: EmailPathEnum, value: String? = nil) {
        if patches == nil {
            patches = []
        }
        
        let patch = Patch(operation, path.rawValue, value)
        patches!.append(patch)
    }
}

enum EmailPathEnum: String {
    case address = "/address"
    case isPrimary = "/isPrimary"
}
