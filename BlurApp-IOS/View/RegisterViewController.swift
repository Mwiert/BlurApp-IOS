//
//  RegisterViewController.swift
//  BlurApp-IOS
//
//  Created by Mert Şahin on 27.12.2022.
//

import UIKit

class RegisterViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var alertKey : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func btnKaydolClicked(_ sender: Any) {
        
        if(emailTextField.text!.isEmpty || nameTextField.text!.isEmpty || surnameTextField.text!.isEmpty || passwordTextField.text!.isEmpty
        ){
            let alert = UIAlertController(title: "Hata!", message: "Lütfen boş alanları doldurunuz.", preferredStyle:UIAlertController.Style.alert)
        self.present(alert, animated: true, completion: nil)
            let okButton = UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default)
            alert.addAction(okButton)
        }
        else{
            if(alertKey! != "go"){
                let alert = UIAlertController(title: "Hata!", message: "Bilinmeyen bir hata oluştu.", preferredStyle:UIAlertController.Style.alert)
                self.present(alert, animated: true, completion: nil)
            }
            else{
                userRegisterVM().userRegisterReq(Email: emailTextField.text!, Password: passwordTextField.text!, Name: nameTextField.text!, Surname: surnameTextField.text!)
                
                let alert = UIAlertController(title: "Başarılı!", message: "Hesap oluşturuldu.", preferredStyle:UIAlertController.Style.alert)
                let okbutton = UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default){
                    (UIAlertAction) in
                    self.present(alert, animated: true, completion: nil)
                    self.performSegue(withIdentifier: "verifySegue", sender: (Any).self)
                    self.present(alert, animated: true, completion: nil)
                    self.performSegue(withIdentifier: "verifySegue", sender: (Any).self)
                }
            }
        }
        
    }
}
/*AF.request(url, method: .post ,parameters: jsonfilem ,encoder: JSONParameterEncoder.default,headers: headers).responseDecodable(of : mainUser.self, completionHandler: { response in
      switch response.result {
      
      case .success(let data):
      print(data)
      case .failure(let error):
      print(error.localizedDescription)
      }
  })*/
