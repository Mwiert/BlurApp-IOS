//
//  SearchedWorkplaceDetailsViewController.swift
//  BlurApp-IOS
//
//  Created by Mert Şahin on 21.01.2023.
//

import UIKit
import MapKit


class SearchedWorkplaceDetailsViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate  {

    @IBOutlet weak var workplaceMap: MKMapView!
    @IBOutlet weak var workplaceNameLabel: UILabel!
    @IBOutlet weak var workplaceKindLabel: UILabel!
    @IBOutlet weak var DistanceLabel: UILabel!
    
    
    var locationManager = CLLocationManager()
    
    var wpName  = ""
    var wpKindName  = ""
    var wpLatitude  = ""
    var wpLongitude  = ""
    
    var searchedData : [Workplace] = []
    
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
        
        let userLocationCoords = userDefaultsOptions().getuserCoordinates()
        
        let latDouble = Double(userLocationCoords.latitude)
        let longDouble = Double(userLocationCoords.longitude)
        
        let userLocation = CLLocation(latitude: latDouble!, longitude: longDouble!)
        let specifiedPoint = CLLocation(latitude:annotatonlatitude, longitude: annotationlongitude)
        

        let distanceInMeters = userLocation.distance(from: specifiedPoint)
        DistanceLabel.text! = String(format: "%.01f  metre uzakta!", distanceInMeters)
        workplaceNameLabel.text! = wpName
        workplaceKindLabel.text! = wpKindName
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
