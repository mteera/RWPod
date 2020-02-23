//
//  ProductCell.swift
//  GedditChallenge
//
//  Created by Chace Teera on 18/02/2020.
//  Copyright © 2020 chaceteera. All rights reserved.
//

import UIKit
import Kingfisher

class ProductCell: UITableViewCell {
    
    
    var product: Product? {
        didSet {
            guard let product = product else { return }
            
            descriptionLabel.text = product.attributes.description ?? "No Description"
            
            if let price = product.attributes.price {
                priceLabel.text = "฿\(String(describing: price))"
            }
            
            if let image = product.attributes.image {
                let url = URL(string: image)
                productImageView.kf.setImage(with: url)
                
            }

        }
    }
    
    lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 0, y: 0, width: 125, height: 175)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.text = "No price"
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        overrideUserInterfaceStyle = .light

        addSubview(productImageView)
               
        productImageView.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, topConstant: 5, leftConstant: 15, bottomConstant: 5, rightConstant: 0, widthConstant: 125, heightConstant: 175)
        
        
        let stackView = UIStackView(arrangedSubviews: [priceLabel, descriptionLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        
        addSubview(stackView)
        
        stackView.anchor(productImageView.topAnchor, left: productImageView.rightAnchor, right: rightAnchor, leftConstant: 12,  rightConstant: 15)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
