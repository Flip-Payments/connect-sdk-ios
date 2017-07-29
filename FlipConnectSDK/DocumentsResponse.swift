//
//  DocumentsResponse.swift
//  FlipConnectSDK
//
//  Created by Munir Wanis on 04/07/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import Foundation

public struct DocumentsResponse: Response {
    public var operationReport: [Report] = []
    
    public var success: Bool = false
    
    public var documents: [Document] = []
    
    public init(json: JSON) {
        self.initializeResponse(json: json)
        
        guard let documents = json["documents"] as? [JSON] else {
            return
        }
        
        let document = documents.flatMap{ Document(json: $0) }
        
        self.documents = document
    }
}
