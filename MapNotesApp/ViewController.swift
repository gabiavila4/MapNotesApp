//
//  ViewController.swift
//  MapNotesApp
//
//  Created by GABRIELA AVILA on 1/31/24.
//

import UIKit
import MapKit
class ViewController: UIViewController, CLLocationManagerDelegate {

    
    @IBOutlet weak var mapViewOutlet: MKMapView!
    
    var currentLocation : CLLocation!
    let locationManager = CLLocationManager()
    var parks : [MKMapItem] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        
        
        locationManager.requestWhenInUseAuthorization()
        mapViewOutlet.showsUserLocation = true
        
        let center = CLLocationCoordinate2D(latitude: 42.2371, longitude: -88.3162)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let center2 = locationManager.location!.coordinate
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 1600, longitudinalMeters: 1600)
        
        let region2 = MKCoordinateRegion(center: center2, span: span)
        mapViewOutlet.setRegion(region2, animated: true)
        locationManager.startUpdatingLocation()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("hi")
        currentLocation = locations[0]
    }
   
    
    @IBAction func searchAction(_ sender: UIButton) {
        print("button pushed")
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "Parks"
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        request.region = MKCoordinateRegion(center: currentLocation.coordinate, span: span)
        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
            guard let response = response
            else{return}
        for mapItem in response.mapItems{
        self.parks.append(mapItem)
        let annotation = MKPointAnnotation()
        annotation.coordinate = mapItem.placemark.coordinate
        annotation.title = mapItem.name
            
            self.mapViewOutlet.addAnnotation(annotation)
            }
        }
        
    }
    

}

