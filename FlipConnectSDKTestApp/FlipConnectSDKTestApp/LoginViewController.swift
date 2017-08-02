//
//  LoginViewController.swift
//  FlipConnectSDKTestApp
//
//  Created by Munir Wanis on 30/06/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import UIKit
import FlipConnectSDK

class LoginViewController: UIViewController {
    
    //http://flipconnect-signin-staging.herokuapp.com/?clientId=F7F667C7-199F-4A10-B53A-4FADCDFADB53&redirectUri=ipirangaConnect://authorize&responseType=code
    
    var fcLogin: FCLogin!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 0.862, green: 0.862, blue: 0.862, alpha: 1.000)
        
        guard let fcLogin = Configuration.fcLogin else {
            return
        }
        
        self.fcLogin = fcLogin
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        let birthdate = formatter.date(from: "1997/12/17")
        
        let personalData = PersonalData(birthdate: birthdate, genderType: .masculine, country: "br", dependentCount: 3)!
        let vehicle = Vehicle(licensePlate: "LNY-4266", licensePlateCity: "Rio de Janeiro", licensePlateState: "RJ", licensePlateCountry: "br")!
        let vehicle2 = Vehicle(licensePlate: "LNY-4266", licensePlateCity: "Rio de Janeiro", licensePlateState: "RJ", licensePlateCountry: "br")!
        let document = Document(documentType: .cpf, documentNumber: "12345678901")!
        let phone = Phone(phoneType: .mobile, fullNumber: "26113328")!
        let phone2 = Phone(phoneType: .home, fullNumber: "26113328")!
        let address = Address(street: "Conde de Bonfim", number: "800", addressType: .work, city: "Rio de Janeiro", state: "RJ", country: "br")!
        let address2 = Address(street: "Conde de Bonfim", number: "800", addressType: .work, city: "Rio de Janeiro", state: "RJ", country: "br")!
        
        let temporaryProfile = TemporaryProfile()
        temporaryProfile.addresses = [address, address2]
        temporaryProfile.documents = [document]
        temporaryProfile.personalData = personalData
        temporaryProfile.phones = [phone, phone2]
        temporaryProfile.vehicles = [vehicle, vehicle2]
        
        let btn = fcLogin.loginWithButton(center: view.center, temporaryProfile: temporaryProfile)
        
        self.fcLogin.temporaryProfile = nil
        let btn2 = fcLogin.loginWithButton(center: CGPoint(x: view.center.x, y: view.center.y - 50), color: .darkGray)
        
        let btn3 = fcLogin.loginWithButton(center: CGPoint(x: view.center.x, y: view.center.y + 50), color: .white)
        
        view.addSubview(btn)
        view.addSubview(btn2)
        view.addSubview(btn3)
    }
}
