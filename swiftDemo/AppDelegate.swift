//
//  AppDelegate.swift
//  swiftDemo
//
//  Created by Mr.Zhang on 2021/7/17.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        loadMainViewController()
        return true
    }
    func loadMainViewController() -> Void {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = UIColor.white
        window?.rootViewController = MainViewController()
    }

}

