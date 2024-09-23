//
//  PlaidError.swift
//
//
//  Created by Christopher Hicks on 8/7/24.
//

import Foundation

public struct PlaidError: Codable {
    public let error: String
    public let instId: String
    
    public init(error: String, instId: String) {
        self.error = error
        self.instId = instId
    }
}


/*
 "plaid_error": {
         "error": "Request failed with status code 400",
         "token": "access-production-34e51dbb-3524-47c8-afed-b89c8b3851e9",
         "instId": "ins_115611"
     }
 */
