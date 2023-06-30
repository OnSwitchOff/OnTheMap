//
//  UserInfo.swift
//  OnTheMap
//
//  Created by MacBook Pro on 30.06.23.
//

import Foundation

struct UserInfo: Codable {
    let last_name: String
    let social_accounts: [String]
    let mailing_address: String?
    let _cohort_keys: [String]
    let _signature: String?
    let _stripe_customer_id: String?
    let guard_info: GuardInfo
    let _facebook_id: String?
    let timezone: String?
    let site_preferences: String?
    let occupation: String?
    let _image: String?
    let first_name: String
    let jabber_id: String?
    let languages: [String]
    let _badges: [String]
    let location: String?
    let external_service_password: String?
    let _principals: [String]
    let _enrollments: [String]
    let email: EmailInfo
    let website_url: String?
    let external_accounts: [String]
    let bio: String?
    let coaching_data: String?
    let tags: [String]
    let _affiliate_profiles: [String]
    let _has_password: Bool
    let email_preferences: EmailPreferences
    let _resume: String?
    let key: String
    let nickname: String
    let employer_sharing: Bool
    let _memberships: [Membership]
    let zendesk_id: String?
    let _registered: Bool
    let linkedin_url: String?
    let _google_id: String?
    let _image_url: String
}

struct GuardInfo: Codable {
    let can_edit: Bool
    let permissions: [Permission]
    let allowed_behaviors: [String]
    let subject_kind: String
}

struct Permission: Codable {
    let derivation: [String]
    let behavior: String
    let principal_ref: PrincipalRef
}

struct PrincipalRef: Codable {
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
    let group_ref: PrincipalRef
    let creation_time: String?
    let expiration_time: String?
}
