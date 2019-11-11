//
//  SettingVC.swift
//  7erfety App
//
//  Created by AHMED on 7/29/1398 AP.
//  Copyright © 1398 AHMED. All rights reserved.
//

import UIKit
import AVKit

class SettingVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
  
  @IBAction func buttonAction(_ sender: Any)
  {
    if let path = Bundle.main.path(forResource: "video", ofType: "mp4")
    {
      let video = AVPlayer(url: URL(fileURLWithPath: path))
      let videoPlayer = AVPlayerViewController()
      videoPlayer.player = video
      
      present(videoPlayer, animated: true, completion:
        {
          video.play()
      })
    }
  }
  
  @IBAction func cancelBtnWasPressed(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }

}
