//
//  SettingsViewController.swift
//  Assignment1_Priyanshu
//
//  Created by Priyanshu Kaushik on 2025-02-07.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var phoneTextField: UITextField!
    
    //Handling back button functionality
    @IBAction func unwindSettings(sender: UIStoryboardSegue) { }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder();
    }
    
    func saveData(){
        let defaults = UserDefaults.standard
        
        defaults.set(nameTextField.text, forKey: "lastName")
        defaults.set(emailTextField.text, forKey: "lastEmail")
        defaults.set(phoneTextField.text, forKey: "lastPhone")
        defaults.synchronize()
    }
    
    func loadsavedData(){
        let defaults = UserDefaults.standard
        
        if let savedName = defaults.string(forKey: "lastName"){
            nameTextField.text = savedName
        }
        
        if let savedEmail = defaults.string(forKey: "lastEmail"){
            emailTextField.text = savedEmail
        }
        
        if let savedPhone = defaults.string(forKey: "lastPhone"){
            phoneTextField.text = savedPhone
        }
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
       
        saveData();
        
        
    }
    
    


    override func viewDidLoad() {
        super.viewDidLoad()

        loadsavedData()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
