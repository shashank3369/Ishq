//
//  PhoneAuthViewModel.swift
//  Ishq
//
//  Created by Sishir Mohan on 11/24/22.
//

import SwiftUI
import Firebase
import RealmSwift
import Supabase
import Combine

class PhoneAuthViewModel: ObservableObject {
    
    @Published var phoneNumber: String = ""
    @Published var code: String = ""
    @Published var otpToken: String = ""
    @Published var otpFields: [String] = Array(repeating: "", count: 6)
    
    
    //MARK: Error
    @Published var showAlert: Bool = false
    @Published var errorMsg: String = ""
    
    //MARK: OTP Credentials
    
    @Published var isLoading: Bool = false
    
    @Published var navigationTag: String?
    @AppStorage("auth_status") var auth_status = false
    let app = App(id: "ishq-uywcj")


    //Mark: Sending OTP
    func sendOTP()async{
       
        do {
            let digits = phoneNumber.filter { $0.isNumber }
            try await AuthManager.shared.signInWithPhoneNumber(phoneNumber: "+1\(digits)")
            DispatchQueue.main.async {
                self.navigationTag = "PHONE_VERIFICATION"
            }
            
        } catch {
            print("Something went wrong trying to send OTP ", error.localizedDescription)
            handleError(error: error.localizedDescription)
        }
    }
    
    
    func handleError(error: String) {
        DispatchQueue.main.async {
            self.isLoading = false
            self.errorMsg = error
            self.showAlert.toggle()
        }
    }
    
    func verifyOTP() async throws -> AppUser {
        do{
            DispatchQueue.main.async {
                self.isLoading = true
            }
            let digits = phoneNumber.filter { $0.isNumber }
            let appUser = try await AuthManager.shared.verifyOTP(
                phoneNumber: "+1\(digits)",
                otpToken: otpToken
            )
            DispatchQueue.main.async { [self] in
                auth_status = true
                self.isLoading = false
            }
            print("App User is ", appUser)
            return appUser
        } catch{
            handleError(error: error.localizedDescription)
            throw NSError()
        }
    }
    
  
    
    func logOut() async throws {
        do {
            let currentSession = try await AuthManager.shared.getCurrentSession()
            try await AuthManager.shared.logOutUser()
            DispatchQueue.main.async { [self] in
                auth_status = false
            }
        } catch {
            handleError(error: error.localizedDescription)
            throw NSError()
        }
          
        
    }
}

