//
//  ChosenProfessionListViewController.swift
//  BlurApp-IOS
//
//  Created by Mert Şahin on 20.01.2023.
//

import UIKit
import CoreLocation

class ChosenProfessionListViewController: UIViewController {

    @IBOutlet weak var professionName: UILabel!
    
    @IBOutlet weak var workplacesColletionView: UICollectionView!
    var professionNames = ""
    var saveWpName : String = ""
    var savewpKindName : String = ""
    var savewpLatitude : String = ""
    var savewpLongitude : String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        professionName.text = professionNames
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        workplacesColletionView.dataSource = self
        workplacesColletionView.delegate = self
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FilteredWorkplaceDetailsViewSegue" {
                    let destinationVC = segue.destination as! FilteredWorkplaceDetailsViewController
            destinationVC.wpName = saveWpName
            destinationVC.wpKindName = savewpKindName
            destinationVC.wpLatitude = savewpLatitude
            destinationVC.wpLongitude = savewpLongitude
                }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedWorkplace = dataStorage().getWorkplaces()
        
        let WorkplaceSearched = WorkplaceVM().searchSelectedWorkplacesByProfesionName(professionName: professionNames, WorkplaceData: selectedWorkplace)[indexPath.item]
        
        saveWpName = WorkplaceSearched.name
        savewpKindName = WorkplaceSearched.professionName
        savewpLatitude = WorkplaceSearched.location.latitude
        savewpLongitude = WorkplaceSearched.location.longitude
        performSegue(withIdentifier: "FilteredWorkplaceDetailsViewSegue", sender: nil)
    }
}
extension ChosenProfessionListViewController : UICollectionViewDataSource,UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let myData = dataStorage().getWorkplaces()
       let WorkplaceSearched = WorkplaceVM().searchSelectedWorkplacesByProfesionName(professionName: professionNames, WorkplaceData: myData)
    return WorkplaceSearched.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let workplaceCell = collectionView.dequeueReusableCell(withReuseIdentifier: "workplacesCollectionbyProfessionViewCell", for: indexPath) as! workplacesCollectionViewCell
        let myData = dataStorage().getWorkplaces()
        let WorkplaceSearched = WorkplaceVM().searchSelectedWorkplacesByProfesionName(professionName: professionNames, WorkplaceData: myData)
        
        workplaceCell.setup(with: WorkplaceSearched[indexPath.row])
        
        let userLocationCoords = userDefaultsOptions().getuserCoordinates()
        
        let latDouble = Double(userLocationCoords.latitude)
        let longDouble = Double(userLocationCoords.longitude)
        
        let userLocationLat = WorkplaceSearched[indexPath.item].location.latitude
        let userLocationLong = WorkplaceSearched[indexPath.item].location.longitude
        
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
