//
//  GroupFeedCell.swift
//  Chit Chat
//
//  Created by Vinoth Vino on 03/06/18.
//  Copyright © 2018 CoderEarth. All rights reserved.
//

import UIKit

class GroupFeedCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var contentLbl: UILabel!
    
    func configureCell(profileImageURL: URL, email: String, content: String) {
        if profileImageURL.absoluteString != "" {
            self.profileImage.af_setImage(withURL: profileImageURL)
        } else {
            self.profileImage.image = UIImage(named: "defaultProfileImage")
        }
        self.profileImage.setCircleImageView()
        self.emailLbl.text = email
        self.contentLbl.text = content
    }

}
