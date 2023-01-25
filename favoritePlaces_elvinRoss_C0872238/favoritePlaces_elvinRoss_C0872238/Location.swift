//
//  Location.swift
//  favoritePlaces_elvinRoss_C0872238
//
//  Created by Elvin Ross Fabella on 2023-01-24.
//

import Foundation
import MapKit

class Location: NSObject, MKAnnotation {
    var title: String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D
    
    init(title: String?, subtitle: String?, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
    }
}
