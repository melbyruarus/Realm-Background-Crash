//
//  AppDelegate.swift
//  Crash
//
//  Created by Melby Ruarus on 27/11/14.
//  Copyright (c) 2014 Melby Ruarus. All rights reserved.
//

import UIKit
import Realm

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
	let window = UIWindow(frame: UIScreen.mainScreen().bounds)
	
	func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
		// Configure helpers
		RealmHelper.configureRealms()
		LocationHelper.sharedInstance().startUpdates()
				
		// Configure window
		window.rootViewController = UIViewController()
		window.makeKeyAndVisible()
		
		return true
	}
}

