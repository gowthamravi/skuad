//
//  AppDelegate.swift
//  Skuad
//
//  Created by Ravikumar, Gowtham on 10/13/20.
//  Copyright © 2020 Ravikumar, Gowtham. All rights reserved.
//

import UIKit
import DropDown


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
        var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        DropDown.startListeningToKeyboard()
        return true
    }
}


