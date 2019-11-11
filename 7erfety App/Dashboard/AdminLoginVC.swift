//
//  AdminLoginVC.swift
//  7erfety App
//
//  Created by AHMED on 8/2/1398 AP.
//  Copyright © 1398 AHMED. All rights reserved.
//

import UIKit
import Firebase

class AdminLoginVC: UIViewController,UITextFieldDelegate, Alertable {

  @IBOutlet weak var usernameTF: UITextField!
  @IBOutlet weak var passwordTF: UITextField!
  
  override func viewDidLoad() {
        super.viewDidLoad()
    usernameTF.delegate = self
    passwordTF.delegate = self
    
    let tap = UITapGestureRecognizer(target: self, action: #selector(handleScreenTap(sender:)))
    self.view.addGestureRecognizer(tap)
    
    view.bindToKeyboard()
      
    }
  
  @objc func handleScreenTap(sender: UITapGestureRecognizer){
    self.view.endEditing(true)
  }
  
  @IBAction func cancelBtnWasPressed(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }

  @IBAction func loginBtnWasPressed(_ sender: Any) {
    guard let username = usernameTF.text else { return }
    guard let password = passwordTF.text else { return }
    
    if username == "admin@admin.com" && password == "123456" {
      Auth.auth().createUser(withEmail: username, password: password) { (user, error) in
        if let err = error {
          print("Failed to create admin:", err)
          return
      }
    }
      
      Auth.auth().signIn(withEmail: username, password: password) { (user, error) in
        if let err = error {
          print("Failed to create admin:", err)
          return
        }
        
        print("Successfully created admin")
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let yourVC = mainStoryboard.instantiateViewController(withIdentifier: "DachMainVC") as! DachMainVC
        self.present(yourVC, animated: true, completion: nil)
        
      }
    }
  }
    
  }
  

