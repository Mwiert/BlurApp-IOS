//
//  NavigationMapController.swift
//  BlurApp-IOS
//
//  Created by Mert Şahin on 27.12.2022.
//

import Foundation
import MapKit
import CoreLocation
import UIKit

public class    mapFuncs:UIViewController,MKMapViewDelegate,CLLocationManagerDelegate{
    
    var mapView:MKMapView?
    
    public func getMap(mapKit : MKMapView){
        self.mapView = mapKit
        mapKit.delegate = self
        
    }
    public func getUserLocation(LM:CLLocationManager){
        LM.delegate = self
        LM.desiredAccuracy = kCLLocationAccuracyBest
        LM.requestWhenInUseAuthorization()
        LM.startUpdatingLocation()
        
    }
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: userLocation, span: span)
        mapView?.setRegion(region, animated: true)
        
        
    }
    
}


