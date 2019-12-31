//
//  AppDelegate.swift
//  Assignment
//
//  Created by Senapathi Rajesh on 26/12/19.
//  Copyright © 2019 Senapathi Rajesh. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navigationController: UINavigationController?
   func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool{
    UINavigationBar.appearance().barTintColor = #colorLiteral(red: 0.5580356717, green: 0.9118073583, blue: 0.8641058803, alpha: 1)
    UINavigationBar.appearance().tintColor = UIColor.white
    UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemBlue]

       if #available(iOS 13.0, *) {
        } else {
               window = UIWindow(frame: UIScreen.main.bounds)
                      let mainVC = ItemsViewController()
                      navigationController  = UINavigationController(rootViewController: mainVC)
                      window?.rootViewController = navigationController
                      window?.makeKeyAndVisible()
        }
    return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        
    }
}
