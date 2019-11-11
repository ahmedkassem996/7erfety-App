//
//  LoginVC.swift
//  7erfety App
//
//  Created by AHMED on 7/7/1398 AP.
//  Copyright © 1398 AHMED. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController {

  var delegate: CenterVCDelegate?//->
  
  @IBOutlet weak var emailTextFailed: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var loginBtn: UIButton!
  
  override func viewDidLoad() {
        super.viewDidLoad()
    
    addTargetInputChanged()
    
    let tap = UITapGestureRecognizer(target: self, action: #selector(handleScreenTap(sender:)))
    self.view.addGestureRecognizer(tap)
    }
  
  func addTargetInputChanged(){
    emailTextFailed.addTarget(self, action: #selector(handleTxtInputChange), for: .editingChanged)
    passwordTextField.addTarget(self, action: #selector(handleTxtInputChange), for: .editingChanged)
  }
  
  @objc func handleScreenTap(sender: UITapGestureRecognizer){
    self.view.endEditing(true)
  }
  
  @objc func handleTxtInputChange(){
    let isFormValid = !(emailTextFailed.text?.isEmpty)!  && !(passwordTextField.text?.isEmpty)!
    
    if isFormValid{
      loginBtn.isEnabled = true
      loginBtn.backgroundColor = UIColor.rgb(red: 17, green: 154, blue: 237)
    }else{
      loginBtn.isEnabled = false
      loginBtn.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
    }
    
  }
  
  @IBAction func loginBtnWasPressed(_ sender: Any) {
    guard let email = emailTextFailed.text else { return }
    guard let password = passwordTextField.text else { return }
    
    Auth.auth().signIn(withEmail: email, password: password) { (user, err) in
      if let err = err{
        print("Failed to sign with email", err)
        return
      }
      print("Succcessfully logged back in with user:", user?.user.uid ?? "")
      
      if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") {
        UIApplication.shared.keyWindow?.rootViewController = viewController
        self.dismiss(animated: true, completion: nil)
      }
      
      self.dismiss(animated: true, completion: nil)
      
      
    }

  }
  
  @IBAction func adminBtnWasPressed(_ sender: Any) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let yourVC = mainStoryboard.instantiateViewController(withIdentifier: "AdminLoginVC") as! AdminLoginVC
        present(yourVC, animated: true, completion: nil)
  }
  
}
