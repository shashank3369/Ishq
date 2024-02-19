//
//  SupabaseManager.swift
//  Ishq
//
//  Created by Sishir Mohan on 2/17/24.
//
import Foundation
import Supabase

extension SupabaseClient {
    static let shared = SupabaseClient(supabaseURL: URL(string: "https://oxlgpnjntriecsthswat.supabase.co")!, supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im94bGdwbmpudHJpZWNzdGhzd2F0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDgxOTE4NTksImV4cCI6MjAyMzc2Nzg1OX0.ZjamjQbWl-YSWXcqGf_rUM5ldRb65zw01MPM6n8fVlI")
    
}
