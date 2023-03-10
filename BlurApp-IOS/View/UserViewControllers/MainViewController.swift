//
//  MainViewController.swift
//  BlurApp-IOS
//
//  Created by Mert Şahin on 27.12.2022.
//

import UIKit
import MapKit
import CoreLocation

class MainViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate{

    @IBOutlet weak var btnUserAdress: UIButton!
    @IBOutlet weak var btngetCurrentLocation: UIButton!
    
    @IBOutlet weak var workplacesColletionView: UICollectionView!
    
    @IBOutlet weak var professionsCollectionView: UICollectionView!
    
    @IBOutlet weak var mapView: MKMapView!
    
    var searchText = ""
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        professionsCollectionView.dataSource = self
        professionsCollectionView.delegate = self
        
    }
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "searchWorkplaces"{
            let destinationVC = segue.destination as! SearchWorkplaceViewController
            destinationVC.search = searchText
        }
    }
    
    @IBAction func searchText(_ sender: UITextField) {
        if(sender.text!.isEmpty == false){
            let search = sender.text?.lowercased()
            searchText = search!
            performSegue(withIdentifier: "searchWorkplaces", sender: nil)
            sender.text = .none
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == workplacesColletionView{
            
            let selectedWorkplace = dataStorage().getWorkplaces()[indexPath.item]
            
            let workplaceDetailsVC = storyboard?.instantiateViewController(withIdentifier: "WorkplaceDetailsViewController") as! WorkplaceDetailsViewController
            workplaceDetailsVC.wpName = selectedWorkplace.name
            workplaceDetailsVC.wpKindName = selectedWorkplace.professionName
            workplaceDetailsVC.wpLatitude = selectedWorkplace.location.latitude
            workplaceDetailsVC.wpLongitude = selectedWorkplace.location.longitude
            navigationController?.present(workplaceDetailsVC, animated: true)
        }
        else{
            let selectedWorkplace = dataStorage().getProfessions()[indexPath.item]
            
            let workplaceDetailsVC = storyboard?.instantiateViewController(withIdentifier: "ChosenProfessionListViewController") as! ChosenProfessionListViewController
            workplaceDetailsVC.professionNames = selectedWorkplace.nameOfProfession

            navigationController?.present(workplaceDetailsVC, animated: true)
        }

    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        
        let latString = String(userLocation.latitude)
        let longString = String(userLocation.longitude)
        
        let coords = lats (latitude: latString, longitude: longString)

        
        userDefaultsOptions().saveUsersLocationCoordinates(coordinates: coords)
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        workplacesColletionView.dataSource = self
        workplacesColletionView.delegate = self
        
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
}


extension MainViewController : UICollectionViewDataSource,UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == workplacesColletionView{
            let myData = dataStorage().getWorkplaces()
            return myData.count
        }
        else{
            let myData = dataStorage().getProfessions()
            return myData.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.workplacesColletionView{
            let workplaceCell = collectionView.dequeueReusableCell(withReuseIdentifier: "workplacesCollectionViewCell", for: indexPath) as! workplacesCollectionViewCell
            let myData = dataStorage().getWorkplaces()
            workplaceCell.setup(with: myData[indexPath.row])
            
            let userLocationCoords = userDefaultsOptions().getuserCoordinates()
            
            let latDouble = Double(userLocationCoords.latitude)
            let longDouble = Double(userLocationCoords.longitude)
            
            let userLocationLat = myData[indexPath.item].location.latitude
            let userLocationLong = myData[indexPath.item].location.longitude
            
            let useUserLatitude = Double(userLocationLat.replacingOccurrences(of: ",", with: "."))
            let useUserLongitude = Double(userLocationLong.replacingOccurrences(of: ",", with: "."))
            
            let userLocation = CLLocation(latitude: latDouble!, longitude: longDouble!)
            let specifiedPoint = CLLocation(latitude: useUserLatitude!, longitude: useUserLongitude!)
            

            let distanceInMeters = userLocation.distance(from: specifiedPoint)
            
            workplaceCell.distanceLabel.text! = String(format: "%.01f  metre uzakta!", distanceInMeters)
            
            return workplaceCell
        }
        else{
            let profCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfessionListCollectionViewCell", for: indexPath) as! ProfessionListCollectionViewCell
            let myData = dataStorage().getProfessions()
            profCell.setup(with: myData[indexPath.row])
            
            return profCell
        }
    }
}
extension MainViewController : UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        if collectionView == workplacesColletionView{
            return CGSize(width: 385, height: 75)
        }
        else{
            return CGSize(width: 62, height: 76)
        }
    }
    
}
