//
//  DatePickerVC.swift
//  Employee Details
//
//  Created by Sooraj R on 25/10/24.
//

import UIKit

class DatePickerVC: UIViewController {
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var contentView: CurvedView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var minimumDate = Date()
    var selectedDateClosure: ((Date) -> ())!
    var isForDOB = false

    override func viewDidLoad() {
        super.viewDidLoad()
        if isForDOB{
            datePicker.maximumDate = Calendar.current.date(byAdding: .year, value: -18, to: Date())
        }else{
            datePicker.minimumDate = minimumDate
        }
        contentView.layer.cornerRadius = 20
    }

    @IBAction func saveButtonAction(_ sender: PrimaryButton) {
        selectedDateClosure(datePicker.date)
        self.dismiss(animated: true)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first?.view == blurView.contentView{
            self.dismiss(animated: true)
        }
    }
}
