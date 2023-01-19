//
//  WorkplaceDetailsViewController.swift
//  BlurApp-IOS
//
//  Created by Mert Şahin on 19.01.2023.
//

import UIKit
import MapKit

class WorkplaceDetailsViewController : UIViewController, MKMapViewDelegate,CLLocationManagerDelegate {

    @IBOutlet weak var workplaceNameLabel: UILabel!
    
    @IBOutlet weak var workplaceKindLabel: UILabel!
    
    @IBOutlet weak var workplaceMap: MKMapView!
    
    var locationManager = CLLocationManager()
    
    var wpName  = ""
    var wpKindName  = ""
    var wpLatitude  = ""
    var wpLongitude  = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    override func viewWillAppear(_ animated: Bool) {
        let annotation = MKPointAnnotation()
        annotation.title = wpName
        let tempLat = wpLatitude.replacingOccurrences(of: ",", with: ".")
        let tempLong = wpLongitude.replacingOccurrences(of: ",", with: ".")
        
        let annotatonlatitude : Double = Double(tempLat)!
        let annotationlongitude: Double = Double(tempLong)!

        
        let locations = CLLocationCoordinate2D(latitude: annotatonlatitude, longitude: annotationlongitude)
        annotation.coordinate = locations
        self.workplaceMap.addAnnotation(annotation)
        
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: annotation.coordinate, span: span)
        workplaceMap?.setRegion(region, animated: true)
        
        workplaceNameLabel.text! = wpName
        workplaceKindLabel.text! = wpKindName
    }
}
