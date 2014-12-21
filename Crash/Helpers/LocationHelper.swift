//
//  LocationHelper.swift
//  Crash
//
//  Created by Melby Ruarus on 6/12/14.
//  Copyright (c) 2014 Melby Ruarus. All rights reserved.
//

import Foundation
import CoreLocation
import Realm

private let instance = LocationHelper()

class LocationHelper: NSObject, CLLocationManagerDelegate {
	class func sharedInstance() -> LocationHelper {
		return instance
	}
	
	let locationManager = CLLocationManager()
	let realmPath: String
	
	override init() {
		realmPath = RLMRealm.defaultRealm().path
		
		super.init()
		
		locationManager.delegate = self
	}
	
	func startUpdates() {
		locationManager.pausesLocationUpdatesAutomatically = true
		locationManager.distanceFilter = kCLDistanceFilterNone
		locationManager.desiredAccuracy = kCLLocationAccuracyBest
		
		locationManager.requestAlwaysAuthorization()
	}
	
	func stopUpdates() {
		locationManager.stopUpdatingLocation()
	}
	
	func log(message: String, atTime: NSDate? = nil) {
		let fh = fopen(realmPath.cStringUsingEncoding(NSUTF8StringEncoding)!, "r")
		if fh == nil {
			// App will subsequently crash because realm is encrypted at this point
			NSLog("Write will fail and app will crash!!!")
		}
		else {
			fclose(fh)
		}
		
		let realm = RLMRealm.defaultRealm() // This line will crash if called while the device is locked
		let time = atTime ?? NSDate()
		
		realm.transactionWithBlock { () -> Void in
			let logItem = LogItem()
			logItem.message = message
			logItem.timestamp = time
			
			realm.addObject(logItem)
		}
		
		NSLog("%@ @ %@", message, time)
	}
	
	// MARK: CLLocationManagerDelegate
	
	func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
		let typedLocations = locations as [CLLocation]
		
		log("got location updates")
		
		for location in typedLocations {
			self.log("location update: \(location.coordinate.latitude) \(location.coordinate.longitude)", atTime:location.timestamp)
		}
	}
	
	func locationManagerDidPauseLocationUpdates(manager: CLLocationManager!) {
		log("updates paused")
	}
	
	func locationManagerDidResumeLocationUpdates(manager: CLLocationManager!) {
		log("updates paused")
	}
	
	func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
		log("failed with error \(error.description)")
	}
	
	func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
		log("authorisation status did change \(status.rawValue)")
		
		switch status {
		case .Authorized:
			locationManager.startUpdatingLocation()
		case .AuthorizedWhenInUse:
			log("unable to function with when in use only")
		case .Denied:
			log("authorisation denied")
		case .NotDetermined:
			log("authorisation not determined")
		case .Restricted:
			log("authorisation restricted")
		}
	}
}
