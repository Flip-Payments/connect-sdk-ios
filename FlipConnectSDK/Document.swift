//
//  Document.swift
//  FlipConnectSDK
//
//  Created by Munir Wanis on 27/06/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import Foundation

public struct Document {
    public private(set) var key: String?
    public private(set) var documentType: DocumentType?
    public private(set) var documentTypeFriendlyName: String?
    public private(set) var documentNumber: String?
    public private(set) var data: JSON?
    
    init?(json: JSON) {
        guard let key = json["key"] as? String,
            let type = DocumentType(rawValue: (json["documentType"] as? String)!),
            let typeFriendlyName = json["documentTypeFriendlyName"] as? String,
            let number = json["documentNumber"] as? String
            else {
                return nil
        }
        
        self.key = key
        self.documentType = type
        self.documentTypeFriendlyName = typeFriendlyName
        self.documentNumber = number
        self.data = json["documentData"] as? JSON
        
        if isEntityNull() { return nil }
    }
    
    public init?(documentType: DocumentType? = nil, documentNumber: String? = nil) {
        self.documentType = documentType
        self.documentNumber = documentNumber
        if isEntityNull() { return nil }
    }
    
    private func isEntityNull() -> Bool {
        if key == nil,
            documentType == nil,
            documentTypeFriendlyName == nil,
            documentNumber == nil,
            data == nil{
            return true
        }
        return false
    }
    
    func toDictionary() -> JSON {
        return [
            "documentType": self.documentType?.rawValue as Any,
            "documentNumber": self.documentNumber as Any
        ]
    }
}

public enum DocumentType: String {
    case cpf
    case cnpj
    case cnh
    case passport
}
