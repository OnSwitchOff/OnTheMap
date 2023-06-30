//
//  UserInfo.swift
//  OnTheMap
//
//  Created by MacBook Pro on 30.06.23.
//

import Foundation

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
    let languages: [String]?
    let badges: [String]?
    let location: String?
    let externalServicePassword: String?
    let principals: [String]?
    let enrollments: [String]?
    let email: EmailInfo
    let websiteUrl: String?
    let externalAccounts: [String]?
    let bio: String?
    let coachingData: String?
    let tags: [String]?
    let affiliateProfiles: [String]?
    let hasPassword: Bool
    let emailPreferences: EmailPreferences?
    let resume: String?
    let key: String
    let nickname: String
    let employerSharing: Bool
    let memberships: [Membership]?
    let zendeskId: String?
    let registered: Bool
    let linkedinUrl: String?
    let googleId: String?
    let imageUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case lastName = "last_name"
        case socialAccounts = "social_accounts"
        case mailingAddress = "mailing_address"
        case cohortKeys = "_cohort_keys"
        case signature = "_signature"
        case stripeCustomerId = "_stripe_customer_id"
        case guardInfo = "guard"
        case facebookId = "_facebook_id"
        case timezone
        case sitePreferences = "site_preferences"
        case occupation
        case image = "_image"
        case firstName = "first_name"
        case jabberId = "jabber_id"
        case languages
        case badges = "_badges"
        case location
        case externalServicePassword = "external_service_password"
        case principals = "_principals"
        case enrollments = "_enrollments"
        case email
        case websiteUrl = "website_url"
        case externalAccounts = "external_accounts"
        case bio = "bio"
        case coachingData = "coaching_data"
        case tags
        case affiliateProfiles = "_affiliate_profiles"
        case hasPassword = "_has_password"
        case emailPreferences = "email_preferences"
        case resume = "_resume"
        case key
        case nickname = "nickname"
        case employerSharing = "employer_sharing"
        case memberships = "_memberships"
        case zendeskId = "zendesk_id"
        case registered = "_registered"
        case linkedinUrl = "linkedin_url"
        case googleId = "_google_id"
        case imageUrl = "_image_url"
    }
}

struct GuardInfo: Codable {
    let can_edit: Bool?
    let permissions: [Permission]?
    let allowed_behaviors: [String]?
    let subject_kind: String?
}

struct Permission: Codable {
    let derivation: [String]
    let behavior: String
    let principal_ref: RefKey
}

struct RefKey: Codable {
    let ref: String
    let key: String
}

struct EmailInfo: Codable {
    let _verification_code_sent: Bool
    let _verified: Bool
    let address: String
}

struct EmailPreferences: Codable {
    let ok_user_research: Bool
    let master_ok: Bool
    let ok_course: Bool
}

struct Membership: Codable {
    let current: Bool
    let group_ref: RefKey
    let creation_time: String?
    let expiration_time: String?
}
