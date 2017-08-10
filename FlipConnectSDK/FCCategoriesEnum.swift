//
//  FCCategoriesEnum.swift
//  FlipConnectSDK
//
//  Created by Munir Wanis on 10/08/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import Foundation

/// Enum with possible categories in the API
public enum FCCategoriesEnum: Int {
    case PublicProfile = 0
    case PersonalData
    case Emails
    case Phones
    case Addresses
    case Documents
    
    /**
     Returns string version of enumerator
    */
    public func toString() -> String {
        switch self {
        case .PublicProfile: return "Public Profile"
        case .PersonalData:  return "Personal Data"
        case .Emails: return "Emails"
        case .Phones: return "Phones"
        case .Addresses: return "Addresses"
        case .Documents: return "Documents"
        }
    }
    
    static func <(a: FCCategoriesEnum, b: FCCategoriesEnum) -> Bool {
        return a.rawValue < b.rawValue
    }
}
