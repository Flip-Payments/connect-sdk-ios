//
//  FCErrors.swift
//  FlipConnectSDK
//
//  Created by Munir Wanis on 06/06/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import Foundation

enum FCErrors: Error {
    case malformedURI
    case wrongParameters(message: String)
    case plistNotFound
    case configNotFound
    case urlNameDifferentFromIdentifier
    case urlSchemeDoesNotExist
    case incorrectIdentifier
}
