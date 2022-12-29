//
//  MainViewController.swift
//  BlurApp-IOS
//
//  Created by Mert Şahin on 27.12.2022.
//

import UIKit
import MapKit
import CoreLocation
import UIKit

class MainViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate{

    @IBOutlet weak var mapView: MKMapView!
    var locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: userLocation, span: span)
        mapView?.setRegion(region, animated: true)
    }

}
