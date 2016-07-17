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
	
	let stops = [
		Stop(location: CLLocation(latitude: 53.3797909227, longitude: -1.4702479773), type: .Bus, title: "Town Hall TH1", subtitle: "Heading S"),
		Stop(location: CLLocation(latitude: 53.3796291304, longitude: -1.4702499854), type: .Bus, title: "Town Hall TH2", subtitle: "Heading S"),
		Stop(location: CLLocation(latitude: 53.3811764790, longitude: -1.4705314550), type: .Bus, title: "City Hall CH2", subtitle: "Heading SE"),
		Stop(location: CLLocation(latitude: 53.3794583497, longitude: -1.4702521049), type: .Bus, title: "own Hall TH3", subtitle: "Heading S"),
		Stop(location: CLLocation(latitude: 53.3818536782, longitude: -1.4712146166), type: .Bus, title: "City Hall CH1", subtitle: "Heading SE"),
		Stop(location: CLLocation(latitude: 53.3814765439, longitude: -1.4733390594), type: .Tram, title: "City Hall", subtitle: "From Cathedral"),
		Stop(location: CLLocation(latitude: 53.3820745226, longitude: -1.4723695018), type: .Tram, title: "City Hall", subtitle: "To Cathedral"),
		Stop(location: CLLocation(latitude: 53.3784200864, longitude: -1.4712571522), type: .Bus, title: "Moorhead MH1", subtitle: "Heading SW"),
		Stop(location: CLLocation(latitude: 53.3812817138, longitude: -1.4740029491), type: .Bus, title: "City Hall CH3", subtitle: "Heading W"),
		Stop(location: CLLocation(latitude: 53.3810911327, longitude: -1.4675107401), type: .Bus, title: "Crucible Theatre", subtitle: "Heading N"),
		Stop(location: CLLocation(latitude: 53.3810911327, longitude: -1.4694633984), type: .Bus, title: "High St HS5", subtitle: "Heading W"),
		Stop(location: CLLocation(latitude: 53.3787388377, longitude: -1.4681413997), type: .Bus, title: "Charles Street", subtitle: "Heading N"),
	]
	
	@IBOutlet weak var mapView: MKMapView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		locationManager.delegate = self
		
		let annotations = self.stops.map {$0.annotation()}
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
