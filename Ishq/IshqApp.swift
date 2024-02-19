//
//  IshqApp.swift
//  Ishq
//
//  Created by Shashank Kothapalli on 11/13/22.
//

import SwiftUI
import FirebaseCore
import RealmSwift
import Supabase


//MARK: Set up firebase, supabase
class AppDelegate: NSObject, UIApplicationDelegate {
    
    override init() {
        super.init()
            for family in UIFont.familyNames.sorted() {
                let names = UIFont.fontNames(forFamilyName: family)
                print("Family: \(family) Font names: \(names)")
            }
        registerCustomFonts()
        }
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
    
    private func registerCustomFonts() {
        let fonts = Bundle.main.urls(forResourcesWithExtension: "ttf", subdirectory: nil)
        fonts?.forEach { url in
            CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
        }
    }
    
  //OTP requires Remote Notification
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) async -> UIBackgroundFetchResult {
        return .noData
    }
}

@available(iOS 15.0, *)
@main
struct IshqApp: SwiftUI.App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

