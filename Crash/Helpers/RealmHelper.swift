//
//  RealmHelper.swift
//  Crash
//
//  Created by Melby Ruarus on 1/12/14.
//  Copyright (c) 2014 Melby Ruarus. All rights reserved.
//

import Foundation
import Realm

class RealmHelper {
	class func configureRealms() {
		RLMRealm.setSchemaVersion(0, withMigrationBlock: { (migration, oldSchemaVersion) -> Void in
			// Do nothing
		})
		
		// Create the realm if it isn't already there
		RLMRealm.defaultRealm()
		
		// Disable data protection
		var error: NSError?
		if !NSFileManager.defaultManager().setAttributes([NSFileProtectionKey: NSFileProtectionCompleteUntilFirstUserAuthentication], ofItemAtPath: RLMRealm.defaultRealmPath(), error: &error) {
			NSLog("Error disabling data protection on realm: \(error)")
		}
	}
}
