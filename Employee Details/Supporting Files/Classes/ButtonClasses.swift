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

    func setAsEnabled(){
        self.isUserInteractionEnabled = true
        self.backgroundColor = UIColor(named: "ButtonPrimary")
    }

    func setAsDisabled(){
        self.isUserInteractionEnabled = false
        self.backgroundColor = UIColor.lightGray
    }
}

class BorderButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor(named: "TextHighlight")?.cgColor
        self.titleLabel?.textColor = UIColor.black
        self.backgroundColor = UIColor.clear
    }

    func setAsSelected(){
        self.backgroundColor = UIColor(named: "BackgroundViewHighlight")
        self.titleLabel?.textColor = UIColor(named: "TextHighlight")
    }

    func setAsUnSelected(){
        self.titleLabel?.textColor = UIColor.black
        self.backgroundColor = UIColor.clear
    }
}
