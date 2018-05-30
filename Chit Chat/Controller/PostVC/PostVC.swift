//
//  PostVC.swift
//  Chit Chat
//
//  Created by Vinoth Vino on 30/05/18.
//  Copyright © 2018 CoderEarth. All rights reserved.
//

import UIKit
import Firebase

class PostVC: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var postBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        contentTextView.delegate = self
    }
    
    @IBAction func postDidTap(_ sender: Any) {
        if contentTextView.text != nil && contentTextView.text != "Write something here.." {
            postBtn.isEnabled = false
            DataService.instance.uploadPost(withMessage: contentTextView.text!, forUID: (Auth.auth().currentUser?.uid)!, withGroupKey: nil, postComplete: { (isComplete) in
                if isComplete {
                    self.postBtn.isEnabled = false
                    self.dismiss(animated: true, completion: nil)
                } else {
                    self.postBtn.isEnabled = true
                    print("Error while posting")
                }
            })
        }
    }
    
    @IBAction func closeDidTap(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension PostVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
    }
}
