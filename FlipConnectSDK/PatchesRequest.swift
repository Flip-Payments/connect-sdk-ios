//
//  PatchesRequest.swift
//  FlipConnectSDK
//
//  Created by Munir Wanis on 27/06/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import Foundation

class Patch {
    var op: Operation
    
    var path: String
    
    var value: String?
    
    init(_ operation: Operation, _ path: String, _ value: String? = nil) {
        self.op = operation
        self.path = path
        self.value = value
    }
    
    func createDictionary() -> JSON {
        return [
            "op": self.op.rawValue,
            "path": self.path,
            "value": self.value as Any
        ]
    }
}

class Patches {
    var publicProfile: PublicProfilePatchRequest? = nil
    var personalData: PersonalDataPatchRequest? = nil
    var emails: [EmailPatchRequest]? = nil
    var phones: [PhonePatchRequest]? = nil
    var addresses: [AddressPatchRequest]? = nil
    var documents: [DocumentPatchRequest]? = nil
    
    func createDictionary() -> JSON {
        
        var emailsDictionary: [JSON]? = nil
        if let emails = emails {
            emailsDictionary = []
            for email in emails {
                emailsDictionary!.append(email.createDictionary())
            }
        }
        
        var phonesDictionary: [JSON]? = nil
        if let phones = phones {
            phonesDictionary = []
            for phone in phones {
                phonesDictionary!.append(phone.createDictionary())
            }
        }
        
        var addressesDictionary: [JSON]? = nil
        if let addresses = addresses {
            addressesDictionary = []
            for address in addresses {
                addressesDictionary!.append(address.createDictionary())
            }
        }
        
        var documentsDictionary: [JSON]? = nil
        if let documents = documents {
            documentsDictionary = []
            for document in documents {
                documentsDictionary!.append(document.createDictionary())
            }
        }
        
        return [
            "publicProfile": self.publicProfile?.createDictionary() as Any,
            "personalData": self.personalData?.createDictionary() as Any,
            "emails": emailsDictionary as Any,
            "phones": phonesDictionary as Any,
            "addresses": addressesDictionary as Any,
            "documents": documentsDictionary as Any
        ]
    }
}

enum Operation: String {
    case replace
    case remove
}
