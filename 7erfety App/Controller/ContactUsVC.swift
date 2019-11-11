//
//  ContactUsVC.swift
//  7erfety App
//
//  Created by AHMED on 7/8/1398 AP.
//  Copyright © 1398 AHMED. All rights reserved.
//

import UIKit
import Firebase

class ContactUsVC: UIViewController, Alertable {

  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var messageTextField: UITextField!
  @IBOutlet weak var sendBtn: RoundedShadowButton!
  
  override func viewDidLoad() {
        super.viewDidLoad()
    
    addTargetView()
    
    }
    
  @IBAction func cancelBtnWasPressed(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func sendBtnActionWasPressed(_ sender: Any) {
    
    guard let email = emailTextField.text else { return }
    guard let username = nameTextField.text else { return }
    guard let message = messageTextField.text else { return }
    
    guard let uid = Auth.auth().currentUser?.uid else { return }
    
    let values = ["name": username , "email": email, "message": message, "uid": uid] as [String : Any]
    
    Database.database().reference().child("contactUs").childByAutoId().updateChildValues(values) { (err, ref) in
      
      if let err = err {
        print("Failed to insert comment:", err)
        
        self.showAlert(ERROR_MSG_UNEXPECTED_ERROR)
      } else {
        print("Successfully contacted")
        
        self.emailTextField.text = ""
        self.nameTextField.text = ""
        self.messageTextField.text = ""
        self.sendBtn.isEnabled = false
        self.sendBtn.backgroundColor = UIColor.rgb(red: 190, green: 150, blue: 71)
        
        self.showAlertMessage(VALID_SENDING_MESSAGE)
      }
    }
  }
  
  func addTargetView(){
    emailTextField.addTarget(self, action: #selector(handleTxtInputChange), for: .editingChanged)
    nameTextField.addTarget(self, action: #selector(handleTxtInputChange), for: .editingChanged)
    messageTextField.addTarget(self, action: #selector(handleTxtInputChange), for: .editingChanged)
  }
  
  @objc func handleTxtInputChange(){
    let isFormValid = !(emailTextField.text?.isEmpty)! && !(nameTextField.text?.isEmpty)! && !(messageTextField.text?.isEmpty)!
    
    if isFormValid{
      sendBtn.isEnabled = true
      sendBtn.backgroundColor = UIColor.rgb(red: 245, green: 130, blue: 12)
    }else{
      sendBtn.isEnabled = false
      sendBtn.backgroundColor = UIColor.rgb(red: 190, green: 150, blue: 71)
    }
    
  }
  

}
