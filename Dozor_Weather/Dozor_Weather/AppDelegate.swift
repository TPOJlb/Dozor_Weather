//
//  AppDelegate.swift
//  Dozor_Weather
//
//  Created by Muraviov Kyrylo on 27.09.2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let screenRect = UIScreen.main.bounds
        window = UIWindow(frame: screenRect)
        
        if let window = self.window {
            let appNavVC = MainNavigationController()
            window.rootViewController = appNavVC
            window.makeKeyAndVisible()
        }
        
        return true
    }
}
