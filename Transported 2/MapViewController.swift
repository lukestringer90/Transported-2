//
//  MapViewController.swift
//  Transported 2
//
//  Created by Luke Stringer on 17/07/2016.
//  Copyright © 2016 Luke Stringer. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

	let locationManager = CLLocationManager()
	@IBOutlet weak var mapView: MKMapView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		locationManager.delegate = self
		
		requestLocation()
		
	}
	
	func requestLocation() {
		switch CLLocationManager.authorizationStatus() {
		case .authorizedWhenInUse:
			locationManager.requestLocation()
		case .denied:
			abort()
		default:
			locationManager.requestWhenInUseAuthorization()
		}
	}
	
	func centreOnLocation(location: CLLocation) {
		mapView.setCenter(location.coordinate, animated: true)
		let viewRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, 500, 500)
		let regionThatFits = mapView.regionThatFits(viewRegion)
		mapView.setRegion(regionThatFits, animated: true)

	}
	
	// MARK: CLLocationManagerDelegate
	
	func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
		requestLocation()
	}
	
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		if let userLocation = locations.first {
			centreOnLocation(location: userLocation)
		}
	}
	
	func locationManager(_ manager: CLLocationManager, didFailWithError error: NSError) {
	}
	
	

}
