//
//  AddEmployeeBasicDetailsVC.swift
//  Employee Details
//
//  Created by Sooraj R on 24/10/24.
//

import UIKit
import UniformTypeIdentifiers
class AddEmployeeBasicDetailsVC: UIViewController, UIDocumentPickerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // MARK: - IBOUTLETS
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var dateOfBirthField: UITextField!
    @IBOutlet weak var designationField: UITextField!
    @IBOutlet weak var genderField: UITextField!
    @IBOutlet weak var importedFileView: CurvedView!
    @IBOutlet weak var nextButton: PrimaryButton!
    @IBOutlet weak var designationButton: UIButton!
    @IBOutlet weak var genderButton: UIButton!
    @IBOutlet weak var fileImageView: UIImageView!
    
    // MARK: - CONSTANTS AND VARIABLES
    var viewModel: AddEmployeeBasicDetailsVM = AddEmployeeBasicDetailsVM()
    let activityIndicator = ActivityIndicator()
    var designationsArray:[DesignationModel] = []
    var documentPath = ""
    var profileImagePath = ""
    var designationId = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        bindViewModel()
    }

    func configureView(){
        nextButton.setAsDisabled()
        setGenderDropDown()
        viewModel.getDesignations()
        firstNameField.addTarget(self, action: #selector(typing(_ :)), for: .editingChanged)
        lastNameField.addTarget(self, action: #selector(typing(_ :)), for: .editingChanged)
    }

    @objc func typing(_ sender: UITextField){
        checkValidations()
    }

    func checkValidations(){
        _ = (firstNameField.text ?? "") != "" && (lastNameField.text ?? "") != "" && (designationField.text ?? "") != "" && (genderField.text ?? "") != "" && (dateOfBirthField.text ?? "") != "" && documentPath != "" && profileImagePath != "" ? nextButton.setAsEnabled() : nextButton.setAsDisabled()
    }

    func bindViewModel() {
        viewModel.isLoadingData.bind { [weak self] isLoading in
            guard let isLoading = isLoading else {
                return
            }
            DispatchQueue.main.async {
                if isLoading {
                    self?.activityIndicator.show()
                } else {
                    self?.activityIndicator.hide()
                }
            }
        }

        viewModel.showError.bind { message in
            guard let message = message else {
                return
            }
            AppToastView.shared.showToast(message: message, toastType: .error)
        }

        viewModel.designations.bind { designations in
            guard let designations = designations else {
                return
            }
            self.designationsArray = designations
            self.setDesignationDropDown()
        }

    }

    func setDesignationDropDown(){
        let actionClosure = { (action: UIAction) in
            self.designationField.text = action.title
            self.checkValidations()
            for (index,item) in self.designationsArray.enumerated(){
                if item.name ?? "" == action.title{
                    self.designationId = item.id ?? 0
                    break
                }
            }
        }
        var designationItems:[UIMenuElement] = []
        for item in designationsArray{
            designationItems.append(UIAction(title: item.name ?? "", handler: actionClosure))
        }
        designationButton.menu = UIMenu(options: .displayInline, children: designationItems)
        designationButton.showsMenuAsPrimaryAction = true
    }

    func setGenderDropDown(){
        let actionClosure = { (action: UIAction) in
            self.genderField.text = action.title
            self.checkValidations()
        }
        var genderItems:[UIMenuElement] = []
        for item in ["Male", "Female"]{
            genderItems.append(UIAction(title: item, handler: actionClosure))
        }
        genderButton.menu = UIMenu(options: .displayInline, children: genderItems)
        genderButton.showsMenuAsPrimaryAction = true
    }

    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let selectedFileURL = urls.first else { return }
        documentPath = selectedFileURL.path
        importedFileView.isHidden = false
        fileImageView.image = UIImage(named: "pdf_icon")
        checkValidations()
    }

    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        controller.dismiss(animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        if let image = info[.originalImage] as? UIImage {
            profileImageView.image = image
            if let imageUrl = info[.imageURL] as? URL {
                print("Image URL: \(imageUrl.path)")
                profileImagePath = imageUrl.path
            } else {
                print("Could not get image URL.")
            }
        }
        self.checkValidations()
        dismiss(animated: true)
    }

    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }

    // MARK: - BUTTON ACTIONS
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func editImageAction(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }

    @IBAction func fileViewAction(_ sender: UIButton) {
        let nextVC = AppController.shared.webViewer
        nextVC.urlString = documentPath
        nextVC.modalPresentationStyle = .overCurrentContext
        nextVC.modalTransitionStyle = .crossDissolve
        self.present(nextVC, animated: true)
    }

    @IBAction func uploadFileAction(_ sender: UIButton) {
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.pdf])
        documentPicker.delegate = self
        documentPicker.modalPresentationStyle = .fullScreen
        present(documentPicker, animated: true, completion: nil)
    }

    @IBAction func dobAction(_ sender: UIButton) {
        let nextVC = AppController.shared.datePicker
        nextVC.modalPresentationStyle = .overCurrentContext
        nextVC.modalTransitionStyle = .crossDissolve
        nextVC.isForDOB = true
        nextVC.selectedDateClosure = { selectedDate in
            self.dateOfBirthField.text = self.dateToString(date: selectedDate)
            self.checkValidations()
        }
        self.present(nextVC, animated: true)
    }
    
    @IBAction func nextAction(_ sender: UIButton) {
        let nextVC = AppController.shared.addEmployeeContactDetails
        let collectedData = BasicDetailsModel(firstName: firstNameField.text ?? "", lastName: lastNameField.text ?? "", designation: self.designationId, gender: genderField.text ?? "", dateOfBirth: dateOfBirthField.text ?? "", documentPath: self.documentPath, profileImagePath: self.profileImagePath)
        nextVC.basicDetailsCollected = collectedData
        self.navigationController?.pushViewController(nextVC, animated: true)
    }

    func dateToString(date:Date, neededFormat:String = "yyyy-MM-dd") -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
}
