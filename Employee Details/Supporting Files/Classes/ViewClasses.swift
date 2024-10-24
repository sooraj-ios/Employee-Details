//
//  ViewClasses.swift
//  Employee Details
//
//  Created by Sooraj R on 24/10/24.
//

import UIKit

class CurvedView: UIView{
    required init? (coder: NSCoder) {
        super.init(coder: coder)
        self.clipsToBounds = true
        self.layer.cornerRadius = 28
    }
}

class CurvedShadowView: UIView{
    required init? (coder: NSCoder) {
        super.init(coder: coder)
        self.layer.cornerRadius = 28
        self.layer.shadowRadius = 12
        self.layer.shadowOpacity = 0.6
        self.layer.shadowOffset = CGSize(width: 0, height: -6)
        self.layer.shadowColor = UIColor(named: "BackgroundViewSecondary")?.cgColor
    }
}

class FieldBackgroundView: UIView{
    required init? (coder: NSCoder) {
        super.init(coder: coder)
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
    }
}

class FieldBackgroundBorderView: UIView{
    required init? (coder: NSCoder) {
        super.init(coder: coder)
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor(named: "ButtonPrimary")?.cgColor
    }
}
