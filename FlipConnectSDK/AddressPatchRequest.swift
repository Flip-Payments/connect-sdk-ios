//
//  AddressPatchRequest.swift
//  FlipConnectSDK
//
//  Created by Munir Wanis on 26/07/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import Foundation

class AddressPatchRequest: BasePatchRequest, PatchRequestProtocol {
    func add(operation: Operation, path: AddressPathEnum, value: String? = nil) {
        if patches == nil {
            patches = []
        }
        
        let patch = Patch(operation, path.rawValue, value)
        patches!.append(patch)
    }
}

enum AddressPathEnum: String {
    case street = "/street"
    case number = "/number"
    case complement = "/complement"
    case addressType = "/type"
    case district = "/district"
    case city = "/city"
    case state = "/state"
    case zipCode = "/zipCode"
    case addressReference = "/reference"
    case country = "/country"
}
