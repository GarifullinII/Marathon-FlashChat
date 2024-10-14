//
//  AppDelegate.swift
//  FlashChat
//
//  Created by Ildar Garifullin on 14/10/2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        startApplication()
        return true
    }
    
    private func startApplication() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = WelcomeViewController()
        self.window?.makeKeyAndVisible()
    }
}

