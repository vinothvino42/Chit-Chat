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
    
    func configureCell(profileImage: UIImage, email: String, content: String) {
        self.profileImageView.image = profileImage
        self.emailLabel.text = email
        self.contentLabel.text = content
    }
}
