//
//  ProfessionListCollectionViewCell.swift
//  BlurApp-IOS
//
//  Created by Mert Şahin on 18.01.2023.
//

import UIKit

class ProfessionListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var professionName: UILabel!
    
    @IBOutlet weak var professionİmage: UIImageView!
    
    
    func setup(with profession : professionInfo){
        professionName.text = profession.nameOfProfession
        
    }
}
