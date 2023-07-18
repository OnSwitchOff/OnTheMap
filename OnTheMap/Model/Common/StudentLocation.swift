//
//  StudentLocation.swift
//  OnTheMap
//
//  Created by MacBook Pro on 30.06.23.
//

import Foundation

struct StudentLocation: Codable {
    var objectId: String?
    var uniqueKey: String
    var firstName: String
    var lastName: String
    var mapString: String
    var mediaURL: String
    var latitude: Double
    var longitude: Double
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
    
    init() {
        self.uniqueKey = ""
        self.firstName = ""
        self.lastName = ""
        self.mapString = ""
        self.mediaURL = ""
        self.latitude = 0
        self.longitude = 0
    }
}
