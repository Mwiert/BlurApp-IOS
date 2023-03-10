//
//  UserWorkplaceRequestViewController.swift
//  BlurApp-IOS
//
//  Created by Mert Şahin on 18.01.2023.
//

import UIKit
import MapKit

class UserWorkplaceRequestViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate {
    @IBOutlet weak var professionNameText: UITextField!
    
    @IBOutlet weak var professionKindNameText: UITextField!
    
    @IBOutlet weak var professionLatitudeText: UITextField!
    
    @IBOutlet weak var professionLongitudeText: UITextField!
    
    var professionPickerView = UIPickerView()
    
    @IBOutlet weak var professionCreatedLocation: MKMapView!
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        professionCreatedLocation.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        professionPickerView.delegate = self
        professionPickerView.dataSource = self
        
        professionKindNameText.inputView = professionPickerView
        professionKindNameText.textAlignment = .center
        
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
            let alert = UIAlertController(title: "Başarılı!", message: "İş yeri konumu talebiniz iletildi.", preferredStyle:UIAlertController.Style.alert)
            self.present(alert, animated: true, completion: nil)
            let okButton = UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default)
            alert.addAction(okButton)
            let createNewWP = createWorkplace.init(name: professionNameText.text!, latitude: professionLatitudeText.text!, longitude: professionLongitudeText.text!, professionName: professionKindNameText.text!)
            // create yerine sendAddRequest gelicek
           // WorkplaceVM().createNewWorkplace(createNewWorkplace: createNewWP)
        }
    }
}
extension UserWorkplaceRequestViewController : UIPickerViewDelegate,UIPickerViewDataSource{
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        let data = dataStorage().getProfessions()
        let dataCount = data.count
        return dataCount
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let data = dataStorage().getProfessions()
        return data[row].nameOfProfession
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let data = dataStorage().getProfessions()
        professionKindNameText.text = data[row].nameOfProfession
        professionKindNameText.resignFirstResponder()
    }
}
