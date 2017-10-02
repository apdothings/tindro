//
//  LoginViewController.swift
//  Tindro
//
//  Created by Salem Abdulla on 10/2/17.
//  Copyright © 2017 Salem Abdulla. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {

    
    var dict : [String : AnyObject]!
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!{
        didSet {
            loginButton.addTarget(self, action: #selector(loginUser), for: .touchUpInside)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //check if the user already signed in
        if Auth.auth().currentUser != nil {
//            correctSignInHandler()
        }
    }
    
}

extension LoginViewController {
    
    func loginUser() {
        guard let email = usernameTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            
            if self.usernameTextField.text == "" {
                PromptHandler.showPrompt(title: "Empty Email Field", message: "Please input valid Email", in: self)
                return
            } else if self.passwordTextField.text == "" {
                PromptHandler.showPrompt(title: "Empty Password Field", message: "Please input valid password", in: self)
                return
            }
            
            if let validError = error {
                print(validError.localizedDescription)
                //self.createErrorAlert("Error", validError.localizedDescription)
                PromptHandler.showPrompt(title: "Error", message: "\(validError.localizedDescription)", in: self)
            }
            
            if let validUser = user {
                print(validUser)
                self.correctSignInHandler()
            }
        }
    }
    
    func correctSignInHandler(){
        let mainStoryboard = UIStoryboard(name: "Home", bundle: nil)
        guard let targetVC = mainStoryboard.instantiateViewController(withIdentifier: "MymatchesHomeViewController") as? UIViewController else {
            return print("Error Alert")
        }
        self.dismiss(animated: true, completion: nil)
        present(targetVC, animated: true, completion: nil)
    }
    
}

