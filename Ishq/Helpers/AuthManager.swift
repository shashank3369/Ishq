//
//  AuthManager.swift
//  Ishq
//
//  Created by Sishir Mohan on 2/19/24.
//

import Foundation
import Supabase

struct AppUser {
    let uid: String
    let phoneNumber: String?
}

class AuthManager {
    static let shared = AuthManager()
    
    private init() {}
    
    let client = SupabaseClient(supabaseURL: URL(string: "https://oxlgpnjntriecsthswat.supabase.co")!, supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im94bGdwbmpudHJpZWNzdGhzd2F0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDgxOTE4NTksImV4cCI6MjAyMzc2Nzg1OX0.ZjamjQbWl-YSWXcqGf_rUM5ldRb65zw01MPM6n8fVlI")
    
    func getCurrentSession() async throws -> AppUser {
        let session = try await client.auth.session
        print(session)
        print(session.user.id)
        return AppUser(uid: session.user.id.uuidString, phoneNumber: session.user.phone)
    }
    
    func signInWithPhoneNumber(phoneNumber: String) async throws  {
        try await SupabaseClient.shared.auth.signInWithOTP(phone: phoneNumber)
    }
    
    func verifyOTP(phoneNumber: String, otpToken: String) async throws -> AppUser {
        let session = try await client.auth.verifyOTP(phone: phoneNumber, token: otpToken, type: .sms)
        return AppUser(uid: session.user.id.uuidString, phoneNumber: session.user.phone)
    }
    
    func logOutUser() async throws {
        try await client.auth.signOut()
    }
}

