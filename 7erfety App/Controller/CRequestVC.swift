//
//  CraftsProfileController.swift
//  7erfety App
//
//  Created by AHMED on 7/16/1398 AP.
//  Copyright © 1398 AHMED. All rights reserved.
//

import UIKit
import Firebase

class CRequestVC: UICollectionViewController, UICollectionViewDelegateFlowLayout, UIImagePickerControllerDelegate, UINavigationControllerDelegate, DataSendDelegate, Alertable{
  
  let cellId = "cellId"
  let headerId = "headerId"
  
  var craftsId: String?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    collectionView.backgroundColor = .white
    
    setupNavigationButtons()
    
    collectionView.register(CRequestHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
    
    setupView()
    
    sendBtn.backgroundColor = UIColor.rgb(red: 190, green: 150, blue: 71)
    dateBtn.backgroundColor = UIColor.rgb(red: 245, green: 130, blue: 12)
    timeBtn.backgroundColor = UIColor.rgb(red: 245, green: 130, blue: 12)
    
    fetchCrafts()
    
    handleTxtInputChange()
    
    view.bindToKeyboard()
    
    let tap = UITapGestureRecognizer(target: self, action: #selector(handleScreenTap(sender:)))
    self.view.addGestureRecognizer(tap)
  }
  
  @objc func handleScreenTap(sender: UITapGestureRecognizer){
    self.view.endEditing(true)
  }
  
  func sendDataDelegate(data: String) {
    self.dateLbl.text = data
    dateLbl.textColor = .black
    dateLbl.font = UIFont.systemFont(ofSize: 15)
  }
  
  func sendTimedelegate(time: String) {
    self.timeLbl.text = time
    timeLbl.textColor = .black
    timeLbl.font = UIFont.systemFont(ofSize: 15)
  }
  
//  @objc func saveDateAndTime(){
//    let defaults = UserDefaults.standard
//    timeLbl.text = defaults.string(forKey: "timeLbl")
//
//    let defaultss = UserDefaults.standard
//    dateLbl.text = defaultss.string(forKey: "dateLbl")
//
//    print(dateLbl.text ?? "")
//  }
  
  let descriptionTxtField: UITextField = {
    let tf = UITextField()
    tf.font = UIFont.boldSystemFont(ofSize: 14)
    tf.placeholder = "Description of problem"
    tf.addTarget(self, action: #selector(handleTxtInputChange), for: .editingChanged)
    return tf
  }()
  
  let separatorView: UIView = {
    let view = UIView()
    view.backgroundColor = .black
    return view
  }()
  
  let sendLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 12)
    label.text = "Send images of problem."
    return label
  }()
  
  var imageBtn: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(named: "addImage")!.withRenderingMode(.alwaysOriginal), for: .normal)
    button.addTarget(self, action: #selector(handlePlusPhoto), for: .touchUpInside)
    return button
  }()
  
  let dateBtn: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Date", for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
    button.layer.borderColor = UIColor.lightGray.cgColor
    button.layer.borderWidth = 1
    button.layer.cornerRadius = 5
    
    button.addTarget(self, action: #selector(handleDate), for: .touchUpInside)
    return button
  }()
  
  let timeBtn: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Time", for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
    button.layer.borderColor = UIColor.lightGray.cgColor
    button.layer.borderWidth = 1
    button.layer.cornerRadius = 5
    
    button.addTarget(self, action: #selector(handleTime), for: .touchUpInside)
    return button
  }()
  
  let dateLbl: UILabel = {
    let label = UILabel()
    label.text = "Enter date"
    label.textColor = .lightGray
    label.font = UIFont.systemFont(ofSize: 12)
    return label
  }()
  
  let timeLbl: UILabel = {
    let label = UILabel()
    label.text = "Enter time"
    label.textColor = .lightGray
    label.font = UIFont.systemFont(ofSize: 12)
    return label
  }()
  
  let addressTxtField: UITextField = {
    let tf = UITextField()
    tf.font = UIFont.boldSystemFont(ofSize: 14)
    tf.placeholder = "Enter address"
    tf.addTarget(self, action: #selector(handleTxtInputChange), for: .editingChanged)
    return tf
  }()
  
  let nameOrPhoneTxtField: UITextField = {
    let tf = UITextField()
    tf.font = UIFont.boldSystemFont(ofSize: 14)
    tf.placeholder = "Enter Name or phone"
    tf.addTarget(self, action: #selector(handleTxtInputChange), for: .editingChanged)
    return tf
  }()
  
  let separator: UIView = {
    let view = UIView()
    view.backgroundColor = .black
    return view
  }()
  
  let sep: UIView = {
    let view = UIView()
    view.backgroundColor = .black
    return view
  }()
  
  let sendBtn: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("SENDING", for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
    button.layer.borderColor = UIColor.lightGray.cgColor
    button.layer.borderWidth = 1
    button.layer.cornerRadius = 5
    
    button.addTarget(self, action: #selector(handleSendingRequest), for: .touchUpInside)
    return button
  }()
  
  fileprivate func setupView(){
    view.addSubview(descriptionTxtField)
    descriptionTxtField.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 200, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 250, height: 60)
    
    view.addSubview(separatorView)
    separatorView.anchor(top: descriptionTxtField.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 250, height: 0.5)
    
    view.addSubview(sendLabel)
    sendLabel.anchor(top: separatorView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    
    view.addSubview(imageBtn)
    imageBtn.anchor(top: sendLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 4, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 100, height: 100)
    
    view.addSubview(dateBtn)
    dateBtn.anchor(top: imageBtn.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 70, height: 40)
    
    view.addSubview(dateLbl)
    dateLbl.anchor(top: imageBtn.bottomAnchor, left: dateBtn.rightAnchor, bottom: nil, right: nil, paddingTop: 23, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    
    view.addSubview(timeBtn)
    timeBtn.anchor(top: dateBtn.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 70, height: 40)
    
    view.addSubview(timeLbl)
    timeLbl.anchor(top: dateLbl.bottomAnchor, left: timeBtn.rightAnchor, bottom: nil, right: nil, paddingTop: 27, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    
    view.addSubview(addressTxtField)
    addressTxtField.anchor(top: timeBtn.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 250, height: 60)
    
    view.addSubview(separator)
    separator.anchor(top: addressTxtField.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 1, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 250, height: 0.5)
    
    view.addSubview(nameOrPhoneTxtField)
    nameOrPhoneTxtField.anchor(top: separator.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 250, height: 60)
    
    view.addSubview(sep)
    sep.anchor(top: nameOrPhoneTxtField.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 1, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 250, height: 0.5)
    
    view.addSubview(sendBtn)
    sendBtn.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 50, paddingBottom: 12, paddingRight: 50, width: 235, height: 55)

  }
  
  @objc func handleSendingRequest(){
    print("Sending request...")
    
    saveRequest()
  }
  
  @objc func handleDate(){
    
    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    let dateVC = mainStoryboard.instantiateViewController(withIdentifier: "DatePopupVC") as! DatePopupVC
    
    dateVC.dataSendDelegate = (self as DataSendDelegate)
    
    present(dateVC, animated: true, completion: nil)
  }
  
  @objc func handleTime(){
    
    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    let timeVC = mainStoryboard.instantiateViewController(withIdentifier: "TimaPopUpVC") as! DatePopupVC
    
    timeVC.dataSendDelegate = (self as DataSendDelegate)
    
    present(timeVC, animated: true, completion: nil)
  }
  
  @objc func handlePlusPhoto(){
    let imagePickerController = UIImagePickerController()
    imagePickerController.delegate = self
    imagePickerController.allowsEditing = true
    present(imagePickerController, animated: true, completion: nil)
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
      imageBtn.setImage(editedImage.withRenderingMode(.alwaysOriginal), for: .normal)
    }else if let chosenImage = info[.originalImage] as? UIImage {
      imageBtn.setImage(chosenImage.withRenderingMode(.alwaysOriginal), for: .normal)
    } else{
      print("Something went wrong")
    }
    
    dismiss(animated: true, completion: nil)
    
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 1, left: 0, bottom: 0, right: 0)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    let width = view.frame.width
    return CGSize(width: width, height: width - 250)
  }
  
  override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerId", for: indexPath) as! CRequestHeader
    
    header.crafts = self.crafts
    
    return header

  }
  
  override var prefersStatusBarHidden: Bool{
    return true
  }
  
  fileprivate func setupNavigationButtons(){
    navigationItem.title = "Complete Request"
    navigationController?.navigationBar.tintColor = .black
    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
  }
  
  @objc func handleCancel(){
    dismiss(animated: true, completion: nil)
  }
  
  fileprivate func saveRequest(){
    guard let descriptionTextField = descriptionTxtField.text else { return }
    guard let nameOrPhone = nameOrPhoneTxtField.text else { return }
    guard let dateLbl = dateLbl.text else { return }
    guard let timeLbl = timeLbl.text else { return }
    guard let addressTextfield = addressTxtField.text else { return }
    guard let uid = Auth.auth().currentUser?.uid else { return }
    guard let craftsName = crafts?.username  else { return }
    guard let craftsType = crafts?.craftsType  else { return }
    let location = "Cairo"
    guard let craftsUid = crafts?.uid else { return }
    
    guard let image = self.imageBtn.imageView?.image else { return }
    guard let uploadData = image.jpegData(compressionQuality: 0.3) else { return }
    
    let fileName = NSUUID().uuidString
    
    let storageRef = Storage.storage().reference().child("requestImage").child(fileName)
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
        
        let requestImageUrl = downloadURL.absoluteString
        
        let values = ["uid": uid , "nameOrPhone": nameOrPhone, "descriptionTextField": descriptionTextField, "requestImageUrl": requestImageUrl,  "dateLbl": dateLbl, "timeLbl": timeLbl, "addressTextfield": addressTextfield, "craftsName": craftsName, "craftsType": craftsType, "location": location, "craftsUid": craftsUid] as [String : Any]
        
        Database.database().reference().child("Request").childByAutoId().updateChildValues(values) { (err, ref) in
          if let err = err {
            print("Failed to insert comment:", err)
            
            self.showAlert(ERROR_MSG_UNEXPECTED_ERROR)
          } else {
             print("Successfully sending request")
            
            self.descriptionTxtField.text = ""
            self.nameOrPhoneTxtField.text = ""
            self.addressTxtField.text = ""
            self.dateLbl.text = ""
            self.timeLbl.text = ""
            self.imageBtn.setImage(UIImage(named: "addImage")!.withRenderingMode(.alwaysOriginal), for: .normal)
            self.sendBtn.isEnabled = false
            self.sendBtn.backgroundColor = UIColor.rgb(red: 190, green: 150, blue: 71)
            
           self.showAlertMessage(REQUEST_SEND_SUCCESSFULLY)
          }
        }
      }
    })
  }
  
  @objc func handleTxtInputChange(){
    let isFormValid = !(descriptionTxtField.text?.isEmpty)!  && !(addressTxtField.text?.isEmpty)! && !(nameOrPhoneTxtField.text?.isEmpty)!
    
    if isFormValid{
      sendBtn.isEnabled = true
      sendBtn.backgroundColor = UIColor.rgb(red: 245, green: 130, blue: 12)
    }else{
      sendBtn.isEnabled = false
      sendBtn.backgroundColor = UIColor.rgb(red: 190, green: 150, blue: 71)
    }
    
  }
  
  var crafts: Crafts?
  fileprivate func fetchCrafts(){
    
    let uid = craftsId ?? (Auth.auth().currentUser?.uid ?? "")
    
    //   guard let uid = Auth.auth().currentUser?.uid else { return }
    
    Database.fetchCraftsmenWithUid(uid: uid) { (crafts) in
      self.crafts = crafts
      
      print(crafts.username)
      
      self.collectionView.reloadData()
    }
  }
 
}
