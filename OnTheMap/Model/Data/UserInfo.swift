//
//  UserInfo.swift
//  OnTheMap
//
//  Created by MacBook Pro on 30.06.23.
//

import Foundation

struct UserInfo: Codable {
    let last_name: String
}

struct UserInfo: Codable {
    let lastName: String
    let socialAccounts: [String]
    let mailingAddress: String?
    let cohortKeys: [String]
    let signature: String?
    let stripeCustomerId: String?
    let guardInfo: GuardInfo
    let facebookId: String?
    let timezone: String?
    let sitePreferences: String?
    let occupation: String?
    let image: String?
    let firstName: String
    let jabberId: String?
    let languages: [String]
    let badges: [String]
    let location: String?
    let externalServicePassword: String?
    let principals: [String]
    let enrollments: [String]
    let email: EmailInfo
    let websiteUrl: String?
    let externalAccounts: [String]
    let bio: String?
    let coachingData: String?
    let tags: [String]
    let affiliateProfiles: [String]
    let hasPassword: Bool
    let emailPreferences: EmailPreferences
    let resume: String?
    let key: String
    let nickname: String
    let employerSharing: Bool
    let memberships: [Membership]
    let zendeskId: String?
    let registered: Bool
    let linkedinUrl: String?
    let googleId: String?
    let imageUrl: String
}

struct GuardInfo: Codable {
    let canEdit: Bool
    let permissions: [Permission]
    let allowedBehaviors: [String]
    let subjectKind: String
}

struct Permission: Codable {
    let derivation: [String]
    let behavior: String
    let principalRef: PrincipalRef
}

struct PrincipalRef: Codable {
    let ref: String
    let key: String
}

struct EmailInfo: Codable {
    let verificationCodeSent: Bool
    let verified: Bool
    let address: String
}

struct EmailPreferences: Codable {
    let okUserResearch: Bool
    let masterOk: Bool
    let okCourse: Bool
}

struct Membership: Codable {
    let current: Bool
    let groupRef: PrincipalRef
    let creationTime: String?
    let expirationTime: String?
}
