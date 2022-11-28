//
//  PhoneAuthViewModel.swift
//  Ishq
//
//  Created by Sishir Mohan on 11/24/22.
//

import SwiftUI
import Firebase
import RealmSwift

class PhoneAuthViewModel: ObservableObject {
   
    @Published var phoneNumber: String = ""
    @Published var code: String = ""
    @Published var otpText: String = ""
    @Published var otpFields: [String] = Array(repeating: "", count: 6)
    
    //MARK: Error
    @Published var showAlert: Bool = false
    @Published var errorMsg: String = ""
    
    //MARK: OTP Credentials
    @Published var verificationCode: String = ""
    
    @Published var isLoading: Bool = false
    
    @Published var navigationTag: String?
    @AppStorage("auth_status") var auth_status = false
    let app = App(id: "ishq-uywcj")
    
    //Mark: Sending OTP
    func sendOTP()async{
        do{
            print("Attempting to send phone number ")
            let result = try await PhoneAuthProvider.provider().verifyPhoneNumber("+1\(phoneNumber)", uiDelegate: nil)
            DispatchQueue.main.async {
                self.isLoading = false
                self.verificationCode = result
                self.navigationTag = "PHONE_VERIFICATION"
            }
        } catch{
            
        }
    }
    
    func handleError(error: String) {
        DispatchQueue.main.async {
            self.isLoading = false
            self.errorMsg = error
            self.showAlert.toggle()
        }
    }
    
    func verifyOTP()async{
        do{
            print("ATTEMPTING TO VERIFY CODE")
            let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationCode, verificationCode: otpText)
            let _ = try await Auth.auth().signIn(with: credential)
            guard let firebaseAuthToken = try await Auth.auth().currentUser?.getIDToken() else { return <#default value#> }
            let realmCredentials = Credentials.jwt(token: firebaseAuthToken)
            app.login(credentials: realmCredentials, { (result) in})
            DispatchQueue.main.async {[self] in
                auth_status = true
            }
        } catch{
            handleError(error: error.localizedDescription)
        }
    }
}

