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
    /// Public Profile
    case publicProfile = 0
    
    /// Personal Data
    case personalData
    
    /// Emails
    case emails
    
    /// Phones
    case phones
    
    /// Addresses
    case addresses
    
    /// Documents
    case documents
    
    /**
     Returns string version of enumerator
    */
    public func toString() -> String {
        switch self {
        case .publicProfile: return "Public Profile"
        case .personalData:  return "Personal Data"
        case .emails: return "Emails"
        case .phones: return "Phones"
        case .addresses: return "Addresses"
        case .documents: return "Documents"
        }
    }
    
    static func <(a: FCCategoriesEnum, b: FCCategoriesEnum) -> Bool {
        return a.rawValue < b.rawValue
    }
}
