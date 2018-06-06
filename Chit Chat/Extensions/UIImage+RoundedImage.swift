//
//  UIImage+RoundedImage.swift
//  Chit Chat
//
//  Created by Vinoth Vino on 06/06/18.
//  Copyright © 2018 CoderEarth. All rights reserved.
//

import UIKit.UIImageView

extension UIImageView {
    
    func setCircleImageView() {
        self.layer.cornerRadius = (self.frame.width / 2)
        self.clipsToBounds = true
    }
}
