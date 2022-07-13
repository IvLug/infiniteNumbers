//
//  AppDelegate.swift
//  InfinityNumbers
//
//  
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var appCoordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        startApp()
        return true
    }
    
    private func startApp() {
        let navigationController = UINavigationController()
        appCoordinator = AppCoordinator(navigationController)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        appCoordinator?.start()
    }
}

