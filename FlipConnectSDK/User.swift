//
//  User.swift
//  FlipConnectSDK
//
//  Created by Munir Wanis on 05/07/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import Foundation

struct User {
    var acountKey: String
    var isEnabled: Bool
    var membershipCreateDate: Date
    var isNewsLetterllowed: Bool
    var publicProfile: PublicProfile?
    var emails: [Email]
    var phones: [Phone]
}
