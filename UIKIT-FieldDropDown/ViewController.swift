//
//  ViewController.swift
//  UIKIT-FieldDropDown
//
//  Created by Samuel on 10/11/24.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var tf: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tf?.delegate = self

    }
 
    @IBAction func tftab(_ sender: Any) {
        print("TextField was tapped!")
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
            // Perform your action here
        print("TextField was tapped!")
    }
}

