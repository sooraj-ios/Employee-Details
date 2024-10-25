//
//  EmployeesListTVC.swift
//  Employee Details
//
//  Created by Sooraj R on 24/10/24.
//

import UIKit

class EmployeesListTVC: UITableViewCell {
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var numberLbl: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setData(data:Employee){
        profileImageView.sd_setImage(with: URL(string: (data.profile_image_url?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)) ?? ""), placeholderImage: UIImage(named: "profile_placeholder"))
        nameLbl.text = "\((data.first_name ?? "").capitalized) \((data.last_name ?? "").capitalized)"
        numberLbl.text = data.mobile_number
    }

}
