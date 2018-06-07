//
//  ProfileVC.swift
//  Chit Chat
//
//  Created by Vinoth Vino on 30/05/18.
//  Copyright © 2018 CoderEarth. All rights reserved.
//

import UIKit
import Firebase
import KVNProgress

class ProfileVC: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var profilePictureTapGesture: UITapGestureRecognizer!
    var imagePickerController: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingProfilePictureTapGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.emailLabel.text = Auth.auth().currentUser?.email
    }
    
    func settingProfilePictureTapGesture() {
        //Creating Gesture for Profile Pic ImageView
        profilePictureTapGesture = UITapGestureRecognizer(target: self, action: #selector(ProfileVC.setProfilePicture))
        profilePictureTapGesture.numberOfTapsRequired = 1
        profilePictureTapGesture.numberOfTouchesRequired = 1
        
        //Adding gesture for ImageView
        profileImageView.addGestureRecognizer(profilePictureTapGesture)
        profileImageView.isUserInteractionEnabled = true
    }
    
    //MARK: - Adding Profile Pictures
    @objc func setProfilePicture() {
        
        let alertSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let takePictureAction = UIAlertAction(title: "Take Picture", style: .default) { (alertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                self.imagePickerControllerWithSourceType(.camera)
            } else {
                print("Device has no camera")
            }
        }
        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { (alertAction) in
            self.imagePickerControllerWithSourceType(.photoLibrary)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertSheet.addAction(takePictureAction)
        alertSheet.addAction(photoLibraryAction)
        alertSheet.addAction(cancelAction)
        present(alertSheet, animated: true, completion: nil)
        
    }
    
    func imagePickerControllerWithSourceType(_ imagePickerSourceType: UIImagePickerControllerSourceType) {
        
        if imagePickerSourceType == .camera || imagePickerSourceType == .photoLibrary {
            imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.allowsEditing = false
            imagePickerController.sourceType = imagePickerSourceType
            present(imagePickerController, animated: true, completion: nil)
        } else {
            print("Device has no camera")
        }
    }
    
    @IBAction func signOutDidTap(_ sender: Any) {
        let logoutPopup = UIAlertController(title: "Logout?", message: "Are you sure ?", preferredStyle: .actionSheet)
        let logoutAction = UIAlertAction(title: "Logout", style: .destructive) { (alertAction) in
            do {
                KVNProgress.showProgress()
                try Auth.auth().signOut()
                let authVC = self.storyboard?.instantiateViewController(withIdentifier: "AuthVC")
                self.present(authVC!, animated: true, completion: nil)
                KVNProgress.dismiss()
            } catch {
                print(error)
                KVNProgress.dismiss()
            }
        }
        logoutPopup.addAction(logoutAction)
        present(logoutPopup, animated: true, completion: nil)
    }
    
}

extension ProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else { return }
        self.profileImageView.image = pickedImage
        self.profileImageView.contentMode = .scaleAspectFill
        self.profileImageView.setCircleImageView()
        dismiss(animated: true, completion: nil)
        StorageService(image: pickedImage).saveProfileImage((Auth.auth().currentUser?.uid)!) { (success, error) in
            if success {
                print("Image uploaded to Firebase Storage")
            } else {
                print("Failed to upload image to Firebase Storage",error?.localizedDescription)
                let alert = UIAlertController(title: "Failed to upload image", message: "\(error?.localizedDescription)", preferredStyle: .alert)
                let action = UIAlertAction(title: "Ok", style: .default, handler: { (alertAction) in
                    self.profileImageView.image = UIImage(named: "defaultProfileImage")
                    self.profileImageView.contentMode = .scaleAspectFit
                    self.profileImageView.setCircleImageView()
                })
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

