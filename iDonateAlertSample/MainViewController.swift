//
//  MainViewController.swift
//  iDonateAlert
//
//  Created by Furkan Eruçar on 10.02.2023.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    @IBOutlet var button4: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons()
    }
    
    func setupButtons() {
        button1.layer.borderWidth = 2
        button1.layer.cornerRadius = 8
        button1.layer.borderColor = #colorLiteral(red: 0.5333333333, green: 0.7450980392, blue: 0.2509803922, alpha: 1)
        button1.setImage(UIImage(named: "ahbap"), for: .normal)

        button2.layer.borderWidth = 2
        button2.layer.cornerRadius = 8
        button2.layer.borderColor = #colorLiteral(red: 0, green: 0.3294117647, blue: 0.6509803922, alpha: 1)
        button2.setImage(UIImage(named: "afad"), for: .normal)

        button3.layer.borderWidth = 2
        button3.layer.cornerRadius = 8
        button3.layer.borderColor = #colorLiteral(red: 0.8705882353, green: 0.1647058824, blue: 0.1725490196, alpha: 1)
        button3.setImage(UIImage(named: "turkkizilayi"), for: .normal)

        button4.layer.borderWidth = 2
        button4.layer.cornerRadius = 8
        button4.layer.borderColor = #colorLiteral(red: 0.1450980392, green: 0.2, blue: 0.2588235294, alpha: 1)
        button4.setImage(UIImage(named: "personaldonate"), for: .normal)
    }
    
    @IBAction func button1(_ sender: UIButton) {
        // will be implement
    }
    
    @IBAction func button2(_ sender: UIButton) {
        // will be implement
    }
    
    @IBAction func button3(_ sender: UIButton) {
        // will be implement
    }
    
    @IBAction func button4(_ sender: UIButton) {
        // will be implement
    }
}
