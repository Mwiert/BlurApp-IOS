//
//  workplacesCollectionViewCell.swift
//  BlurApp-IOS
//
//  Created by Mert Şahin on 18.01.2023.
//

import UIKit

class workplacesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var workplacesImage: UIImageView!
    @IBOutlet weak var workplacesNameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    func setup(with workplace : Workplace){
        workplacesNameLabel.text = workplace.name
        distanceLabel.text = "Henüz belirtilmedi"
    }
}
