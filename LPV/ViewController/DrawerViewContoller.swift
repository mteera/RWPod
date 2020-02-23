//
//  DrawerViewContoller.swift
//  GedditChallenge
//
//  Created by Chace Teera on 18/02/2020.
//  Copyright © 2020 chaceteera. All rights reserved.
//

import UIKit
import Pulley

class DrawerViewController: UIViewController {
    
    fileprivate var cellId = "1234"
    
    var gripperTopConstraint: NSLayoutConstraint!

    lazy var topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var gripperView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    fileprivate var drawerBottomSafeArea: CGFloat = 0.0 {
        didSet {
            self.loadViewIfNeeded()
            
            tableView.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: drawerBottomSafeArea, right: 0.0)
        }
    }
    
    var products = [Product]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light

        setupViews()

        registerCells()
        view.addSubview(tableView)
        tableView.anchor(top: topView.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor
            , padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), size: CGSize())
        
        
        fetchData()

        
 

    }
    
    fileprivate func setupViews() {
        view.addSubview(topView)
        topView.backgroundColor = .white

        topView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 30, left: 0, bottom: 0, right: 0), size: CGSize(width: view.frame.width, height: 30))
        topView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        topView.addSubview(gripperView)
        gripperView.layer.cornerRadius = 2.5
        gripperView.backgroundColor = .systemGray5
        
        gripperView.anchor(top: topView.topAnchor, leading: nil, bottom: topView.bottomAnchor, trailing: nil, padding: UIEdgeInsets(top: 10, left: 0, bottom: 5, right: 0), size: CGSize(width: 50, height: 5))

        
        gripperView.centerXAnchor.constraint(equalTo: topView.centerXAnchor).isActive = true

        gripperTopConstraint = topView.topAnchor.constraint(equalTo: view.topAnchor)
        gripperTopConstraint.isActive = true
        
    }
    
    fileprivate func fetchData() {
        Service.shared.fetchGenericJSONData(urlString: "https://api.live.dev.gedditlive.com/v1/test/product-list") { (product: ProductData?, error) in
            if let error = error {
                print("Failed to decode reviews:", error)
                return
            }
            
            guard let products = product?.data else { return }

            self.products = products
            DispatchQueue.main.async {
                self.tableView.reloadData()

            }

        }
    }
    
    
    fileprivate func registerCells() {
        tableView.register(ProductCell.self, forCellReuseIdentifier: cellId)

    }
 
}


extension DrawerViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? ProductCell else { fatalError() }
        
        let product = self.products[indexPath.row]

        cell.product = product
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension DrawerViewController: UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        

    }
}


extension DrawerViewController: PulleyDrawerViewControllerDelegate {

    func collapsedDrawerHeight(bottomSafeArea: CGFloat) -> CGFloat
    {
        // For devices with a bottom safe area, we want to make our drawer taller. Your implementation may not want to do that. In that case, disregard the bottomSafeArea value.
        return 68.0 + (pulleyViewController?.currentDisplayMode == .drawer ? bottomSafeArea : 0.0)
    }
    
    func partialRevealDrawerHeight(bottomSafeArea: CGFloat) -> CGFloat
    {
        // For devices with a bottom safe area, we want to make our drawer taller. Your implementation may not want to do that. In that case, disregard the bottomSafeArea value.
        return 464.0 + (pulleyViewController?.currentDisplayMode == .drawer ? bottomSafeArea : 0.0)
    }
    
    func supportedDrawerPositions() -> [PulleyPosition] {
        return PulleyPosition.all // You can specify the drawer positions you support. This is the same as: [.open, .partiallyRevealed, .collapsed, .closed]
    }
    

}


