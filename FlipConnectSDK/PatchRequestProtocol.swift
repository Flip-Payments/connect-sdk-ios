//
//  File.swift
//  FlipConnectSDK
//
//  Created by Munir Wanis on 25/07/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import Foundation

protocol PatchRequestProtocol {
    associatedtype EnumType
    
    func add(operation: Operation, path: EnumType, value: String?)
}
