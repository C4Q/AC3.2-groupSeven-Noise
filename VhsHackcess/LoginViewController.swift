//
//  LoginViewController.swift
//  VhsHackcess
//
//  Created by Victor Zhong on 2/19/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        loginUser()
    }
    
    @IBAction func registerButtonTapped(_ sender: UIButton) {
        registerUser()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        emailField.delegate = self
        passwordField.delegate = self
        
        //color scheme
        self.loginButton.tintColor = ColorManager.shared.primary
        self.registerButton.tintColor = ColorManager.shared.primary
    }
    
    // MARK: - Functions and Methods
    func registerUser() {
        if let email = emailField.text, let password = passwordField.text {
            registerButton.isEnabled = false
            FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user: FIRUser?, error: Error?) in
                if error != nil {
                    print("error with completion while creating new Authentication: \(error!)")
                }
                if user != nil {
                    self.showOKAlert(title: "\((user?.email)!) Created!", message: "Good Job!", dismissCompletion: {
                        action in self.navigationController?.popViewController(animated: true)
                    })
                }
                else {
                    self.showOKAlert(title: "Error", message: error?.localizedDescription)
                }
                self.registerButton.isEnabled = true
            })
        }
        
    }
    
    func loginUser() {
        if let username = emailField.text,
            let password = passwordField.text{
            loginButton.isEnabled = false
            FIRAuth.auth()?.signIn(withEmail: username, password: password, completion: { (user: FIRUser?, error: Error?) in
                if error != nil {
                    print("Error \(error)")
                }
                if user != nil {
                    self.showOKAlert(title: "\((user?.email)!) Logged In!", message: nil, dismissCompletion: {
                        //                        action in self.performSegue(withIdentifier: "userProfile", sender: self)
                        action in self.navigationController?.popViewController(animated: true)
                    })
                }
                else {
                    self.showOKAlert(title: "Error", message: error?.localizedDescription)
                }
                self.loginButton.isEnabled = true
            })
        }
    }
    
    func showOKAlert(title: String, message: String?, dismissCompletion: ((UIAlertAction) -> Void)? = nil, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .cancel, handler: dismissCompletion)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: completion)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        
        if textField == emailField {
            passwordField.becomeFirstResponder()
        }
        
        if textField == passwordField {
            loginButtonTapped(loginButton)
        }
        
        return true
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
