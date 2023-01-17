//
//  CreateProfessionViewController.swift
//  BlurApp-IOS
//
//  Created by Mert Şahin on 13.01.2023.
//

import UIKit

class CreateProfessionViewController: UIViewController {
    @IBOutlet weak var professionNameText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func btn(_ sender: Any) {
        WorkplaceVM().getAllProfessions()
        
    }
    @IBAction func btnCreateProfessionClicked(_ sender: Any) {
        if(professionNameText.text!.isEmpty){
            let alert = UIAlertController(title: "Hata!", message: "Lütfen boş alanları doldurunuz.", preferredStyle:UIAlertController.Style.alert)
            self.present(alert, animated: true, completion: nil)
            let okButton = UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default)
            alert.addAction(okButton)
        }
        else{
            WorkplaceVM().createSingleProfession(professionName: professionNameText.text!)
        }
    }
    
    @IBAction func crprof(_ sender: Any) {
        Task{
            let res = try await WorkplaceVM().nearestWPs()
        }
    }
}
