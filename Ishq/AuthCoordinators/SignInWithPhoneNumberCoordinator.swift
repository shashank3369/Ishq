//
//  PhoneAuthViewModel.swift
//  Ishq
//
//  Created by Sishir Mohan on 11/24/22.
//

import SwiftUI
import Firebase
import RealmSwift

class SignInWithPhoneNumberCoordinator: ObservableObject {
   
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
            initiateSynchronizationWithRealm() { (success,error) in // now try to connect to Realm
                                if error == nil { // option 1: Firebase and Realm sign in both were successful
                                    DispatchQueue.main.async { [self] in
                                       auth_status = true
                                    }
                                } else { // option 2: an error occured signing in to Realm
                                    DispatchQueue.main.async {
                                        print(error?.localizedDescription)
                                        // do whatever you want in case an error occurred (suggest to sign-out from Firebase)
                                    }
                                }
                            }
            
        } catch{
            handleError(error: error.localizedDescription)
        }
    }
    
    func initiateSynchronizationWithRealm(completionHandler: @escaping (Bool?, Swift.Error?) -> Void) {
        self.loadSyncedUserRealm() { (success,error) in
            if error != nil { // something went wrong when trying to connect to Realm
                completionHandler(false,error)
            } else { // everything is fine, connection to Realm established
                completionHandler(true,nil)
            }
        }
    }
    
    func loadSyncedUserRealm(completionHandler: @escaping (Bool?, Swift.Error?) -> Void) {
            getSyncUser() { (realmUser,error) in // first, try to retrieve a Realm sync user
                if error != nil { // sync user could not be retrieved
                    print("Realm user could not be retrieved: (\(String(describing: error)))\n")
                    completionHandler(false,error)
                } else { // a Realm sync user could be retrieved
                    print("Received a Realm user: \(String(describing: realmUser?.id))")
                    guard let realmUser = realmUser else { return }
                    //guard let firebaseUserId = getCurrentFirebaseId() else { return }
                    let realmUserId = realmUser.id
                    print("realm User id is ", realmUserId)
                    completionHandler(true,nil)
                    // in the next line, you probably want to construct your partition string based on the user id
                    
                    //MARK: Will uncomment the following code after enabling realm sync
//                    let config = realmUser.configuration(partitionValue: "put-your-partition-string-here")
//                    Realm.asyncOpen(configuration: config) { [weak self](result) in
//                        switch result {
//                        case .failure(let error): // not able to open the Realm
//                            print("Not able to open user's private sync Realm: (\(error))\n")
//                            print(error.localizedDescription)
//                            completionHandler(false,error)
//                        case .success(_): // able to open the Realm
//                            print("Successfully opened user's private synced Realm (\(String(describing: realmUserId)))")
//                            completionHandler(true,nil)
//                        }
//                    }
                }
            }
        }

    
    private func getSyncUser(completionHandler: @escaping (RealmSwift.User?, Swift.Error?) -> Void) {
            Auth.auth().currentUser?.getIDToken(){ (idToken, error) in // retrieve the token directly from the Firebase user
                if error == nil, let token = idToken {
                    let credentials = Credentials.jwt(token: token) // create the credentials for Realm based on the token
                    self.app.login(credentials: credentials, { (result) in
                        switch result {
                        case .failure(let error): // something went wrong
                            print("Login failed: \(error.localizedDescription)")
                            completionHandler(nil,error)
                        case .success(let user): // login to MongoDB Realm was successful
                            print("Successfully logged in as user \(user)")
                            let user = self.app.currentUser
                            completionHandler(user,nil)
                        }
                    })
                }else{
                    print("Error receiving Firebase token")
                    completionHandler(nil,error)
                }
            }
        }
}

