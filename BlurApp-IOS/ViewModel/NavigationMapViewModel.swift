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
    
    func getUserAdress(location : CLLocation){   // kullanılmıyor.
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(location){
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
                    print(adress)
                }
            }
        }
    }
}


