//
//  OTMResponse.swift
//  OnTheMap
//
//  Created by MacBook Pro on 29.06.23.
//

import Foundation

struct OTMResponse: Codable {
    let statusCode: Int
    let statusMessage: String
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status"
        case statusMessage = "error"
    }
}

extension OTMResponse: LocalizedError {
    var errorDescription: String? {
        return statusMessage
    }
}
