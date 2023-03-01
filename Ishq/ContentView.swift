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
    @Environment(\.colorScheme) var colorScheme
    @State var accessToken: String = ""
    @State var error: String = ""
    @AppStorage("auth_status") var auth_status = false
    var body: some View {
        NavigationView {
            if auth_status{
                HomeScreen()
            } else {
                LoginView()
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
