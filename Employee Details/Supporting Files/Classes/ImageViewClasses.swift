//
//  ImageViewClasses.swift
//  Employee Details
//
//  Created by Sooraj R on 25/10/24.
//

import UIKit

class RoundedImageView: UIImageView{
    required init? (coder: NSCoder) {
        super.init(coder: coder)
        self.clipsToBounds = true
        self.layer.cornerRadius = self.frame.height/2
    }
}
