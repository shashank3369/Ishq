//
//  SignInWithAppleCoordinator.swift
//  Ishq
//
//  Created by Shashank Kothapalli on 11/26/22.
//

import Foundation
import RealmSwift
import AuthenticationServices
import SwiftUI
import Realm

class SignInCoordinator: ASLoginDelegate {
    var parent: SignInWithAppleView
    var app: RealmSwift.App
    @AppStorage("auth_status") var auth_status = false

    init(parent: SignInWithAppleView) {
        self.parent = parent
        app = App(id: appId)
        app.authorizationDelegate = self
    }

    @objc func didTapLogin() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]

        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        app.setASAuthorizationControllerDelegate(for: authorizationController)
        authorizationController.performRequests()
    }

    func authenticationDidComplete(error: Error) {
        parent.error = error.localizedDescription
    }

    func authenticationDidComplete(user: RLMUser) {
        parent.accessToken = user.accessToken ?? "Could not get access token"
        auth_status = true
    }
}
