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
    @IBAction func btnCreateProfessionClicked(_ sender: Any) {
        if(professionNameText.text!.isEmpty){
            let alert = UIAlertController(title: "Hata!", message: "Lütfen boş alanları doldurunuz.", preferredStyle:UIAlertController.Style.alert)
            self.present(alert, animated: true, completion: nil)
            let okButton = UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default)
            alert.addAction(okButton)
        }
        else{
            WorkplaceVM().createSingleProfession(professionName: professionNameText.text!)
            let alert = UIAlertController(title: "Başarılı!", message: "İş yeri oluşturuldu.", preferredStyle:UIAlertController.Style.alert)
            self.present(alert, animated: true, completion: nil)
            let okButton = UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default)
            alert.addAction(okButton)
        }
    }
    
}
