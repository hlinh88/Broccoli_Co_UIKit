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
    var backButton = UIButton()
    
    var formModel = InviteViewModel()
    
    var name: String = ""
    var email: String = ""
    var errMess: String = ""
    var isSuccess: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureViews()
    }
    
    @objc private func dismissSelf(sender: UIButton!){
        
        sender.backgroundColor = UIColor.white
        sender.setTitleColor(UIColor.black, for: .normal)
        sender.layer.borderColor = UIColor.black.cgColor
        sender.isSelected = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            sender.backgroundColor = UIColor.black
            sender.setTitleColor(UIColor.white, for: .normal)
            sender.layer.borderColor = UIColor.white.cgColor
            sender.isSelected = false
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    //configure all UI elements
    func configureViews(){
        configureFormView()
        configureLabels()
        configureSubmitButton()
        configureBackButton()
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
        submitButton.addTarget(self, action: #selector(submitButtonAction), for: .touchUpInside)
        
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
        formConfigurator.placeholderFont = UIFont(name: "MusticaPro-SemiBold", size: 15)!
        formConfigurator.textFieldToBottomLineDistance = 15
        formConfigurator.textFieldContainerToErrorLabelDistance = 5
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
    
    func configureBackButton(){
        backButton.layer.cornerRadius = 8
        backButton.backgroundColor = UIColor.black
        backButton.setTitle("Back", for: .normal)
        backButton.setTitleColor(UIColor.white, for: .normal)
        backButton.titleLabel?.font =  UIFont(name: "MusticaPro-SemiBold", size: 18)
        backButton.layer.borderWidth = 2
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.addTarget(self, action: #selector(dismissSelf), for: .touchUpInside)
        
        view.addSubview(backButton)
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
            
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            backButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            backButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -25),
            backButton.heightAnchor.constraint(equalToConstant: 50),
            
            submitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            submitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            submitButton.bottomAnchor.constraint(equalTo: backButton.topAnchor, constant: -20),
            submitButton.heightAnchor.constraint(equalToConstant: 50),
            
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
    func submitButtonAction(sender: UIButton!) {
        // get name and email value from form view
        formModel.fields().forEach {
            if ($0.name == "Full name" )
            {
                self.name = $0.value
            }
            if ($0.name == "Email" )
            {
                self.email = $0.value
            }
        }
        print("name: \(name)")
        print("email: \(email)")
    
        requestData(name: self.name, email: self.email){ (isSuccess) in
            if isSuccess{
                print("Success")
            }else{
                print("Unsuccess")
            }
        }
        
        sender.backgroundColor = UIColor.lightGray
        sender.setTitleColor(UIColor.black, for: .normal)
        sender.isSelected = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            sender.backgroundColor = UIColor.white
            sender.setTitleColor(UIColor.black, for: .normal)
            sender.isSelected = false
        }
        

        
    }
    
    func requestData(name: String,  email: String, _ completion:@escaping (_ isSuccess:Bool)->Void) {
        
        //Validation email: usedemail@blinq.app
        
        
        // TODO: fix loading view
//        let loadingVC = LoadingViewController()
//
//        loadingVC.modalPresentationStyle = .overCurrentContext
//
//        loadingVC.modalTransitionStyle = .crossDissolve
//
//        self.present(loadingVC, animated: true, completion: nil)
       
        
        let body: [String: Any] = ["name": name, "email": email]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: body)
        
        let url = URL(string: "https://us-central1-blinkapp-684c1.cloudfunctions.net/fakeAuth")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("\(String(describing: jsonData?.count))", forHTTPHeaderField: "Content-Length")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { [self] data, response, error in
            
            if let data = data, let response = response as? HTTPURLResponse, error == nil{
                if response.statusCode == 400 {
                    let responseDecoded: Response = try! JSONDecoder().decode(Response.self, from: data)
                    DispatchQueue.main.async {
                        self.errMess = responseDecoded.errorMessage
                        completion(false)
                        self.isSuccess = false
                        //display alert message on status 400
                        let vc = PopUpViewController(text: self.errMess, oneButton: true)
                        vc.modalPresentationStyle = .overCurrentContext
                        vc.modalTransitionStyle = .crossDissolve
                        self.present(vc, animated: true, completion: nil)
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(true)
                        self.isSuccess = true
                        print("Response status code: \(response.statusCode)")
                  
                        // status code 200 move to next view
                        let navView = UINavigationController(rootViewController: CongratViewController())
                        navView.modalPresentationStyle = .fullScreen
                        self.present(navView, animated: true)
                        self.navigationItem.setHidesBackButton(true, animated: true)
                    }
                }
            }
        }
        task.resume()
    }
    
    struct Response: Decodable {
        let errorMessage: String
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

