//
//  RegisterVC.swift
//  7erfety App
//
//  Created by AHMED on 7/7/1398 AP.
//  Copyright © 1398 AHMED. All rights reserved.
//

import UIKit
import Firebase

class RegisterVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, Alertable{

  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var usernameTextField: UITextField!
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var tableCraftsmenList: UITableView!
  @IBOutlet weak var selectCraftsmenBtn: UIButton!
  @IBOutlet weak var plusPhotoBtn: UIButton!
  @IBOutlet weak var segmentedControl: UISegmentedControl!
  @IBOutlet weak var signUpBtn: UIButton!
  
  let array: NSMutableArray = ["Carpenter", "Blumber", "Appliance techinician", "Painting works", "Electrician", "Airconditing", "Laster work", "Gypsum board"]
  
  override func viewDidLoad() {
        super.viewDidLoad()
    
    self.plusPhotoBtn.setNeedsDisplay()
    
    emailTextField.delegate = self
    passwordTextField.delegate = self
    usernameTextField.delegate = self
    
    addTargetInputChanged()
    
    signUpBtn.layer.cornerRadius = 5
    
    setupDropList()
    
    tableCraftsmenList.delegate = self
    tableCraftsmenList.dataSource = self
    
    }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.view.endEditing(true)
  }
  
  func addTargetInputChanged(){
    emailTextField.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
    passwordTextField.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
    usernameTextField.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
    selectCraftsmenBtn.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
  }
  
  func setupDropList(){
    selectCraftsmenBtn.backgroundColor = UIColor.white
    selectCraftsmenBtn.layer.cornerRadius = 5
    selectCraftsmenBtn.layer.borderWidth = 1
    selectCraftsmenBtn.layer.borderColor = UIColor.black.cgColor
    
    tableCraftsmenList.backgroundColor = UIColor.white
    tableCraftsmenList.layer.cornerRadius = 5
    tableCraftsmenList.layer.borderWidth = 1
    tableCraftsmenList.layer.borderColor = UIColor.black.cgColor
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
      plusPhotoBtn.setImage(editedImage.withRenderingMode(.alwaysOriginal), for: .normal)
    }else if let chosenImage = info[.originalImage] as? UIImage {
      plusPhotoBtn.setImage(chosenImage.withRenderingMode(.alwaysOriginal), for: .normal)
    } else{
      print("Something went wrong")
    }
    
    plusPhotoBtn.layer.cornerRadius = plusPhotoBtn.frame.width / 2
    plusPhotoBtn.layer.masksToBounds = true
    plusPhotoBtn.layer.borderColor = UIColor.black.cgColor
    plusPhotoBtn.layer.borderWidth = 1.5
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func plusPhotoBtnWasPressed(_ sender: Any) {
    let imagePickerController = UIImagePickerController()
    imagePickerController.delegate = self
    imagePickerController.allowsEditing = true
    present(imagePickerController, animated: true, completion: nil)
  }
  
  @IBAction func selectedSegmentWasPressed(_ sender: Any) {
    
    if self.segmentedControl.selectedSegmentIndex == 0{
      selectCraftsmenBtn.isHidden = true
      tableCraftsmenList.isHidden = true
      
      emailTextField.text = nil
      passwordTextField.text = nil
      usernameTextField.text = nil
      signUpBtn.isEnabled = false
      signUpBtn.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
    }else{
      selectCraftsmenBtn.isHidden = false
      
      emailTextField.text = nil
      passwordTextField.text = nil
      usernameTextField.text = nil
      signUpBtn.isEnabled = false
      signUpBtn.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
      selectCraftsmenBtn.setTitle("Select Craftsmen...", for: .normal)
    }
  }
  @IBAction func buttonSelectCraftsmen(_ sender: Any) {
    if tableCraftsmenList.isHidden == true{
      tableCraftsmenList.isHidden = false
    }else{
      tableCraftsmenList.isHidden = true
    }
  }
  
  
  @IBAction func signUpBtnWasPressed(_ sender: Any) {
    handleSignUP()
    self.emailTextField.resignFirstResponder()
    self.usernameTextField.resignFirstResponder()
    self.passwordTextField.resignFirstResponder()
  }
  
  @objc func handleTextInputChange(){
    var isFormValid = !(emailTextField.text?.isEmpty)!  && !(usernameTextField.text?.isEmpty)! && !(passwordTextField.text?.isEmpty)! && selectCraftsmenBtn.currentTitle != "Select Craftsmen..."
    
    if segmentedControl.selectedSegmentIndex == 0{
      isFormValid = !(emailTextField.text?.isEmpty)!  && !(usernameTextField.text?.isEmpty)! && !(passwordTextField.text?.isEmpty)!
    }else{
      isFormValid = !(emailTextField.text?.isEmpty)!  && !(usernameTextField.text?.isEmpty)! && !(passwordTextField.text?.isEmpty)! && selectCraftsmenBtn.currentTitle != "Select Craftsmen..."
    }
    
    if isFormValid{
      signUpBtn.isEnabled = true
      signUpBtn.backgroundColor = .mainBlue()
    }else{
      signUpBtn.isEnabled = false
      signUpBtn.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
    }
    
  }
  
  func handleSignUP(){
    guard let email = emailTextField.text, emailTextField.text != nil else { return }
    guard let username = usernameTextField.text, usernameTextField.text != nil else { return }
    guard let password = passwordTextField.text, passwordTextField.text != nil else { return }
    guard let craftsmenBtn = selectCraftsmenBtn.currentTitle, selectCraftsmenBtn.currentTitle != "Select Craftsmen..." else { return }
    
    Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
      if error != nil {
        if let errorCode = AuthErrorCode(rawValue: error!._code) {
          switch errorCode {
          case .invalidEmail:
            self.showAlert(ERROR_MSG_INVALID_EMAIL)
          default:
            self.showAlert(ERROR_MSG_UNEXPECTED_ERROR)
          }
        }
      } else {
        
        guard let image = self.plusPhotoBtn.imageView?.image else { return }
        guard let uploadData = image.jpegData(compressionQuality: 0.3) else { return }

        let fileName = NSUUID().uuidString

        let storageRef = Storage.storage().reference().child("profile_image").child(fileName)
        storageRef.putData(uploadData, metadata: nil, completion: { (metadata, err) in

          if let err = err{
            print("Failed to upload profile image", err)
            return
          }

          storageRef.downloadURL { (url, error) in
            guard let downloadURL = url else {
              print("an error occurred!")

              return
            }

            print("Successfully uploaded profile image")

            let profileImageUrl = downloadURL.absoluteString
        
        if let user = user {
          if self.segmentedControl.selectedSegmentIndex == 0 {
            let userData = ["provider": user.user.providerID, "username": username, "profileImageUrl": profileImageUrl, "userIsCraftsmen": false] as [String: Any]
            DataService.instance.createFirebaseDBUser(uid: user.user.uid, userData: userData, isCraftsmen: false)
          } else {
            let userData = ["provider": user.user.providerID, "username": username, "profileImageUrl": profileImageUrl, "craftsmenWork": craftsmenBtn, "userIsCraftsmen": true, "isPickUpModeEnabled": false, "carpenterIsOnWork": false] as [String: Any]
            DataService.instance.createFirebaseDBUser(uid: user.user.uid, userData: userData, isCraftsmen: true)
          }
        }
        
        self.dismiss(animated: true, completion: nil)
        
        if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") {
          UIApplication.shared.keyWindow?.rootViewController = viewController
          self.dismiss(animated: true, completion: nil)
        }
      }
    })
 }
    })
  }
  
 
  @IBAction func signInRoot(_ sender: Any) {
    self.dismiss(animated: true, completion: nil)
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return array.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
    cell.textLabel?.text = array[indexPath.row] as? String
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let selectedItem = array.object(at: indexPath.row) as! NSString
    selectCraftsmenBtn.setTitle(selectedItem as String, for: .normal)
    
    tableCraftsmenList.isHidden = true
  }
  
}
