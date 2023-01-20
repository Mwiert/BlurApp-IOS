//
//  AdminProfileViewController.swift
//  BlurApp-IOS
//
//  Created by Mert Şahin on 18.01.2023.
//

import UIKit

class AdminProfileViewController: UIViewController {
    
    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var emailLbl: UILabel!
    
    @IBOutlet weak var phoneLbl: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        getUserInfo()
        Task{
            _ = try await WorkplaceVM().getAllProfessionsAsync()
        }
    }
    
    func getUserInfo(){
        let userInfo = userDefaultsOptions().getUserInfo()
        nameLbl.text! = "\(userInfo.name!.capitalized) \(userInfo.surname!.capitalized)"
        emailLbl.text! = userInfo.email!
        phoneLbl.text! = "Yakında gerekecek"
    }
    
    @IBAction func logout(_ sender: Any) {
        userVM().userLogout()
        performSegue(withIdentifier: "logoutSegue", sender: nil)
    }
    
}
