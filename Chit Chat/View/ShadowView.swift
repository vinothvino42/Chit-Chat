//
//  ShadowView.swift
//  Chit Chat
//
//  Created by Vinoth Vino on 30/05/18.
//  Copyright © 2018 CoderEarth. All rights reserved.
//

import UIKit

class ShadowView: UIView {

    override func awakeFromNib() {
        self.layer.shadowOpacity = 0.75
        self.layer.shadowRadius = 5
        self.layer.shadowColor = UIColor.black.cgColor
        super.awakeFromNib()
    }
}
