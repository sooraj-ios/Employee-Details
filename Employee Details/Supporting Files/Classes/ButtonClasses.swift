//
//  ButtonClasses.swift
//  Employee Details
//
//  Created by Sooraj R on 24/10/24.
//

import UIKit

class PrimaryButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
    }
}
