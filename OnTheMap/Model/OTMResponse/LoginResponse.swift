//
//  LoginResponse.swift
//  OnTheMap
//
//  Created by MacBook Pro on 29.06.23.
//

import Foundation

struct LoginResponse: Codable {
    
    let account: AccountInfo
    let session: SessionInfo
    
    enum CodingKeys: String, CodingKey {
        case account
        case session
    }
}





