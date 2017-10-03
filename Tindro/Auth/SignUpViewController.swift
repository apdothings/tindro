//
//  SignUpViewController.swift
//  Tindro
//
//  Created by Salem Abdulla on 10/2/17.
//  Copyright © 2017 Salem Abdulla. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SignUpViewController: UIViewController {


    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Sign Up"
    }
    
    @IBOutlet weak var signUpButton: UIButton! {
        didSet {
            signUpButton.addTarget(self, action: #selector(signUpUser), for: .touchUpInside)
        }
    }
    
    // MARK: SignUpUser() Function is Here
    func signUpUser() {
        guard let email = emailTextField.text,
            let password = passwordTextField.text,
            let confirmPassword = confirmTextField.text else {return}
        
        if password != confirmPassword {
            PromptHandler.showPrompt(title: "Password Error", message:  "Passwords do not match", in: self)
            return
            
        } else if email == "" || password == ""{
            PromptHandler.showPrompt(title: "Missing input field ", message: "Please fill the missing fields", in: self)
            return
            
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if let validError = error {
                PromptHandler.showPrompt(title: "Error", message: "\(validError.localizedDescription)", in: self)
            }
            
            if let validUser = user {
                let ref = Database.database().reference()
                
                let post : [String : Any] = ["email" : email ]
                ref.child("users").child(validUser.uid).setValue(post)
                
//                self.navigationController?.popViewController(animated: true)
                
                let mainStoryboard = UIStoryboard(name: "Auth", bundle: nil)
                guard let targetVC = mainStoryboard.instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileViewController else { return }
                self.dismiss(animated: true, completion: nil)
                self.present(targetVC, animated: true, completion: nil)
            }
        }
    }
}

