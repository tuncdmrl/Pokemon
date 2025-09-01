//
//  UIStoryboardExtension.swift
//  swipe-ios
//
//  Created by tunc on 07.07.2025.
//

import UIKit

extension UIStoryboard {
  static func viewController<T: UIViewController>(fromStoryboard storyboardName: String) -> T {
    guard Bundle.main.path(forResource: storyboardName, ofType: "storyboardc") != nil else {
      let message = "\n🚨 Storyboard \"\(storyboardName)\" not found.\n"
      debugPrint(message)
      fatalError(message)
    }
    
    let storyboard = UIStoryboard(name: storyboardName, bundle: .main)
    
    guard let viewController = storyboard.instantiateInitialViewController() as? T else {
      let message = "\n🚨 View controller \"\(String(describing: T.self))\" not set as \"InitialViewController\".\n👨‍🏫 It can be set from stroyboard.\n"
      debugPrint(message)
      fatalError(message)
    }
    
    return viewController
  }
}
