//
//  StudentLocation.swift
//  OnTheMap
//
//  Created by MacBook Pro on 30.06.23.
//

import Foundation

struct StudentLocation: Codable {
    var objectId: String?
    let uniqueKey: String
    let firstName: String
    let lastName: String
    let mapString: String
    let mediaURL: String
    let latitude: Double
    let longitude: Double
    var createdAt: String?
    var updatedAt: String?
    
    init(uniqueKey: String, firstName: String, lastName: String, mapString: String, mediaUrl: String, lat: Double, long: Double, objectId: String? = nil, createdAt: String? = nil, updatedAt: String? = nil) {
        self.uniqueKey = uniqueKey
        self.firstName = firstName
        self.lastName = lastName
        self.mapString = mapString
        self.mediaURL = mediaUrl
        self.latitude = lat
        self.longitude = long
        
        self.objectId = objectId
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
