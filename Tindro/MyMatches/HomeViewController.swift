//
//  HomeViewController.swift
//  Tindro
//
//  Created by Salem Abdulla on 10/2/17.
//  Copyright © 2017 Salem Abdulla. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBAction func myProfileButton(_ sender: Any) {
        let mainStoryboard = UIStoryboard(name: "Auth", bundle: nil)
        guard let targetVC = mainStoryboard.instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileViewController else { return }
//        self.dismiss(animated: true, completion: nil)
        self.present(targetVC, animated: true, completion: nil)
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }


    



}
