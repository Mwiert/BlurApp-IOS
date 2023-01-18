//
//  LocationMapViewController.swift
//  BlurApp-IOS
//
//  Created by Mert Şahin on 27.12.2022.
//

import UIKit
import MapKit
import CoreLocation


class LocationMapViewController: UIViewController, MKMapViewDelegate,CLLocationManagerDelegate {
    var myFuncs : mapFuncs?
    var locationManager = CLLocationManager()
    
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
      
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    override func viewWillAppear(_ animated: Bool) {
        Task{
            WorkplaceVM().getWorkplaces1 { locationWps in
                for wpLocations in locationWps{
                    let annotation = MKPointAnnotation()
                    annotation.title = wpLocations.name
                    
                    let tempLat = wpLocations.location.latitude.replacingOccurrences(of: ",", with: ".")
                    let tempLong = wpLocations.location.longitude.replacingOccurrences(of: ",", with: ".")
                    
                    let annotatonlatitude : Double = Double(tempLat)!
                    let annotationlongitude: Double = Double(tempLong)!

                    
                    let locations = CLLocationCoordinate2D(latitude: annotatonlatitude, longitude: annotationlongitude)
                    annotation.coordinate = locations
                    self.mapView.addAnnotation(annotation)
                }
            }
        }
    }
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: userLocation, span: span)
        mapView?.setRegion(region, animated: true)
    }
}
