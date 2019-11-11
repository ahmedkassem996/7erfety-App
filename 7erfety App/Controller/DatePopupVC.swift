//
//  DatePopupVC.swift
//  7erfety App
//
//  Created by AHMED on 7/18/1398 AP.
//  Copyright © 1398 AHMED. All rights reserved.
//

import UIKit
import Firebase

protocol DataSendDelegate {
  func sendDataDelegate(data:String)
  func sendTimedelegate(time: String)
}

class DatePopupVC: UIViewController {
  
  @IBOutlet weak var timePicker: UIDatePicker!
  @IBOutlet weak var datePicker: UIDatePicker!
  
  var txtDatePicker: String?
  var txtTimePicker: String?
  
  var dataSendDelegate: DataSendDelegate? = nil
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
  
  func saveDatePicker(){
    let formatter = DateFormatter()
    formatter.dateFormat = "dd/MM/yyyy"
    txtDatePicker = formatter.string(from: datePicker.date)
    
    dataSendDelegate?.sendDataDelegate(data: txtDatePicker!)
    
//    let defaults = UserDefaults.standard
//    defaults.set(txtDatePicker,forKey: "dateLbl")
//    defaults.synchronize()
  }
  
  func saveTimePicker(){
    let formatter = DateFormatter()
    formatter.dateFormat = "hh:mm:ss"
    txtTimePicker = formatter.string(from: timePicker.date)
    
    dataSendDelegate?.sendTimedelegate(time: txtTimePicker!)
    
//    let defaults = UserDefaults.standard
//    defaults.set(txtTimePicker,forKey: "timeLbl")
//    defaults.synchronize()
  }
    
  @IBAction func saveDateBtnWasPressed(){
    saveDatePicker()
    
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func saveTimeBtnWasPressed(){
    saveTimePicker()
    
    dismiss(animated: true, completion: nil)
  }

}
