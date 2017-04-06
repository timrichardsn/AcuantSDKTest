//
//  ViewController.swift
//  AcuantSwiftTest
//
//  Created by Tim Richardson on 06/04/2017.
//  Copyright © 2017 TRCO. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var instance:AcuantMobileSDKController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        instance = AcuantMobileSDKController.initAcuantMobileSDK(withLicenseKey: "F9DB7D13F8CF", andDelegate: self)
    }
    
    @IBAction func openPassportScanner(_ sender: Any) {
        instance?.showManualCameraInterface(in: self, delegate: self, cardType: AcuantCardTypePassportCard, region: AcuantCardRegionEurope, andBackSide: false)
    }
}

// MARK: - AcuantMobileSDKControllerCapturingDelegate
extension ViewController : AcuantMobileSDKControllerCapturingDelegate {
    func didCaptureCropImage(_ cardImage: UIImage!, scanBackSide: Bool) {
        print("didCaptureCropImage")
        instance?.dismissCardCaptureInterface()
    }
    
    func didCaptureOriginalImage(_ cardImage: UIImage!) {
        print("didCaptureOriginalImage")
    }
    
    func didCaptureCropImage(_ cardImage: UIImage!, andData data: String!, scanBackSide: Bool) {
        print("didCaptureCropImage and data")
    }
    
    // called when capturing the barcode for a drivers license when using the barcode CaptureMethod (see start())
    func didCaptureData(_ data: String!) {
        print("didCaptureData \(data)")
    }
    
    func didFailWithError(_ error: AcuantError!) {
        print("didFailWithError: type: \(error.errorType) message: \(error.errorMessage)")
        
        switch error.errorType {
        case AcuantErrorInvalidLicenseKey:
            // need to coordinate an effort to listen for a network connection, at which point we can re activate
            break
        default:
            break
        }
    }
}

// MARK: - AcuantMobileSDKControllerProcessingDelegate
extension ViewController : AcuantMobileSDKControllerProcessingDelegate {
    func didFinishProcessingCard(with result: AcuantCardResult!) {
        print("didFinishProcessingCard")
    }
    
    func didFinishValidatingImage(with result: AcuantCardResult!) {
        print("didFinishValidatingImage")
    }
}
