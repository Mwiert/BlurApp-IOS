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
    
    @IBOutlet weak var professionsCollectionView: UICollectionView!
    
    
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
      
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    override func viewWillAppear(_ animated: Bool) {
        
        professionsCollectionView.dataSource = self
        professionsCollectionView.delegate = self
        
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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

            let allAnnotations = self.mapView.annotations
            self.mapView.removeAnnotations(allAnnotations)
                let myData = dataStorage().getProfessions()
                let profName = myData[indexPath.row].nameOfProfession

                WorkplaceVM().getWorkplaces1 { locationWps in
                    
                   let searchedData = WorkplaceVM().searchSelectedWorkplacesByProfesionName(professionName: profName, WorkplaceData: locationWps)
                    for wpLocations in searchedData{
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
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: userLocation, span: span)
        mapView?.setRegion(region, animated: true)
    }
}
//YAPILDI
extension LocationMapViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let myData = dataStorage().getProfessions()
        return myData.count
    }
    // YAPILDI
    func collectionView(_ collectionView:   UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let profCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfessionListCollectionViewCell", for: indexPath) as! ProfessionListCollectionViewCell
        let myData = dataStorage().getProfessions()
        profCell.setup(with: myData[indexPath.row])
        
        return profCell
    }
}
//YAPILDI
extension LocationMapViewController : UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        return CGSize(width: 62, height: 76)
    }
}
