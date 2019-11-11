//
//  CustomImageView.swift
//  InstegramFirebase
//
//  Created by AHMED on 6/24/1398 AP.
//  Copyright © 1398 AHMED. All rights reserved.
//

import UIKit

var imageCache = [String: UIImage]()

class CustomImageView: UIImageView {
  
  var lastUrlUsedToLoadImage: String?
  
  func loadImage(urlString: String){
    print("loading image...")
    
    lastUrlUsedToLoadImage = urlString
    
    self.image = nil
    
    if let cachedImage = imageCache[urlString]{
      self.image = cachedImage
      return
    }
    
    guard let url = URL(string: urlString) else { return }
    
    URLSession.shared.dataTask(with: url) { (data, response, err) in
      if let err = err{
        print("Failed to fetch image:", err)
        return
      }
      
      if url.absoluteString != self.lastUrlUsedToLoadImage{
        return
      }
      
      guard let imageData = data else { return }
      
      let photoImage = UIImage(data: imageData)
      
      DispatchQueue.main.async {
        self.image = photoImage
      }
      }.resume()
  }
}
