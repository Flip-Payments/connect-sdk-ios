//
//  FCColors.swift
//  FlipConnectSDK
//
//  Created by Munir Wanis on 08/06/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import Foundation

extension UIColor {
    static var flipGreen = UIColor(red: 0.002, green: 0.604, blue: 0.417, alpha: 1.000)
    static var flipWhite = UIColor(red: 0.984, green: 0.984, blue: 0.984, alpha: 1.000)
    static var flipDarkGray = UIColor(red: 0.176, green: 0.176, blue: 0.176, alpha: 1.000)
}

public enum FCColors {
    case green
    case white
    case darkGray
}

struct FCColorHelper {
    static func getUIColor(color: FCColors) -> (fromButton: UIColor, fromText: UIColor) {
        switch color {
        case .darkGray:
            return (UIColor.flipDarkGray, UIColor.flipWhite)
        case .white:
            return (UIColor.flipWhite, UIColor.flipDarkGray)
        case .green:
            return (UIColor.flipGreen, UIColor.flipWhite)
        default:
            return (UIColor.flipGreen, UIColor.flipWhite)
        }
    }
}
