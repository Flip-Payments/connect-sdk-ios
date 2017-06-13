//
//  FCColors.swift
//  FlipConnectSDK
//
//  Created by Munir Wanis on 08/06/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import Foundation

public struct FCColors {
    /**
        Colors enumerator
        - green: the default color of FlipConnect
        - darkGray: dark neutral alternative
        - white: white neutral alternative
    */
    public enum Colors {
        case green
        case white
        case darkGray
    }
    
    static var flipGreen = UIColor(red: 0.002, green: 0.604, blue: 0.417, alpha: 1.000)
    static var flipWhite = UIColor(red: 0.984, green: 0.984, blue: 0.984, alpha: 1.000)
    static var flipDarkGray = UIColor(red: 0.176, green: 0.176, blue: 0.176, alpha: 1.000)
    
    /// Gets one of the default UIColors for button construction
    /// - Parameter color: Color enumerator
    /// - Returns: Two **UIColors**, one for the background color of the button and another for the text color
    public static func getUIColor(_ color: Colors) -> (fromButton: UIColor, fromText: UIColor) {
        switch color {
        case .darkGray:
            return (self.flipDarkGray, self.flipWhite)
        case .white:
            return (self.flipWhite, self.flipDarkGray)
        case .green:
            return (self.flipGreen, self.flipWhite)
        }
    }
}
