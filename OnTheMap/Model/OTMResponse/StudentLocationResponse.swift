//
//  StudentLocation.swift
//  OnTheMap
//
//  Created by MacBook Pro on 29.06.23.
//
import Foundation

struct StudentLocationResponse: Codable {
    let results: [StudentLocation]
}

struct StudentLocation: Codable {
    
    let objectId: String
    let uniqueKey: String
    let firstName: String
    let lastName: String
    let mapString: String
    let mediaURL: String
    let latitude: Double
    let longitude: Double
    let createdAt: String
    let updatedAt: String
}
