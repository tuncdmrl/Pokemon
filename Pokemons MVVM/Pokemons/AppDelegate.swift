//
//  AppDelegate.swift
//  Pokemons
//
//  Created by tunc on 15.07.2025.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?

  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
    let storyboard = UIStoryboard(name: "Home", bundle: nil)
    let navController = storyboard.instantiateInitialViewController() as! UINavigationController
    _ = navController.viewControllers.first as! HomeViewController

    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = navController
    window?.makeKeyAndVisible()
    
    return true
  }
}
