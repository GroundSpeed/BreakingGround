//
//  PaymentViewController.swift
//  Amortized
//
//  Created by Don Miller on 1/1/16.
//  Copyright © 2016 GroundSpeed. All rights reserved.
//

import UIKit
import AVFoundation

class PaymentViewController: UIViewController {

    @IBOutlet weak var txtAmount: UITextField!
    @IBOutlet weak var txtDownPayment: UITextField!
    @IBOutlet weak var txtInterestRate: UITextField!
    @IBOutlet weak var txtTerm: UITextField!
    @IBOutlet weak var lblPayment: UILabel!
    
    @IBAction func clear(sender: AnyObject) {
        txtAmount.text = nil;
        txtDownPayment.text = nil;
        txtInterestRate.text = nil;
        txtTerm.text = nil;
        lblPayment.font = UIFont(name: "Avenir Next", size: 28)
        lblPayment.textColor = UIColor.whiteColor()
        lblPayment.text = "0.00"
    }
    
    @IBAction func calculate(sender: AnyObject) {
        // Make sure none of the values are nil
        txtAmount.text = (txtAmount.text == "") ? "0" : txtAmount.text
        txtDownPayment.text = (txtDownPayment.text == "") ? "0" : txtDownPayment.text
        txtTerm.text = (txtTerm.text == "") ? "0" : txtTerm.text
        txtInterestRate.text = (txtInterestRate.text == "") ? "0" : txtInterestRate.text
        
        lblPayment = GlobalHelper().getMonthlyPayment(Float(txtAmount.text!)!, downPayment: Float(txtDownPayment.text!)!, term: Float(txtTerm.text!)!, interestRate: Float(txtInterestRate.text!)!, lblPayment: self.lblPayment)
        
        speak(lblPayment.text!)
    }
    
    @IBOutlet weak var btnSound: UIButton!
    var soundOn : Bool = false

    @IBAction func setSound(sender: AnyObject) {
        if (!soundOn) {
            let image : UIImage = UIImage.init(named: "SoundOn.png")!
            soundOn = true
            btnSound.setImage(image, forState: UIControlState.Normal)
        } else {
            let image : UIImage = UIImage.init(named: "SoundOff.png")!
            soundOn = false
            btnSound.setImage(image, forState: UIControlState.Normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
        
    func speak(words: String) {
        if (soundOn) {
            let speechSynthesizer = AVSpeechSynthesizer()
            let synthesizer = AVSpeechUtterance(string: words)
            speechSynthesizer.speakUtterance(synthesizer)
        }
    }
    
}
