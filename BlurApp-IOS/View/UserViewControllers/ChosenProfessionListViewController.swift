//
//  ChosenProfessionListViewController.swift
//  BlurApp-IOS
//
//  Created by Mert Şahin on 20.01.2023.
//

import UIKit
import CoreLocation
import SwiftUI

class ChosenProfessionListViewController: UIViewController {

    @IBOutlet weak var professionName: UILabel!
    
    @IBOutlet weak var workplacesColletionView: UICollectionView!
    var professionNames = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        professionName.text = professionNames
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        workplacesColletionView.dataSource = self
        workplacesColletionView.delegate = self
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedWorkplace = dataStorage().getWorkplaces()[indexPath.item]
        if(selectedWorkplace.professionName == professionNames){
            
        }
        let workplaceDetailsVC = storyboard?.instantiateViewController(withIdentifier: "ChosenProfessionListViewController") as! ChosenProfessionListViewController
        
        navigationController?.present(workplaceDetailsVC, animated: true)

    }
}
extension ChosenProfessionListViewController : UICollectionViewDataSource,UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let myData = dataStorage().getWorkplaces()
        return myData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let workplaceCell = collectionView.dequeueReusableCell(withReuseIdentifier: "workplacesCollectionbyProfessionViewCell", for: indexPath) as! workplacesCollectionViewCell
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
}
extension ChosenProfessionListViewController : UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        return CGSize(width: 385, height: 75)
    }
    
}
