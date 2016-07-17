//
//  Stop.swift
//  Transported 2
//
//  Created by Luke Stringer on 17/07/2016.
//  Copyright © 2016 Luke Stringer. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

enum StopType {
	case Bus
	case Tram
}

protocol StopModel {
	var location: CLLocation { get }
	var type: StopType { get }
	var title: String { get }
	var subtitle: String? { get }
}

struct Stop: StopModel {
	let location: CLLocation
	let type: StopType
	let title: String
	let subtitle: String?
	
	func annotation() -> Annotation {
		return Annotation(coordinate: self.location.coordinate, title: self.title, subtitle: self.subtitle)
	}
	
}

class Annotation: NSObject, MKAnnotation {
	let coordinate: CLLocationCoordinate2D
	let title: String?
	let subtitle: String?
	
	init(coordinate: CLLocationCoordinate2D, title: String?, subtitle: String?) {
		self.coordinate = coordinate
		self.title = title
		self.subtitle = subtitle
	}
}
