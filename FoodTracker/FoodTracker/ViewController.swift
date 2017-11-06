//
//  ViewController.swift
//  FoodTracker
//
//  Created by 吉崎 生 on 2017/11/01.
//  Copyright © 2017年 Grani, Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    // MARK: - Properties:
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var mealNameLabel: UILabel! 

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Handle the text filed's user input through delegate callbacks
        nameTextField.delegate = self
    }
    
    // MARK: - UITextFieldDelegate
    
    
    // MARK: - Actions
    @IBAction func setDefaultLabelText(_ sender: UIButton) {
        mealNameLabel.text = "Default Text"
    }
}

