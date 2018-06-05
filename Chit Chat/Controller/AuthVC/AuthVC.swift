//
//  LoginVC.swift
//  Chit Chat
//
//  Created by Vinoth Vino on 29/05/18.
//  Copyright © 2018 CoderEarth. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class AuthVC: UIViewController, GIDSignInDelegate, GIDSignInUIDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if Auth.auth().currentUser != nil {
            dismiss(animated: true, completion: nil)
        }
    }
    @IBAction func loginWithFacebookDidTap(_ sender: Any) {
        
    }

    //MARK: - Google SignIn methods
    @IBAction func loginWithGoogleDidTap(_ sender: Any) {
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signIn()
    }
    
    func sign(_ signIn: GIDSignIn!, present viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
    }
    
    func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print("Google SignIn Error : ",error.localizedDescription)
            return
        }
        print("Google didSignIn entered")
        guard let authentication = user.authentication else { return }
        let credentials = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        Auth.auth().signIn(with: credentials) { (user, error) in
            if let error = error {
                print("Firebase Google Auth Error : ",error.localizedDescription)
                return
            }
            print("User logged in using google account")
            guard let email = user?.email else { return }
            guard let provider = user?.providerID else { return }
            
            let userData = ["provider": provider, "email": email]
            DataService.instance.createDBUser(uid: (user?.uid)!, userData: userData)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func loginWithEmailDidTap(_ sender: Any) {
        let loginVC = storyboard?.instantiateViewController(withIdentifier: "LoginVC")
        present(loginVC!, animated: true, completion: nil)
    }
    
}
