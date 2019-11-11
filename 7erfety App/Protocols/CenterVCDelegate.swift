//
//  CenterVCDelegate.swift
//  7erfety App
//
//  Created by AHMED on 7/8/1398 AP.
//  Copyright © 1398 AHMED. All rights reserved.
//

import Foundation

protocol CenterVCDelegate{
  func toggleLeftPanel()
  func addLeftPanelViewController()
  func animateLeftPanel(shouldExpand: Bool)
}

