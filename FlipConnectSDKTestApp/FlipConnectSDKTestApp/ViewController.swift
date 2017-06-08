//
//  ViewController.swift
//  FlipConnectSDKTestApp
//
//  Created by Munir Wanis on 07/06/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import UIKit
import FlipConnectSDK

class ViewController: UIViewController {
    
    //http://flipconnect-signin-staging.herokuapp.com/?clientId=F7F667C7-199F-4A10-B53A-4FADCDFADB53&redirectUri=ipirangaConnect://authorize&responseType=code
    
    var loginFlip: FCLogin!

    @IBAction func printAllUserDefaults(_ sender: UIButton) {
        print("accessToken: \(String(describing: UserDefaults.standard.accessToken))")
        print("refreshToken: \(String(describing: UserDefaults.standard.refreshToken))")
        print("clientID: \(String(describing: UserDefaults.standard.clientID))")
        print("authCode: \(String(describing: UserDefaults.standard.authorizationCode))")
        print("state: \(String(describing: UserDefaults.standard.state))")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            loginFlip = try FCLogin()
        } catch {
            print(error)
        }        
        
        loginFlip.loginButtonClicked()
        
//        loginFlip.openLoginURL()
        
        // Add a custom login button to your app
        let myLoginButton = UIButton(type: .custom)
        myLoginButton.backgroundColor = UIColor.darkGray
        myLoginButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        myLoginButton.frame = CGRect(x: 0, y: 0, width: 180, height: 40)
        myLoginButton.center = view.center;
        myLoginButton.setTitle("Login to FlipConnect", for: .normal)
        
        // Handle clicks on the button
        myLoginButton.addTarget(self, action: #selector(self.loginButtonClicked), for: .touchUpInside)

        // Add the button to the view
        view.addSubview(myLoginButton)
    }

    // Once the button is clicked, show the login dialog
    @objc func loginButtonClicked() {
        loginFlip.openLoginURL()
    }
    
    func hue() {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()!
        
        //// Color Declarations
        let green = UIColor(red: 0.002, green: 0.604, blue: 0.417, alpha: 1.000)
        let white = UIColor(red: 0.984, green: 0.984, blue: 0.984, alpha: 1.000)
        
        //// Shadow Declarations
        let blackShadow = NSShadow()
        blackShadow.shadowColor = UIColor.black.withAlphaComponent(0.7)
        blackShadow.shadowOffset = CGSize(width: 2, height: 1)
        blackShadow.shadowBlurRadius = 5
        
        //// Rectangle Drawing
        let rectangleRect = CGRect(x: 30, y: 38, width: 180, height: 40)
        let rectanglePath = UIBezierPath(rect: rectangleRect)
        green.setFill()
        rectanglePath.fill()
        let rectangleTextContent = "Login to FlipConnect"
        context.saveGState()
        context.setShadow(offset: blackShadow.shadowOffset, blur: blackShadow.shadowBlurRadius, color: (blackShadow.shadowColor as! UIColor).cgColor)
        let rectangleStyle = NSMutableParagraphStyle()
        rectangleStyle.alignment = .center
        let rectangleFontAttributes = [NSFontAttributeName: UIFont(name: "AvenirNext-Regular", size: UIFont.buttonFontSize)!, NSForegroundColorAttributeName: white, NSParagraphStyleAttributeName: rectangleStyle]
        
        let rectangleTextHeight: CGFloat = rectangleTextContent.boundingRect(with: CGSize(width: rectangleRect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: rectangleFontAttributes, context: nil).height
        context.saveGState()
        context.clip(to: rectangleRect)
        rectangleTextContent.draw(in: CGRect(x: rectangleRect.minX, y: rectangleRect.minY + (rectangleRect.height - rectangleTextHeight) / 2, width: rectangleRect.width, height: rectangleTextHeight), withAttributes: rectangleFontAttributes)
        context.restoreGState()
        context.restoreGState()
    }

}

