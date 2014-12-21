//
//  LogItem.swift
//  Crash
//
//  Created by Melby Ruarus on 6/12/14.
//  Copyright (c) 2014 Melby Ruarus. All rights reserved.
//

import Foundation
import Realm

class LogItem: RLMObject {
	dynamic var message = ""
	dynamic var timestamp: NSDate!
}
