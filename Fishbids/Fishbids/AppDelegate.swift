//
//  AppDelegate.swift
//  Fishbids
//
//  Created by Neo on 4/23/16.
//  Copyright © 2016 fishbids. All rights reserved.
//

import Bolts
import Parse
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    // required for using a main storyboard file
    var window: UIWindow?
    
    func applicationDidFinishLaunching(_ application: UIApplication) {
        let configuration = ParseClientConfiguration {
            $0.applicationId = "zNhS2riGMfJQrJUbhkobwb1cil518yNZSOFLn6m0"
            $0.clientKey = "2H7gXoFk04yR35VWo25VOHvJKJzjXT6A2tdrZCEb"
        }
        Parse.initialize(with: configuration)
    }
}

