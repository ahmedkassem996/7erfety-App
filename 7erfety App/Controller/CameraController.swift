//
//  CameraController.swift
//  7erfety App
//
//  Created by AHMED on 7/13/1398 AP.
//  Copyright © 1398 AHMED. All rights reserved.
//

import UIKit
import AVFoundation

class CameraController: UIViewController, AVCapturePhotoCaptureDelegate, UIViewControllerTransitioningDelegate {
  
  
  let output = AVCapturePhotoOutput()
    override func viewDidLoad() {
        super.viewDidLoad()
      
      transitioningDelegate = self
      
      setupCaptureSession()
    }
  
  let customAnimationPresenter = CustomAnimationPresenter()
  let customAnimationDismisser = CustomAnimationDismisser()
  
  func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    return customAnimationPresenter
  }
  
  func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    return customAnimationDismisser
  }
  
  func handleCapturePhoto(){
    print("Capturing photo...")
    
    //    let settings = AVCapturePhotoSettings()
    
    guard let availableRawFormat = self.output.availableRawPhotoPixelFormatTypes.first else {
      return
    }
    
    let photoSettings = AVCapturePhotoSettings(rawPixelFormatType: availableRawFormat,
                                               processedFormat: [AVVideoCodecKey : AVVideoCodecType.hevc])
    
    output.capturePhoto(with: photoSettings, delegate: self)
    
    //    guard let previewFormatType = settings.availablePreviewPhotoPixelFormatTypes.first else { return }
    //
    //    settings.previewPhotoFormat = [kCVPixelBufferPixelFormatTypeKey as String: previewFormatType]
    //
    //    output.capturePhoto(with: settings, delegate: self) // ->
  }
  
  func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photoSampleBuffer: CMSampleBuffer?, previewPhoto previewPhotoSampleBuffer: CMSampleBuffer?, resolvedSettings: AVCaptureResolvedPhotoSettings, bracketSettings: AVCaptureBracketedStillImageSettings?, error: Error?) {
    
    let imageData = AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: photoSampleBuffer!, previewPhotoSampleBuffer: previewPhotoSampleBuffer!)
    let previewImage = UIImage(data: imageData!)
    
    let containnerView = PreviewPhotoContainnerView()
    containnerView.previewImageView.image = previewImage
    view.addSubview(containnerView)
    containnerView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    
    //    let previewImageView = UIImageView(image: previewImage)
    //    view.addSubview(previewImageView)
    //    previewImageView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    //
    //    print("Finishe processing photo sample buffer...")
    
  }
  
  fileprivate func setupCaptureSession(){
    let captureSession = AVCaptureSession()
    
    guard let captureDevice = AVCaptureDevice.default(for: .video) else { return }
    
    do {
      let input = try AVCaptureDeviceInput(device: captureDevice)
      if captureSession.canAddInput(input){
        captureSession.addInput(input)
      }
    } catch let err {
      print("Could not setup camera input:", err)
    }
    
    if captureSession.canAddOutput(output){
      captureSession.addOutput(output)
    }
    
    let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
    previewLayer.frame = view.frame
    view.layer.addSublayer(previewLayer)
    
    captureSession.startRunning()
    
  }
  
  @IBAction func dismissBtn(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func capturePhotoBtnWasPressed(_ sender: Any) {
    handleCapturePhoto()
  }
  
  
}
