//
//  DachMainVC.swift
//  7erfety App
//
//  Created by AHMED on 8/2/1398 AP.
//  Copyright © 1398 AHMED. All rights reserved.
//

import UIKit
import Firebase

class DachMainVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
  
  @IBAction func backAppBtnWasPressed(_ sender: Any) {
    do{
     try Auth.auth().signOut()
    } catch (let error){
  print(error)
  }
    
    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    let yourVC = mainStoryboard.instantiateViewController(withIdentifier: "loginVC") as! LoginVC
    present(yourVC, animated: true, completion: nil)
  }
  
}
