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

    @IBOutlet weak var btnUserAdress: UIButton!
    @IBOutlet weak var btngetCurrentLocation: UIButton!
    
    
    @IBOutlet weak var mapView: MKMapView!
    var locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
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
        
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(locations[0]){
            (placemarks, error) in
            
            if let error = error{
                print(error)
            }
            else if let placemarks = placemarks{
                for placemark in placemarks{
                    let adress = [placemark.name,
                                  placemark.thoroughfare,
                                  placemark.locality,
                                  placemark.subAdministrativeArea,
                                  placemark.country,
                                  placemark.postalCode].compactMap({$0}).joined(separator : ", ")
                    userDefaultsOptions().saveUserAdress(userAdress: adress)
                    let getadress = userDefaultsOptions().getUserAdress()
                    self.btnUserAdress.titleLabel?.text = getadress
                }
            }
        }
        mapView?.setRegion(region, animated: true)
        
    }
}
