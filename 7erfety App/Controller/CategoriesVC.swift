//
//  CategoriesVC.swift
//  7erfety App
//
//  Created by AHMED on 7/20/1398 AP.
//  Copyright © 1398 AHMED. All rights reserved.
//

import UIKit

class CategoriesVC: UIViewController {
  
  @IBOutlet weak var allCraftsmenBtn: RoundedShadowButton!
  @IBOutlet weak var electBtn: RoundedShadowButton!
  @IBOutlet weak var carpenterBtn: RoundedShadowButton!
  @IBOutlet weak var plumberBtn: RoundedShadowButton!
  @IBOutlet weak var applianceBtn: RoundedShadowButton!
  @IBOutlet weak var paintingBtn: RoundedShadowButton!
  @IBOutlet weak var airBtn: RoundedShadowButton!
  @IBOutlet weak var gypsBtn: RoundedShadowButton!
  @IBOutlet weak var lasterBtn: RoundedShadowButton!
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
  
  @IBAction func allBtnWasPressed(_ sender: Any) {
//    allCraftsmenBtn.backgroundColor = UIColor.rgb(red: 243, green: 120, blue: 90)
//
//    carpenterBtn.backgroundColor = UIColor.rgb(red: 245, green: 130, blue: 12)
//    electBtn.backgroundColor = UIColor.rgb(red: 245, green: 130, blue: 12)
//    plumberBtn.backgroundColor = UIColor.rgb(red: 245, green: 130, blue: 12)
//    applianceBtn.backgroundColor = UIColor.rgb(red: 245, green: 130, blue: 12)
//    paintingBtn.backgroundColor = UIColor.rgb(red: 245, green: 130, blue: 12)
//    airBtn.backgroundColor = UIColor.rgb(red: 245, green: 130, blue: 12)
//    gypsBtn.backgroundColor = UIColor.rgb(red: 245, green: 130, blue: 12)
//    lasterBtn.backgroundColor = UIColor.rgb(red: 245, green: 130, blue: 12)
  }
  
  @IBAction func carpenterBtnWasPressed(_ sender: Any) {
//      carpenterBtn.backgroundColor = UIColor.rgb(red: 243, green: 120, blue: 90)
    
//      allCraftsmenBtn.backgroundColor = UIColor.rgb(red: 245, green: 130, blue: 12)
//      electBtn.backgroundColor = UIColor.rgb(red: 245, green: 130, blue: 12)
//      plumberBtn.backgroundColor = UIColor.rgb(red: 245, green: 130, blue: 12)
//      applianceBtn.backgroundColor = UIColor.rgb(red: 245, green: 130, blue: 12)
//      paintingBtn.backgroundColor = UIColor.rgb(red: 245, green: 130, blue: 12)
//      airBtn.backgroundColor = UIColor.rgb(red: 245, green: 130, blue: 12)
//      gypsBtn.backgroundColor = UIColor.rgb(red: 245, green: 130, blue: 12)
//      lasterBtn.backgroundColor = UIColor.rgb(red: 245, green: 130, blue: 12)
    
    let layout = UICollectionViewFlowLayout()
    let carpenterVC = CarpenterVC(collectionViewLayout: layout)
    
    let navController = UINavigationController(rootViewController: carpenterVC)
    
    present(navController, animated: true, completion: nil)
    
  }
  
  @IBAction func plumberBtnWasPressed(_ sender: Any) {
//      plumberBtn.backgroundColor = UIColor.rgb(red: 243, green: 120, blue: 90)
//
//
//      allCraftsmenBtn.backgroundColor = UIColor.rgb(red: 245, green: 130, blue: 12)
//      electBtn.backgroundColor = UIColor.rgb(red: 245, green: 130, blue: 12)
//      carpenterBtn.backgroundColor = UIColor.rgb(red: 245, green: 130, blue: 12)
//      applianceBtn.backgroundColor = UIColor.rgb(red: 245, green: 130, blue: 12)
//      paintingBtn.backgroundColor = UIColor.rgb(red: 245, green: 130, blue: 12)
//      airBtn.backgroundColor = UIColor.rgb(red: 245, green: 130, blue: 12)
//      gypsBtn.backgroundColor = UIColor.rgb(red: 245, green: 130, blue: 12)
//      lasterBtn.backgroundColor = UIColor.rgb(red: 245, green: 130, blue: 12)
    
  }
  
  @IBAction func electricianBtnWasPressed(_ sender: Any) {
//      electBtn.backgroundColor = UIColor.rgb(red: 243, green: 120, blue: 90)
//
//
//      allCraftsmenBtn.backgroundColor = UIColor.rgb(red: 245, green: 130, blue: 12)
//      carpenterBtn.backgroundColor = UIColor.rgb(red: 245, green: 130, blue: 12)
//      plumberBtn.backgroundColor = UIColor.rgb(red: 245, green: 130, blue: 12)
//      applianceBtn.backgroundColor = UIColor.rgb(red: 245, green: 130, blue: 12)
//      paintingBtn.backgroundColor = UIColor.rgb(red: 245, green: 130, blue: 12)
//      airBtn.backgroundColor = UIColor.rgb(red: 245, green: 130, blue: 12)
//      gypsBtn.backgroundColor = UIColor.rgb(red: 245, green: 130, blue: 12)
//      lasterBtn.backgroundColor = UIColor.rgb(red: 245, green: 130, blue: 12)
    
  }
  
  @IBAction func applianceBtnWasPressed(_ sender: Any) {
//      applianceBtn.backgroundColor = UIColor.rgb(red: 243, green: 120, blue: 90)
//
//
//      allCraftsmenBtn.backgroundColor = UIColor.rgb(red: 245, green: 130, blue: 12)
//      electBtn.backgroundColor = UIColor.rgb(red: 245, green: 130, blue: 12)
//      plumberBtn.backgroundColor = UIColor.rgb(red: 245, green: 130, blue: 12)
//      carpenterBtn.backgroundColor = UIColor.rgb(red: 245, green: 130, blue: 12)
//      paintingBtn.backgroundColor = UIColor.rgb(red: 245, green: 130, blue: 12)
//      airBtn.backgroundColor = UIColor.rgb(red: 245, green: 130, blue: 12)
//      gypsBtn.backgroundColor = UIColor.rgb(red: 245, green: 130, blue: 12)
//      lasterBtn.backgroundColor = UIColor.rgb(red: 245, green: 130, blue: 12)
    
  }
  
  @IBAction func paintingBtnWasPressed(_ sender: Any) {
//      paintingBtn.backgroundColor = UIColor.rgb(red: 243, green: 120, blue: 90)
//
//
//      allCraftsmenBtn.backgroundColor = UIColor.rgb(red: 245, green: 130, blue: 12)
//      electBtn.backgroundColor = UIColor.rgb(red: 245, green: 130, blue: 12)
//      plumberBtn.backgroundColor = UIColor.rgb(red: 245, green: 130, blue: 12)
//      applianceBtn.backgroundColor = UIColor.rgb(red: 245, green: 130, blue: 12)
//      carpenterBtn.backgroundColor = UIColor.rgb(red: 245, green: 130, blue: 12)
//      airBtn.backgroundColor = UIColor.rgb(red: 245, green: 130, blue: 12)
//      gypsBtn.backgroundColor = UIColor.rgb(red: 245, green: 130, blue: 12)
//      lasterBtn.backgroundColor = UIColor.rgb(red: 245, green: 130, blue: 12)
    
  }
  
  @IBAction func airBtnWasPressed(_ sender: Any) {
//      airBtn.backgroundColor = UIColor.rgb(red: 243, green: 120, blue: 90)
//
//
//      allCraftsmenBtn.backgroundColor = UIColor.rgb(red: 245, green: 130, blue: 12)
//      plumberBtn.backgroundColor = UIColor.rgb(red: 245, green: 130, blue: 12)
//      applianceBtn.backgroundColor = UIColor.rgb(red: 245, green: 130, blue: 12)
//      electBtn.backgroundColor = UIColor.rgb(red: 245, green: 130, blue: 12)
//      paintingBtn.backgroundColor = UIColor.rgb(red: 245, green: 130, blue: 12)
//      carpenterBtn.backgroundColor = UIColor.rgb(red: 245, green: 130, blue: 12)
//      gypsBtn.backgroundColor = UIColor.rgb(red: 245, green: 130, blue: 12)
//      lasterBtn.backgroundColor = UIColor.rgb(red: 245, green: 130, blue: 12)
    
  }
  
  @IBAction func gypsBtnWasPressed(_ sender: Any) {
//      gypsBtn.backgroundColor = UIColor.rgb(red: 243, green: 120, blue: 90)
//
//
//      allCraftsmenBtn.backgroundColor = UIColor.rgb(red: 245, green: 130, blue: 12)
//      plumberBtn.backgroundColor = UIColor.rgb(red: 245, green: 130, blue: 12)
//      applianceBtn.backgroundColor = UIColor.rgb(red: 245, green: 130, blue: 12)
//      electBtn.backgroundColor = UIColor.rgb(red: 245, green: 130, blue: 12)
//      paintingBtn.backgroundColor = UIColor.rgb(red: 245, green: 130, blue: 12)
//      airBtn.backgroundColor = UIColor.rgb(red: 245, green: 130, blue: 12)
//      carpenterBtn.backgroundColor = UIColor.rgb(red: 245, green: 130, blue: 12)
//      lasterBtn.backgroundColor = UIColor.rgb(red: 245, green: 130, blue: 12)
    
  }
  
  @IBAction func lasterBtnWasPresses(_ sender: Any) {
//      lasterBtn.backgroundColor = UIColor.rgb(red: 243, green: 120, blue: 90)
//    
//    
//      allCraftsmenBtn.backgroundColor = UIColor.rgb(red: 245, green: 130, blue: 12)
//      plumberBtn.backgroundColor = UIColor.rgb(red: 245, green: 130, blue: 12)
//      electBtn.backgroundColor = UIColor.rgb(red: 245, green: 130, blue: 12)
//      applianceBtn.backgroundColor = UIColor.rgb(red: 245, green: 130, blue: 12)
//      paintingBtn.backgroundColor = UIColor.rgb(red: 245, green: 130, blue: 12)
//      airBtn.backgroundColor = UIColor.rgb(red: 245, green: 130, blue: 12)
//      gypsBtn.backgroundColor = UIColor.rgb(red: 245, green: 130, blue: 12)
//      carpenterBtn.backgroundColor = UIColor.rgb(red: 245, green: 130, blue: 12)
    
  }
  
}
