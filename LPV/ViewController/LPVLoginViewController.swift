//
//  LoginViewController.swift
//  GedditChallenge
//
//  Created by Chace Teera on 17/02/2020.
//  Copyright © 2020 chaceteera. All rights reserved.
//

import UIKit
import Alamofire

public class LPVLoginViewController: UIViewController {

    lazy var emailFieldWithLabel: TextFieldWithLabel = {
        let view = TextFieldWithLabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var passwordFieldWithLabel: TextFieldWithLabel = {
        let view = TextFieldWithLabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .black
        button.layer.cornerRadius = 5
        button.backgroundColor = .black
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        button.setTitle("Login", for: .normal)
        button.tintColor = .white
        return button
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        overrideUserInterfaceStyle = .light

        emailFieldWithLabel.titleLabel.text = "Email"
        emailFieldWithLabel.textField.placeholder = "someone@example.com"
        passwordFieldWithLabel.titleLabel.text = "Password"
        passwordFieldWithLabel.textField.isSecureTextEntry = true

        
        let stackView = UIStackView(arrangedSubviews: [emailFieldWithLabel, passwordFieldWithLabel, loginButton])
        stackView.spacing = 40
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false

        
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true

        
        
        view.addSubview(stackView)
        stackView.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 40, leftConstant: 32, bottomConstant: 0, rightConstant: 32)
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        loginButton.addTarget(self, action: #selector(handleLogin(_:)), for: .touchUpInside)
        

        // Do any additional setup after loading the view.
    }
    
    @objc func handleLogin(_ sender: UIButton) {
        
        guard let email = emailFieldWithLabel.textField.text, let password = passwordFieldWithLabel.textField.text else { return }
        
        Service.shared.signIn(email: email, password: password) { (error) in
            
            
            if let error = error {
                
            let alertController = UIAlertController(title: error.localizedDescription, message: "Email or password is incorrect", preferredStyle: .alert)
            let okayAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alertController.addAction(okayAction)
            self.present(alertController, animated: true, completion: nil)
            
            return
            }
            
            
            let vc = ProductViewController(contentViewController: PrimaryContentViewController(), drawerViewController: DrawerViewController())
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .crossDissolve
            self.present(vc, animated: true, completion: nil)

            
        }
        
        

        
    }
    
}

