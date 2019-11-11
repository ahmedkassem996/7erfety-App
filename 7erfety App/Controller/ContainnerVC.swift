//
//  ContainnerVC.swift
//  7erfety App
//
//  Created by AHMED on 7/8/1398 AP.
//  Copyright © 1398 AHMED. All rights reserved.
//

import UIKit
import QuartzCore

enum SlideOutState{
  case collapsed
  case leftPanelExpanded
}

enum ShowWhichVC{
  case homeVC
  case loginVC //->
}

var showVC: ShowWhichVC = .homeVC
var showLoginVC: ShowWhichVC = .loginVC //->

class ContainnerVC: UIViewController {
  
  var homeVC: HomeVC!
  var loginVC: LoginVC! //->
  var leftVC: LeftSidePanelVC!
  var centerController: UIViewController!
  var currentState: SlideOutState = .collapsed{
    didSet{
      let shouldShowShadow = (currentState != .collapsed)
      shouldShowShadowForCenterViewController(status: shouldShowShadow)
    }
  }
  
  var isHidden = false
  let centerPannelExpandedOffset: CGFloat = 160
  
  var tap: UITapGestureRecognizer!

    override func viewDidLoad() {
        super.viewDidLoad()
     // initCenter(screen: showVC)
      initCenter(screen: showLoginVC)//->
  }
  
  func initCenter(screen: ShowWhichVC){
    var presentingController: UIViewController
 //   showVC = screen
    showLoginVC = screen//->
    
    if homeVC == nil{
      homeVC = UIStoryboard.homeVC()
      homeVC.delegate = self
    }
    
//    if loginVC == nil{
//      loginVC = UIStoryboard.loginVC()
//      loginVC.delegate = self
//    }
    
//    presentingController = loginVC  //->
    
    presentingController = homeVC
  
    if let con = centerController{
      con.view.removeFromSuperview()
      con.removeFromParent()
    }
    
    centerController = presentingController
    
    view.addSubview(centerController.view)
    addChild(centerController)
    centerController.didMove(toParent: self)
  }
  
  override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation{
    return UIStatusBarAnimation.slide
  }
  
  override var prefersStatusBarHidden: Bool{
    return isHidden
  }
  
}

extension ContainnerVC: CenterVCDelegate{
  func toggleLeftPanel() {
    let notAleradyExpanded = (currentState != .leftPanelExpanded)
    
    if notAleradyExpanded{
      addLeftPanelViewController()
    }
    animateLeftPanel(shouldExpand: notAleradyExpanded)
  }
  
  func addLeftPanelViewController() {
    if leftVC == nil{
      leftVC = UIStoryboard.leftViewController()
      addChildSidePanelViewController(leftVC!)
    }
  }
  
  func addChildSidePanelViewController(_ sidePanelController: LeftSidePanelVC){
    view.insertSubview(sidePanelController.view, at: 0)
    addChild(sidePanelController)
    sidePanelController.didMove(toParent: self)
  }
  
  @objc func animateLeftPanel(shouldExpand: Bool) {
    if shouldExpand{
      isHidden = !isHidden
      
      animateStatusBar()
      
      setupWhiteCoverView()
      
      currentState = .leftPanelExpanded
      
      animatecenterPanelXPosition(targetPosition: centerController.view.frame.width - centerPannelExpandedOffset)
    }else{
      isHidden = !isHidden
      
      animateStatusBar()
      
      hideWhiteCoverView()
      
      animatecenterPanelXPosition(targetPosition: 0) { (finished) in
        if finished == true{
          self.currentState = .collapsed
          self.leftVC = nil
        }
      }
    }
  }
  
  func animatecenterPanelXPosition(targetPosition: CGFloat, completion: ((Bool) -> Void)! = nil){
    UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
      self.centerController.view.frame.origin.x = targetPosition
    }, completion: completion)
  }
  
  func setupWhiteCoverView(){
    let whiteCoverView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
    whiteCoverView.alpha = 0.0
    whiteCoverView.backgroundColor = UIColor.white
    whiteCoverView.tag = 25
    
    self.centerController.view.addSubview(whiteCoverView)
    UIView.animate(withDuration: 0.2) {
      whiteCoverView.alpha = 0.75
    }
    
    tap = UITapGestureRecognizer(target: self, action: #selector(animateLeftPanel(shouldExpand:)))
    tap.numberOfTapsRequired = 1
    
    self.centerController.view.addGestureRecognizer(tap)
    
  }
  
  func hideWhiteCoverView(){
    centerController.view.removeGestureRecognizer(tap)
    
    for subView in centerController.view.subviews{
      if subView.tag == 25{
        UIView.animate(withDuration: 0.2, animations: {
          subView.alpha = 0.0
        }) { (finished) in
          subView.removeFromSuperview()
        }
      }
    }
  }
  
  func shouldShowShadowForCenterViewController(status: Bool){
    if status == true {
      centerController.view.layer.shadowOpacity = 0.6
    }else{
      centerController.view.layer.shadowOpacity = 0.0
    }
  }
  
  func animateStatusBar(){
    UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
      self.setNeedsStatusBarAppearanceUpdate()
    })
  }
  
}

private extension UIStoryboard{
  class func mainStoryBoard() -> UIStoryboard{
    return UIStoryboard(name: "Main", bundle: Bundle.main)
  }
  
  class func leftViewController() -> LeftSidePanelVC?{
    return mainStoryBoard().instantiateViewController(withIdentifier: "LeftSidePanelVC") as? LeftSidePanelVC
  }
  
  class func homeVC() -> HomeVC?{
    return mainStoryBoard().instantiateViewController(withIdentifier: "HomeVC") as? HomeVC
  }
  
  //->
  class func loginVC() -> LoginVC?{
    return mainStoryBoard().instantiateViewController(withIdentifier: "loginVC") as? LoginVC
  }
  
}
