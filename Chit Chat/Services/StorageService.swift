//
//  StorageService.swift
//  Chit Chat
//
//  Created by Vinoth Vino on 06/06/18.
//  Copyright © 2018 CoderEarth. All rights reserved.
//

import Foundation
import Firebase

let STORAGE_BASE = Storage.storage().reference()

class StorageService {
    
    var image: UIImage
    init(image: UIImage) {
        self.image = image
    }
    convenience init() {
        self.init()
    }
    static let instance = StorageService()
    private var _STORAGE_REF_BASE = STORAGE_BASE
    private var _STORAGE_REF_PROFILEIMAGE = STORAGE_BASE.child("profileImages")
    
    var STORAGE_REF_BASE: StorageReference {
        return _STORAGE_REF_BASE
    }
    
    var STORAGE_REF_PROFILEIMAGE: StorageReference {
        return _STORAGE_REF_PROFILEIMAGE
    }
    
    //MARK - Uploading Images to Firebase
    func saveProfileImage(_ userUID: String, _ completion: @escaping (_ imageSaved: Bool, _ error: Error?) -> Void) {
        let resizedImage = image.resized()
        if let imageData = UIImageJPEGRepresentation(resizedImage, 0.9) {
            let filePath = "IMG_\("".currentTimeInMilliSeconds())"
            let metaDataForImage = StorageMetadata()
            metaDataForImage.contentType = "image/jpeg"
            STORAGE_REF_PROFILEIMAGE.child(filePath).putData(imageData, metadata: metaDataForImage, completion: { (metadata, error) in
                if error != nil {
                    completion(false, error)
                    return
                }
                //MARK - Uploading Image URL
                self.STORAGE_REF_PROFILEIMAGE.child(filePath).downloadURL(completion: { (url, error) in
                    if url != nil {
                        guard let profileImageURL = url?.absoluteString else { return }
                        DataService.instance.REF_USERS.child(userUID).updateChildValues(["profileImageURL": profileImageURL], withCompletionBlock: { (error, reference) in
                            if error == nil {
                                print("URL Uploaded to Firebase DB")
                            } else {
                                completion(false, error)
                                print("Failed to upload Image URL to Firebase DB")
                            }
                        })
                    }
                })
                print("Image uploaded to Firebase successfully")
                completion(true, error)
            })
        }
    }
}

private extension UIImage {
    
    func resized() -> UIImage {
        let height: CGFloat = 1000.0
        let ratio = self.size.width / self.size.height
        let width = height * ratio
        
        let newSize = CGSize(width: width, height: height)
        let newRect = CGRect(x: 0, y: 0, width: width, height: height)
        
        // Context - Canvas
        UIGraphicsBeginImageContext(newSize)
        
        // Draw the newly sized image on the canvas
        self.draw(in: newRect)
        
        // Get the new sized image
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        
        // Close the canvas
        UIGraphicsEndImageContext()
        
        return resizedImage!
    }
}

