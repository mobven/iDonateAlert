//
//  MainViewController.swift
//  iDonateAlert
//
//  Created by Furkan Eruçar on 10.02.2023.
//

import UIKit
import iDonateAlert

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func presentAlert() {
        let alert = iDonateAlert(title: "Test", message: "Test")
        alert.present(over: self)
    }
}
