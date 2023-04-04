//
//  BitRealApp.swift
//  BitReal
//
//  Created by Ali Al-Adhami on 2/22/23.
//

import SwiftUI
import FirebaseCore


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct BitRealApp: App {
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    // initialize user session env-obj
    @StateObject var viewModel = AuthViewModel()
    
    var body: some Scene {
        WindowGroup {
//            ImageSelector()
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
