//
//  PersonalDataPatchRequest.swift
//  FlipConnectSDK
//
//  Created by Munir Wanis on 25/07/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import Foundation

class PersonalDataPatchRequest: BasePatchRequest, PatchRequestProtocol {
    func add(operation: Operation, path: PersonalDataPathEnum, value: String? = nil) {
        if patches == nil {
            patches = []
        }
        
        let patch = Patch(operation, path.rawValue, value)
        patches!.append(patch)
    }
}

enum PersonalDataPathEnum: String {
    case birthdate = "/birthdate"
    case genderType = "/type"
    case dependentCount = "/dependentCount"
    case country = "/country"
}
