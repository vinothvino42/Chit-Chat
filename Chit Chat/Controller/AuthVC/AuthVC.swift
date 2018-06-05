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
import FBSDKLoginKit

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
        let fbLoginManager = FBSDKLoginManager()
        fbLoginManager.logIn(withReadPermissions: ["public_profile", "email"], from: self) { (result, error) in
            if let error = error {
                print("Facebook failed to login : ",error.localizedDescription)
                return
            }
            guard let accessToken = FBSDKAccessToken.current() else {
                print("Failed to get accessToken")
                return
            }
            let credentials = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
            Auth.auth().signIn(with: credentials, completion: { (user, error) in
                if let error = error {
                    let alert = UIAlertController(title: "Failed to Login with FB", message: "\(error.localizedDescription)", preferredStyle: .alert)
                    let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: nil)
                    return
                }
                print("User logged in using google account")
                guard let email = user?.email else { return }
                guard let provider = user?.providerID else { return }
                
                let userData = ["provider": provider, "email": email]
                DataService.instance.createDBUser(uid: (user?.uid)!, userData: userData)
                self.dismiss(animated: true, completion: nil)
            })
        }
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
