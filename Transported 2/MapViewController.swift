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
	let stops: [StopModel]
	let annotations: [Annotation]
	
	@IBOutlet weak var mapView: MKMapView!
	
	required init?(coder aDecoder: NSCoder) {
		stops = Stop.sheffCityCentreStops()
		annotations = self.stops.map {($0 as! Stop).annotation()}
		
		super.init(coder: aDecoder)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		locationManager.delegate = self
		mapView.addAnnotations(annotations)
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
		mapView.setRegion(regionThatFits, animated: false)

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
	
	func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
		if annotation is MKUserLocation  {
			return nil
		}
		
		let pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "PinID")
		pin.canShowCallout = true
		return pin
	}
	

}
