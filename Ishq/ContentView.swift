//
//  ContentView.swift
//  Ishq
//
//  Created by Sishir Mohan on 11/22/22.
//

import SwiftUI
import AuthenticationServices
import RealmSwift

let appId = "ishq-uywcj"


@available(iOS 15.0, *)
struct ContentView: View {
    @State var accessToken: String = ""
    @State var error: String = ""
    @AppStorage("auth_status") var auth_status = false
    var body: some View {
        NavigationView {
            if auth_status{
                HomeScreen()
            } else {
                
            VStack {
            SignInWithAppleView(accessToken: $accessToken, error: $error)
                .frame(width: 200, height: 50, alignment: .center)
            Text(self.accessToken)
            Text(self.error)
                NavigationLink(destination: PhoneAuthentication()) {
                    Text("Sign in with Phone Number")
                }
                
                
        }
            }
        }
        
    }
}

@available(iOS 15.0, *)
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
