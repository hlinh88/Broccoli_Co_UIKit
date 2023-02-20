//
//  ViewController.swift
//  BroccoliAndCo
//
//  Created by Hoang Linh Nguyen on 19/2/2023.
//

import UIKit

class ViewController: UIViewController {
    
    var isHighLighted : Bool = false

    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonConstraints()
        subNameConstraints()
        nameConstraints()
        buttomTitleConstraints()
        titleConstraints()
    }
    
    //if the user sent an invite before, move to this view
    //    func showCancelScreen() {
    //        DispatchQueue.main.async {
    //            let vc = CancelViewController()
    //            vc.view.backgroundColor = .white
    //            self.navigationController?.pushViewController(vc, animated: true)
    //            self.navigationItem.setHidesBackButton(true, animated: true)
    //        }
    //    }
    

    @objc func buttonAction(sender: UIButton!) {
        let navView = UINavigationController(rootViewController: InviteViewController())
        navView.modalPresentationStyle = .formSheet
        present(navView, animated: true)
        
        sender.backgroundColor = UIColor.black
        sender.setTitleColor(UIColor.white, for: .normal)
        sender.isSelected = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            sender.backgroundColor = UIColor.white
            sender.setTitleColor(UIColor.black, for: .normal)
            sender.isSelected = false
        }
      
    }
    

    func buttonConstraints() {
        let button = UIButton(frame: CGRect(x: 200, y: 200, width: 100, height: 10))
        button.backgroundColor =  UIColor.white //button color
        button.setTitle(" Request an invite ", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 8
        button.titleLabel?.font =  UIFont(name: "MusticaPro-SemiBold", size: 17)
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 18, bottom: 10, right: 18)
        button.addTarget(self, action: #selector(buttonAction), for: .touchDown)
        button.clipsToBounds = true
        button.tintColor = UIColor.white
        self.view.addSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false //set autolayout constraints to false
        
        button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 140).isActive = true
        
    }
    

    func subNameConstraints(){
        let text = UILabel()
        text.frame = CGRect(x: 0, y: 0, width: text.frame.width, height: text.frame.height)
        text.textAlignment = .center
        text.text = "Be the first to know when we launch."
        text.font = UIFont.systemFont(ofSize: 15)
        text.textColor = UIColor.gray
        text.numberOfLines = 0;
        text.sizeToFit()
        text.preferredMaxLayoutWidth = text.frame.width - 20
        self.view.addSubview(text)
        
        text.translatesAutoresizingMaskIntoConstraints = false
        
        text.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        text.bottomAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 70).isActive = true
    }
    

    func nameConstraints() {
        let label = UILabel()
        label.frame = CGRect(x: label.frame.origin.x, y: label.frame.origin.y, width: label.frame.width, height: label.frame.height)
        label.textAlignment = .center
        label.text = "A better way to enjoy every day."
        label.font = UIFont(name: "MusticaPro-SemiBold", size: 25)
        label.numberOfLines = 0;
        label.sizeToFit()
        label.preferredMaxLayoutWidth = label.frame.width - 50
        self.view.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0).isActive = true
        
    }
    
    
    func buttomTitleConstraints() {
        let label = UILabel()
        label.frame = CGRect(x: label.frame.origin.x, y: label.frame.origin.y, width: label.frame.width, height: label.frame.height)
        label.textAlignment = .center
        label.text = "© 2023 Broccoli & Co. All rights reserved."
        label.font = UIFont.systemFont(ofSize: 10)
        label.numberOfLines = 0;
        label.sizeToFit()
        label.preferredMaxLayoutWidth = label.frame.width
        self.view.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20).isActive = true
        
    }

    func titleConstraints() {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: label.frame.width, height: label.frame.height)

        label.textAlignment = .center
        label.text = "Brocolli & Co."
        label.font = UIFont(name: "MusticaPro-SemiBold", size: 25)
        self.view.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        label.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 70).isActive = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        // Hide the Navigation Bar
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        // Show the Navigation Bar
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    
}

