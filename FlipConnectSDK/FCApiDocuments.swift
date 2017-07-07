//
//  FCApiDocuments.swift
//  FlipConnectSDK
//
//  Created by Munir Wanis on 04/07/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import Foundation

extension FCApi {
    static func getDocuments(accessToken token: String, completion: @escaping (_ documents: DocumentsResponse, _ error: Error?) -> Void) {
        let headers: Headers = [
            "Accept-Language": "en-US",
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "bearer \(token)"
        ]
        
        var err: Error? = nil
        FCApi.request(toURL: URL(string: "\(FCConsts.connectUserManagementUrl)user/account/documents")!, withVerb: .get, withParameters: nil, withHeaders: headers) { response, error in
            let documents = DocumentsResponse(json: response)
            guard error == nil else {
                err = error
                completion(documents, err)
                return
            }
            
            completion(documents, err)
        }
    }
}
