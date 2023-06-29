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

struct AccountInfo: Codable {
    
    let registered: Bool
    let key: String
    
    enum CodingKeys: String, CodingKey {
        case registered
        case key
    }
}

struct SessionInfo: Codable {
    
    let id: String
    let expiration: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case expiration
    }
}

