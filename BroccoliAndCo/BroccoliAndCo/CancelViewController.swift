//
//  CancelViewController.swift
//  BroccoliAndCo
//
//  Created by Hoang Linh Nguyen on 20/2/2023.
//

import UIKit
import SwiftConfettiView
import SwiftGifOrigin

class CancelViewController : UIViewController {

    var isRegistered: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        //init confetti effect
        let confettiView = SwiftConfettiView(frame: self.view.bounds)
        confettiView.intensity = 1
        confettiView.type = .diamond
        confettiView.startConfetti()
        self.view.addSubview(confettiView)
       
        //save to User Defaults
        UserDefaults.standard.set(isRegistered, forKey: "isRegistered")

        successConstraints()
        labelConstraints()
        subLabelConstraints()
        doneButtonConstraints()
    }
    
    func successConstraints() {
        let image = UIImageView()
        image.loadGif(asset: "cancel")
        
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
        label.text = "Invite cancelled successfully"
        label.font = UIFont(name: "MusticaPro-SemiBold", size: 18)
        label.numberOfLines = 0;
        label.sizeToFit()
        label.preferredMaxLayoutWidth = label.frame.width - 300
        self.view.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        label.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 400).isActive = true
    }
    
    func subLabelConstraints() {
        let label = UILabel()
        label.frame = CGRect(x: label.frame.origin.x, y: label.frame.origin.y, width: label.frame.width, height: label.frame.height)
        label.textAlignment = .center
        label.text = "We are sad to see you go."
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0;
        label.sizeToFit()
        label.preferredMaxLayoutWidth = label.frame.width - 300
        self.view.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        label.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 450).isActive = true
    }
    
    func doneButtonConstraints() {
        let button = UIButton()
        button.backgroundColor =  UIColor.black
        button.setTitle("Done", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 8
        button.titleLabel?.font =  UIFont(name: "MusticaPro-SemiBold", size: 17)
        button.addTarget(self, action: #selector(doneAction), for: .touchDown)
        button.clipsToBounds = true
        self.view.addSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        button.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 500).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    @objc private func doneAction(sender: UIButton!){
        sender.backgroundColor = UIColor.white
        sender.setTitleColor(UIColor.black, for: .normal)
        sender.layer.borderColor = UIColor.black.cgColor
        sender.isSelected = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            sender.backgroundColor = UIColor.black
            sender.setTitleColor(UIColor.white, for: .normal)
            sender.layer.borderColor = UIColor.white.cgColor
            sender.isSelected = false
        }
        let navView = UINavigationController(rootViewController: ViewController())
        navView.modalPresentationStyle = .fullScreen
        present(navView, animated: true)
        
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
