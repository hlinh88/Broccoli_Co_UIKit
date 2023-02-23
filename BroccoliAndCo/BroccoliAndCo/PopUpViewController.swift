//
//  PopUpViewController.swift
//  BroccoliAndCo
//
//  Created by Hoang Linh Nguyen on 21/2/2023.
//

import UIKit

class PopUpViewController : UIViewController {
    
    var text : String?
    var oneButton : Bool?
    
    init(text: String, oneButton: Bool) {
        self.text = text
        self.oneButton = oneButton
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    let popupBox: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 8
        return view
    }()
    
    let stackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var noButton : UIButton = {
        let button = UIButton()
        button.backgroundColor =  UIColor.black //button color
        button.setTitle("No", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 8
        button.titleLabel?.font =  UIFont(name: "MusticaPro-SemiBold", size: 17)
        button.addTarget(self, action: #selector(dismissSelf), for: .touchDown)
        button.clipsToBounds = true
        return button
    }()
    
    private lazy var yesButton : UIButton = {
        let button = UIButton()
        button.backgroundColor =  UIColor.red //button color
        button.setTitle("Yes", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 8
        button.titleLabel?.font =  UIFont(name: "MusticaPro-SemiBold", size: 17)
        button.addTarget(self, action: #selector(yesAction), for: .touchDown)
        button.clipsToBounds = true
        return button
    }()
    
    private lazy var dismissButton : UIButton = {
        let button = UIButton()
        button.backgroundColor =  UIColor.black //button color
        button.setTitle("Dismiss", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 8
        button.titleLabel?.font =  UIFont(name: "MusticaPro-SemiBold", size: 17)
        button.addTarget(self, action: #selector(dismissSelf), for: .touchDown)
        button.clipsToBounds = true
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    let labelTitle : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "MusticaPro-SemiBold", size: 18)
        label.numberOfLines = 0;
        label.sizeToFit()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .clear
        
        self.definesPresentationContext = true
        if self.oneButton == true{
            setupOneButton()
        }else{
            setupTwoButtons() 
        }
     
    }
    
    
    func setupTwoButtons() {
        labelTitle.text = self.text
        
        view.addSubview(popupBox)
        popupBox.addSubview(labelTitle)
        
        // autolayout constraint for popupBox
        popupBox.heightAnchor.constraint(equalToConstant: 180).isActive = true
        popupBox.widthAnchor.constraint(equalToConstant: 300).isActive = true
        popupBox.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        popupBox.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        labelTitle.topAnchor.constraint(equalTo: popupBox.topAnchor, constant: 20).isActive = true
        labelTitle.centerXAnchor.constraint(equalTo: popupBox.centerXAnchor).isActive = true
        labelTitle.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        
        popupBox.addSubview(stackView)
        stackView.addArrangedSubview(noButton)
        stackView.addArrangedSubview(yesButton)
        
        
        stackView.centerXAnchor.constraint(equalTo: popupBox.centerXAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: popupBox.bottomAnchor, constant: -20).isActive = true
        
        noButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        noButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        yesButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        yesButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
    
    }
    
    func setupOneButton() {
        labelTitle.text = self.text
        
        view.addSubview(popupBox)
        popupBox.addSubview(labelTitle)
        popupBox.addSubview(dismissButton)
        
        // autolayout constraint for popupBox
        popupBox.heightAnchor.constraint(equalToConstant: 180).isActive = true
        popupBox.widthAnchor.constraint(equalToConstant: 300).isActive = true
        popupBox.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        popupBox.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        labelTitle.topAnchor.constraint(equalTo: popupBox.topAnchor, constant: 20).isActive = true
        labelTitle.centerXAnchor.constraint(equalTo: popupBox.centerXAnchor).isActive = true
        labelTitle.widthAnchor.constraint(equalToConstant: 200).isActive = true
    
        dismissButton.centerXAnchor.constraint(equalTo: popupBox.centerXAnchor).isActive = true
        dismissButton.bottomAnchor.constraint(equalTo: popupBox.bottomAnchor, constant: -20).isActive = true
        dismissButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        dismissButton.widthAnchor.constraint(equalToConstant: 200).isActive = true

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
    
    @objc private func yesAction(){
        let navView = UINavigationController(rootViewController: CancelViewController())
        navView.modalPresentationStyle = .fullScreen
        self.present(navView, animated: true)
    }
}
