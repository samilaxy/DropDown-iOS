//
//  ViewController.swift
//  UIKIT-FieldDropDown
//
//  Created by Samuel on 10/11/24.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var tf: UITextField!
    var dataSource: [String] = []
    let transparentView = UIView()
    let dropDownTableView = UITableView()
    var selectedView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tf?.delegate = self
        self.view.addSubview(transparentView)
        dataSource = ["Fitz","Samuel","Maxwell"]
    }
 
    @IBAction func tftab(_ sender: Any) {
        print("TextField was tapped!")
        addTransparentView(frames: tf.frame)
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
            // Perform your action here
        print("TextField was tapped!")
    }
    func addTransparentView(frames: CGRect) {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            transparentView.frame = window.frame
        } else {
            transparentView.frame = self.view.frame
        }
    }
}



    /////table view
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = dataSource[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        removeTransparentView()
        if selectedView == jobCodeDropDownView {
            selectedJobCode = dataSource[indexPath.row]
        }
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        removeTransparentView()
        if selectedView == jobCodeDropDownView {
            selectedJobCode = dataSource[indexPath.row]
        }
    }
}
