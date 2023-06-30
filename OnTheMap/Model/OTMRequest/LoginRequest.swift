//
//  LoginRequest.swift
//  OnTheMap
//
//  Created by MacBook Pro on 29.06.23.
//

import Foundation

struct LoginRequest: Codable {
    
    let udacity: LoginPair
    
    enum CodingKeys: String, CodingKey {
        case udacity
    }
    
    init(name: String, password: String){
        udacity = LoginPair(username: name, password: password)
    }
}

struct LoginPair: Codable {
    
    let username: String
    let password: String
    
    enum CodingKeys: String, CodingKey {
        case username
        case password
    }
}
