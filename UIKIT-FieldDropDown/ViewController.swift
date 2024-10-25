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
        
        self.view.addSubview(transparentView)
        
        dropDownTableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
        self.view.addSubview(dropDownTableView)
        dropDownTableView.layer.cornerRadius = 5
        
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        dropDownTableView.reloadData()
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(removeTransparentView))
        transparentView.addGestureRecognizer(tapgesture)
        transparentView.alpha = 0
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0.5
            self.dropDownTableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height + 5, width: frames.width, height: CGFloat(self.dataSource.count * 50))
        }, completion: nil)
    }    
    @objc func removeTransparentView() {
        let frames = selectedView.frame
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0
            self.dropDownTableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
        }, completion: nil)
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
     
            tf.text = dataSource[indexPath.row]

    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        removeTransparentView()
        tf.text = dataSource[indexPath.row]
    }
}
