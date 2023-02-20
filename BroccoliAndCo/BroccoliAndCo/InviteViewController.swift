//
//  InviteViewController.swift
//  BroccoliAndCo
//
//  Created by Hoang Linh Nguyen on 19/2/2023.
//


import UIKit
import RSFormView


class InviteViewController: UIViewController, FormViewDelegate{
    var formView = FormView()
    var submitButton = UIButton(type: .custom)
    var titleLabel = UILabel()
    var dismissButton = UIButton()
    
    var formModel = InviteViewModel()
    
    var name: String = ""
    var email: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureViews()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(dismissSelf))
    }
    
    @objc private func dismissSelf(){
        dismiss(animated: true, completion: nil)
    }
    
    //configure all UI elements
    func configureViews(){
        configureFormView()
        configureLabels()
        configureSubmitButton()
        configureConstraints()
    }
    
    func configureDismissButton(){
        dismissButton.setImage(UIImage(named: "imgName"), for: .normal)
    }
    
    func configureSubmitButton(){
        updateSubmitButton(enabled: false)
        submitButton.layer.cornerRadius = 8
        submitButton.setTitle("Send", for: .normal)
        submitButton.setTitleColor(UIColor.white, for: .normal)
        submitButton.titleLabel?.font =  UIFont(name: "MusticaPro-SemiBold", size: 18)
        submitButton.layer.borderWidth = 2
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
        
        view.addSubview(submitButton)
    }
    
    func configureLabels(){
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = UIColor.black
        titleLabel.textAlignment = .center
        titleLabel.text = "Request an invite"
        titleLabel.font = UIFont(name: "MusticaPro-SemiBold", size: 25)
        titleLabel.addBorder(toSide: .bottom, withColor: UIColor.brightGray.cgColor, andThickness: 2.0)
        self.view.addSubview(titleLabel)
    }
    
    
    func configureFormView() {
        let formConfigurator = FormConfigurator()
        formConfigurator.borderCornerRadius = 8
        formConfigurator.borderWidth = 2
        formConfigurator.validTitleColor = UIColor.dodgerBlue
        formConfigurator.titleFont = UIFont(name: "MusticaPro-SemiBold", size: 15)!
        formConfigurator.placeholderTextColor = UIColor.lightGray
        formConfigurator.placeholderFont = UIFont(name: "MusticaPro-SemiBold", size: 14)!
        formConfigurator.validBorderColor = UIColor.gray
        formConfigurator.editingBorderColor = UIColor.dodgerBlue
        formConfigurator.invalidBorderColor = UIColor.red
        formConfigurator.validTitleColor = UIColor.gray
        formConfigurator.editingTitleColor = UIColor.dodgerBlue
        formConfigurator.invalidTitleColor = UIColor.red
        formConfigurator.textColor = UIColor.black
       
        
        formConfigurator.isScrollEnabled = false
       
        formView.formConfigurator = formConfigurator
        formView.delegate = self
        formView.viewModel = formModel
        formView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(formView)
    }
    
    func configureConstraints(){

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            titleLabel.bottomAnchor.constraint(equalTo: formView.topAnchor, constant: -100),
            
            formView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            formView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            formView.bottomAnchor.constraint(equalTo: submitButton.topAnchor, constant: -10),
            
            submitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            submitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            submitButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -25),
            submitButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    func updateSubmitButton(enabled: Bool) {
        let backgroundColor = enabled ? UIColor.white : UIColor.brightGray.withAlphaComponent(0.4)
        let textColor = enabled ? UIColor.black : UIColor.white
        let borderColor = enabled ? UIColor.black.cgColor : UIColor.clear.cgColor
        submitButton.backgroundColor = backgroundColor
        submitButton.setTitleColor(textColor, for: .normal)
        submitButton.layer.borderColor = borderColor
        submitButton.isUserInteractionEnabled = enabled
    }
    
    func didUpdateFields(in formView: FormView, allFieldsValid: Bool){
        updateSubmitButton(enabled: allFieldsValid)
    }
    
    @objc
    func submitButtonTapped(sender: UIButton!) {
        let navView = UINavigationController(rootViewController: CongratViewController())
        navView.modalPresentationStyle = .fullScreen
        present(navView, animated: true)
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        sender.backgroundColor = UIColor.black
        sender.setTitleColor(UIColor.white, for: .normal)
        sender.isSelected = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            sender.backgroundColor = UIColor.white
            sender.setTitleColor(UIColor.black, for: .normal)
            sender.isSelected = false
        }
     
    }
    
}


class InviteViewModel: FormViewModel {
    
    var items: [FormItem] = []
    
    init() {
        items = [NameItem(), EmailItem(),
                 confirmEmailItem()]
    }
    
    enum FieldName: String {
        case name = "Full name"
        case email = "Email"
        case confirmEmail = "Confirm Email"
    }

    //Validate the name
    func NameItem() -> FormItem {
        let nameField = FormField(name: FieldName.name.rawValue,
                                  initialValue: "",
                                  placeholder: FieldName.name.rawValue,
                                  fieldType: .regular,
                                  isValid: false,
                                  errorMessage: "Full name must be at least 3 characters long")
        nameField.minimumTextLength = 3
        
        return TextFieldCellItem(with: nameField)
    }
    
    //validate the email
    func EmailItem() -> FormItem {
        let emailField = FormField(name: FieldName.email.rawValue,
                                   initialValue: "",
                                   placeholder: FieldName.email.rawValue,
                                   fieldType: .email,
                                   isValid: false,
                                   errorMessage: "Please enter a valid email")
        return TextFieldCellItem(with: emailField)
    }
    
    //check if the emails match
    func confirmEmailItem() -> FormItem {
        let confirmEmailField = FormField(name: FieldName.confirmEmail.rawValue,
                                          initialValue: "",
                                          placeholder: FieldName.confirmEmail.rawValue,
                                          fieldType: .email,
                                          isValid: false,
                                          errorMessage: "Email doesn't match")
        confirmEmailField.validationMatch = FieldName.email.rawValue
        
        return TextFieldCellItem(with: confirmEmailField)
    }
}

