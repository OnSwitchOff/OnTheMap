//
//  AccountInfo.swift
//  OnTheMap
//
//  Created by MacBook Pro on 30.06.23.
//

import Foundation

struct AccountInfo: Codable {
    
    let registered: Bool
    let key: String
    
    enum CodingKeys: String, CodingKey {
        case registered
        case key
    }
}
