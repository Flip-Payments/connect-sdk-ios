//
//  FCEditCategoriesEnum.swift
//  FlipConnectSDK
//
//  Created by Munir Wanis on 14/07/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import Foundation

public enum FCEditCategoriesEnum: Int {
    case PublicProfile = 0
    case PersonalData
    case Emails
    case Phones
    case Addresses
    case Documents
    
    static func <(a: FCEditCategoriesEnum, b: FCEditCategoriesEnum) -> Bool {
        return a.rawValue < b.rawValue
    }
}
