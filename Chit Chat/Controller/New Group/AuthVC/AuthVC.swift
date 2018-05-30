//
//  LoginVC.swift
//  Chit Chat
//
//  Created by Vinoth Vino on 29/05/18.
//  Copyright © 2018 CoderEarth. All rights reserved.
//

import UIKit

class AuthVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginWithFacebookDidTap(_ sender: Any) {
    }

    @IBAction func loginWithGoogleDidTap(_ sender: Any) {
    }
    
    @IBAction func loginWithEmailDidTap(_ sender: Any) {
        
        let loginVC = storyboard?.instantiateViewController(withIdentifier: "LoginVC")
        present(loginVC!, animated: true, completion: nil)
    }
    
}
