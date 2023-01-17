//
//  CreateProfessionViewController.swift
//  BlurApp-IOS
//
//  Created by Mert Şahin on 10.01.2023.
//

import UIKit
import MapKit
import CoreLocation

class CreateWorkplaceViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var professionKindNameText: UITextField!
    @IBOutlet weak var professionNameText: UITextField!
    @IBOutlet weak var professionLatitudeText: UITextField!
    @IBOutlet weak var professionLongitudeText: UITextField!
    
    @IBOutlet weak var professionCreatedLocation: MKMapView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        professionCreatedLocation.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(chooseLocation(gestureRecognizer:)))
        gestureRecognizer.minimumPressDuration = 1.5
        professionCreatedLocation.addGestureRecognizer(gestureRecognizer)
        // Do any additional setup after loading the view.
    
    }

    
    @objc func chooseLocation(gestureRecognizer : UILongPressGestureRecognizer){
        if (gestureRecognizer.state == .began){
            let touchedPoint = gestureRecognizer.location(in: self.professionCreatedLocation)
            let touchedCordinates = self.professionCreatedLocation.convert(touchedPoint, toCoordinateFrom: self.professionCreatedLocation)
            let annotation = MKPointAnnotation()
            annotation.coordinate = touchedCordinates
            annotation.title = "Seçilen işletme"
            annotation.subtitle = "Seçildi"
            self.professionCreatedLocation.addAnnotation(annotation)
            let annotatonlatitude : String = String(format: "%f", annotation.coordinate.latitude)
            let annotationlongitude: String = String(format: "%f", annotation.coordinate.longitude)
            professionLatitudeText.text = annotatonlatitude.replacingOccurrences(of: ".", with: ",")
            professionLongitudeText.text = annotationlongitude.replacingOccurrences(of: ".", with: ",")
        }
    }
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: userLocation, span: span)
        professionCreatedLocation?.setRegion(region, animated: true)
        
    }

    
    @IBAction func btnCreateProfessionClicked(_ sender: Any) {
        if(professionNameText.text!.isEmpty || professionKindNameText.text!.isEmpty || professionLatitudeText.text!.isEmpty || professionLongitudeText.text!.isEmpty
        ){
            let alert = UIAlertController(title: "Hata!", message: "Lütfen boş alanları doldurunuz.", preferredStyle:UIAlertController.Style.alert)
        self.present(alert, animated: true, completion: nil)
            let okButton = UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default)
            alert.addAction(okButton)
        }
        else{
            let createNewWP = createWorkplace.init(name: professionNameText.text!, latitude: professionLatitudeText.text!, longitude: professionLongitudeText.text!, professionName: professionKindNameText.text!)
            
            WorkplaceVM().createNewWorkplace(createNewWorkplace: createNewWP)
        }
    }
}
