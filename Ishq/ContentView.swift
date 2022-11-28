//
//  ContentView.swift
//  Ishq
//
//  Created by Shashank Kothapalli on 11/13/22.
//

import SwiftUI
import AuthenticationServices
import RealmSwift

let appId = "ishq-uywcj"

struct ContentView: View {
    @State var accessToken: String = ""
    @State var error: String = ""

    var body: some View {
        VStack {
            SignInWithAppleView(accessToken: $accessToken, error: $error)
                .frame(width: 200, height: 50, alignment: .center)
            Text(self.accessToken)
            Text(self.error)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
