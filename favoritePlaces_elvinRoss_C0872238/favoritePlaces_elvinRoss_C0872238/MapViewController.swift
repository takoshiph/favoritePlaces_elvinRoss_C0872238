//
//  MapViewController.swift
//  favoritePlaces_elvinRoss_C0872238
//
//  Created by Elvin Ross Fabella on 2023-01-24.
//

import UIKit
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var localityLabel: UILabel!
    
    var location = [Location]()
    var locationManager = CLLocationManager()
    var userDefaults = UserDefaults()
    var favePlaceCount = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        mapView.delegate = self
        mapView.showsUserLocation = true
        
        addSingleTap()
        
    }
    
    func addSingleTap() {
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(dropPin))
        singleTap.numberOfTapsRequired = 1
        mapView.addGestureRecognizer(singleTap)
    }
    
    @objc func dropPin(sender: UITapGestureRecognizer) {
        
        removePin()
        
        let touchpoint = sender.location(in: mapView)
        let coordinate = mapView.convert(touchpoint, toCoordinateFrom: mapView)
       // let annotation = MKPointAnnotation()
        
        favePlaceCount = mapView.annotations.count
        
        CLGeocoder().reverseGeocodeLocation(CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude), completionHandler: {(placemarks, error) in
            
            if error != nil {
                print(error!)
            } else {
                DispatchQueue.main.async {
                    if let placeMark = placemarks?[0] {
                        
                        if placeMark.locality != nil {
                            let place = Location(title: placeMark.locality!, subtitle: "", coordinate: coordinate)
                            self.location.append(place)
                            self.mapView.addAnnotation(place)
                            self.localityLabel.text = place.title
                            self.userDefaults.set(place.title, forKey: "locality")
                            
                        }
                    }
                }
            }
        })
    }
    
    func removePin() {
        for annotation in mapView.annotations {
            mapView.removeAnnotation(annotation)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation = locations[0]
        
        let latitude = userLocation.coordinate.latitude
        let longitude = userLocation.coordinate.longitude
        displayLocation(latitude: latitude, longitude: longitude)
    }
    
    func displayLocation(latitude: CLLocationDegrees,
                         longitude: CLLocationDegrees)
    {
        let latDelta: CLLocationDegrees = 0.7
        let lngDelta: CLLocationDegrees =  0.7
        
        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lngDelta)
        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let region = MKCoordinateRegion(center: location, span: span)
        
        mapView.setRegion(region, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let alertController = UIAlertController(title: localityLabel.text, message: "A nice place to visit", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        let annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: localityLabel.text)
        annotationView.animatesWhenAdded = true
        return annotationView
    }
    
}

