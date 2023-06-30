//
//  SessionInfo.swift
//  OnTheMap
//
//  Created by MacBook Pro on 30.06.23.
//

import Foundation

struct SessionInfo: Codable {
    
    let id: String
    let expiration: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case expiration
    }
}
