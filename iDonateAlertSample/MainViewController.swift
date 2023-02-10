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
    
    @IBAction func presentDefault() {
        let alert = iDonateAlert()
        alert.present(over: self)
    }
    
    @IBAction func presentCustomButtons() {
        let alert = iDonateAlert()
        alert.removeAllActions()
        alert.addAction(.init(title: "INDIVIDUAL DONATION", image: nil, url: URL(string: "https://www.google.com")!))
        alert.present(over: self)
    }
    
    @IBAction func presentCustomTitle() {
        let alert = iDonateAlert(title: "Donate", message: "Donation lorem impsum...")
        alert.present(over: self)
    }
    
    @IBAction func presentCustomAttributedTitle() {
        let attributedTitle = NSAttributedString(string: "Donate")
        let attributedMessage = NSAttributedString(string: "Donation lorem impsum...")
        let alert = iDonateAlert(attributedTitle: attributedTitle, attributedMessage: attributedMessage)
        alert.present(over: self)
    }
}
