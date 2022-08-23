//
//  AppDelegate.swift
//  CurrencyConverter
//
//  Created by Ilya Volkov on 23.08.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
                
        let tabBarController = TabBarController()
        window?.rootViewController = tabBarController
        
        return true
    }

}

