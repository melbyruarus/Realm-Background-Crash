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
	}
}
