//
//  ContentView.swift
//  Ishq
//
//  Created by Sishir Mohan on 11/22/22.
//

import SwiftUI

@available(iOS 15.0, *)
struct ContentView: View {
    @AppStorage("auth_status") var auth_status = false
    var body: some View {
        NavigationView {
            if auth_status{
                Text("Home").navigationTitle("Home")
            } else {
                PhoneAuthentication()
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
