//
//  PaymentsTVC.swift
//  Employee Details
//
//  Created by Sooraj R on 24/10/24.
//

import UIKit

class PaymentsTVC: UITableViewCell {
    @IBOutlet weak var monthLbl: UILabel!
    @IBOutlet weak var paymentDateLbl: UILabel!
    @IBOutlet weak var remarkLbl: UILabel!
    @IBOutlet weak var paymentAmountLbl: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var paymentAmountPercentageLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(data:Monthly_payments){
        paymentAmountLbl.text = "₹ \(data.amount ?? 0)"
        paymentDateLbl.text = data.payment_date ?? ""
        remarkLbl.text = data.remarks ?? ""
        paymentAmountPercentageLbl.text = "Payment Amount (\(data.amount_percentage ?? 0)%)"
    }
}
