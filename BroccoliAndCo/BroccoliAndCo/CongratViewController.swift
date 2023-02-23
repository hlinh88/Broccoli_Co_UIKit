//
//  CongratViewController.swift
//  BroccoliAndCo
//
//  Created by Hoang Linh Nguyen on 20/2/2023.
//

import UIKit
import SwiftConfettiView
import SwiftGifOrigin

class CongratViewController: UIViewController {
    
    var isRegistered: Bool = true

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        //init confetti effect
        let confettiView = SwiftConfettiView(frame: self.view.bounds)
        confettiView.intensity = 1
        confettiView.type = .confetti
        confettiView.startConfetti()
        self.view.addSubview(confettiView)
       
        //save to User Defaults
        UserDefaults.standard.set(isRegistered, forKey: "isRegistered")

        successConstraints()
        labelConstraints()
        doneButtonConstraints()
    }
    
    func successConstraints() {
        let image = UIImageView()
        image.loadGif(asset: "success")
        
        self.view.addSubview(image)
        
        image.translatesAutoresizingMaskIntoConstraints = false
        image.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        image.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 200).isActive = true
        // hard-coded set width and height of the gif
        image.heightAnchor.constraint(equalToConstant: 200).isActive = true
        image.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    func labelConstraints() {
        let label = UILabel()
        label.frame = CGRect(x: label.frame.origin.x, y: label.frame.origin.y, width: label.frame.width, height: label.frame.height)
        label.textAlignment = .center
        label.text = "You will be one of the first to experience Broccoli & Co. when we launch."
        label.font = UIFont(name: "MusticaPro-SemiBold", size: 18)
        label.numberOfLines = 0;
        label.sizeToFit()
        label.preferredMaxLayoutWidth = label.frame.width - 300
        self.view.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        label.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 400).isActive = true
    }
    
    func doneButtonConstraints() {
        let button = UIButton()
        button.backgroundColor =  UIColor.white //button color
        button.setTitle("Done", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 8
        button.titleLabel?.font =  UIFont(name: "MusticaPro-SemiBold", size: 17)
        button.addTarget(self, action: #selector(doneAction), for: .touchDown)
        button.clipsToBounds = true
        button.tintColor = UIColor.white
        
        self.view.addSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        button.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 500).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    @objc private func doneAction(sender: UIButton!){
        sender.backgroundColor = UIColor.black
        sender.setTitleColor(UIColor.white, for: .normal)
        sender.isSelected = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            sender.backgroundColor = UIColor.white
            sender.setTitleColor(UIColor.black, for: .normal)
            sender.isSelected = false
            let navView = UINavigationController(rootViewController: CancelInviteViewController())
            navView.modalPresentationStyle = .fullScreen
            self.present(navView, animated: true)
        }
         
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
