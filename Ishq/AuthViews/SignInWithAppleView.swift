//
//  SignInWithAppleView.swift
//  Ishq
//
//  Created by Shashank Kothapalli on 11/26/22.
//

import SwiftUI
import AuthenticationServices
import RealmSwift

struct SignInWithAppleView: UIViewRepresentable {
    @Environment(\.colorScheme) var colorScheme
    
    @Binding var accessToken: String
    @Binding var error: String

    func makeCoordinator() -> SignInCoordinator {
        return SignInCoordinator(parent: self)
    }

    func makeUIView(context: Context) -> ASAuthorizationAppleIDButton {
        let buttonStyle:ASAuthorizationAppleIDButton.Style = colorScheme == .dark ? .white : .black
        let button = ASAuthorizationAppleIDButton(authorizationButtonType: .signIn, authorizationButtonStyle: buttonStyle)
        button.addTarget(context.coordinator, action: #selector(context.coordinator.didTapLogin), for: .touchUpInside)
        return button
    }

    func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: Context) {

    }
}

struct SignInWithAppleView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SignInWithAppleView(accessToken: .constant(""), error: .constant(""))
        }
    }
}
