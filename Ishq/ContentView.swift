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
@State var accessToken: String = ""
@State var error: String = ""

@available(iOS 15.0, *)
struct ContentView: View {
    @AppStorage("auth_status") var auth_status = false
    var body: some View {
        NavigationView {
            if auth_status{
                Text("Home").navigationTitle("Home")
            } else {
                PhoneAuthentication()
                VStack {
            SignInWithAppleView(accessToken: $accessToken, error: $error)
                .frame(width: 200, height: 50, alignment: .center)
            Text(self.accessToken)
            Text(self.error)
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
