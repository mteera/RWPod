//
//  TextFieldWithLabel.swift
//  GedditChallenge
//
//  Created by Chace Teera on 17/02/2020.
//  Copyright © 2020 chaceteera. All rights reserved.
//

import UIKit

class TextFieldWithLabel: UIView {
    
    fileprivate var bottomLineId = "bottomLine"
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        setupViews()
    }
    
    fileprivate func setupViews() {

        textField.addTarget(self, action: #selector(textFieldEditingBegin), for: .editingDidBegin)
        textField.addTarget(self, action: #selector(textFieldEditingEnd), for: .editingDidEnd)

        let stackView = UIStackView(arrangedSubviews: [titleLabel, textField])
        stackView.spacing = 10
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

    }
    
    override func layoutSubviews() {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(origin: CGPoint(x: 0, y: textField.frame.height + 5), size: CGSize(width: textField.frame.width, height:  1.5))
        bottomLine.backgroundColor = UIColor.lightGray.cgColor
        bottomLine.name = bottomLineId
        textField.borderStyle = .none
        textField.layer.addSublayer(bottomLine)
    }
    
    
    @objc func textFieldEditingBegin(_ textField: UITextField) {
        
        for item in textField.layer.sublayers! {
            if item.name == bottomLineId {

                UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping:1.3, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                    self.titleLabel.textColor = .black
                    item.backgroundColor = UIColor.black.cgColor
                }) { (success) in
                    
                }
            }
        }
        
    }
    
    @objc func textFieldEditingEnd(_ textField: UITextField) {
        
        for item in textField.layer.sublayers! {
            if item.name == bottomLineId {
                UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 1.3, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                    item.backgroundColor = UIColor.lightGray.cgColor
                    self.titleLabel.textColor = .darkGray

                }) { (success) in
                    
                }
            }
        }
    }
    
    

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

