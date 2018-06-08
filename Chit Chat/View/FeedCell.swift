//
//  FeedCell.swift
//  Chit Chat
//
//  Created by Vinoth Vino on 31/05/18.
//  Copyright © 2018 CoderEarth. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    func configureCell(profileImageURL: URL, email: String, content: String) {
        if profileImageURL.absoluteString != "" {
            self.profileImageView.af_setImage(withURL: profileImageURL)
        } else {
            self.profileImageView.image = UIImage(named: "defaultProfileImage")
        }
        self.profileImageView.setCircleImageView()
        self.emailLabel.text = email
        self.contentLabel.text = content
    }
}
