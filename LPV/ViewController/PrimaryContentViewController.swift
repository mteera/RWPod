//
//  PrimaryContentViewController.swift
//  GedditChallenge
//
//  Created by Chace Teera on 19/02/2020.
//  Copyright © 2020 chaceteera. All rights reserved.
//

import UIKit
import AVKit
import Pulley

class PrimaryContentViewController: UIViewController, AVPlayerViewControllerDelegate {
    
    var avPlayer: AVPlayer!
    var avPlayerLayer: AVPlayerLayer!
    var paused: Bool = false
    var drawerOpen = false

    
    lazy var productListButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "hanger"), for: .normal)
        button.tintColor = UIColor.black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var productListButtonContainer: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 25
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.frame = CGRect(x: 0, y: 0, width: 50, height: 50)

        return view
    }()
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: .whiteLarge)
        aiv.color = .darkGray
        aiv.hidesWhenStopped = true
        return aiv
    }()
    
    lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "close"), for: .normal)
        button.tintColor = UIColor.white
        return button
    }()
    
    lazy var viewContainer: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15

        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var liveContainer: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var redView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemRed
        return view
    }()
    
    lazy var liveLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = "LIVE"
        return label
    }()
    
    
    lazy var viewLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "10.2K"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var viewSymbol: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "eye")
        view.tintColor = .white
        return view
    }()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view.addSubview(activityIndicatorView)
        activityIndicatorView.centerInSuperview()
        self.activityIndicatorView.startAnimating()

        self.pulleyViewController?.displayMode = .automatic
        self.pulleyViewController?.setDrawerPosition(position: .closed, animated: false)

    }
    


    override func viewDidLoad() {
        overrideUserInterfaceStyle = .light

        setupViews()

            let urlString =  "https://bitdash-a.akamaihd.net/content/MI201109210084_1/m3u8s/f08e80da-bf1d-4e3d-8899-f0f6155f6efa.m3u8"

            guard let url = URL(string: urlString) else { return }


            avPlayer = AVPlayer(url: url)
            avPlayerLayer = AVPlayerLayer(player: avPlayer)
            avPlayerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
            avPlayer.volume = 0
            avPlayer.actionAtItemEnd = .none

            avPlayerLayer.frame = view.layer.bounds
            view.backgroundColor = .systemGray5
            view.layer.insertSublayer(avPlayerLayer, at: 0)

            NotificationCenter.default.addObserver(self,
                                               selector: #selector(playerItemDidReachEnd(notification:)),
                                               name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                                               object: avPlayer.currentItem)
        
        
        NotificationCenter.default.addObserver(self,
                                           selector: #selector(playerItemDidReachEnd(notification:)),
                                           name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                                           object: avPlayer.currentItem)
        
        avPlayer.addObserver(self, forKeyPath: "timeControlStatus", options: [.old, .new], context: nil)

        
        productListButton.addTarget(self, action: #selector(handleOpenCloseDrawer(_:)), for: .touchUpInside)
        closeButton.addTarget(self, action: #selector(handleClose(_:)), for: .touchUpInside)

    }
    
    fileprivate func setupViews() {
        view.addSubview(productListButtonContainer)
        productListButtonContainer.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 15), size: CGSize(width: 50, height: 50))
        
        productListButtonContainer.addSubview(productListButton)
        productListButton.fillSuperview(padding: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        
        view.addSubview(closeButton)
        closeButton.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, topConstant: 15, leftConstant: 15, widthConstant: 50, heightConstant: 50)
        
        
        view.addSubview(liveContainer)
        liveContainer.anchor(closeButton.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: nil, topConstant: 20, leftConstant: 15, bottomConstant: 0, rightConstant: 0, heightConstant: 30)

        
        liveContainer.addSubview(redView)
        liveContainer.addSubview(liveLabel)
        
        liveContainer.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        redView.anchor(left: liveContainer.leftAnchor, leftConstant: 10, widthConstant: 10, heightConstant: 10)
        liveLabel.anchor(nil, left: redView.rightAnchor, bottom: nil, right: liveContainer.rightAnchor, leftConstant: 4, rightConstant: 10)

        redView.centerYInSuperview()
        liveLabel.centerYInSuperview()
        
        
        view.addSubview(viewContainer)
        viewContainer.anchor(liveContainer.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: nil, topConstant: 10, leftConstant: 15, bottomConstant: 0, rightConstant: 0, heightConstant: 30)

        
        viewContainer.addSubview(viewSymbol)
        viewContainer.addSubview(viewLabel)
        
        viewContainer.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        viewSymbol.anchor(left: viewContainer.leftAnchor, leftConstant: 10, widthConstant: 20, heightConstant: 20)
        viewLabel.anchor(nil, left: viewSymbol.rightAnchor, bottom: nil, right: viewContainer.rightAnchor, leftConstant: 4, rightConstant: 10)

        viewSymbol.centerYInSuperview()
        viewLabel.centerYInSuperview()
        
        
        
    }
    
    @objc func handleClose(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func handleOpenCloseDrawer(_ sender: UIButton) {
        drawerOpen = !drawerOpen
        if drawerOpen {
            self.pulleyViewController?.setDrawerPosition(position: .partiallyRevealed, animated: true)

        } else {
            self.pulleyViewController?.setDrawerPosition(position: .closed, animated: true)

        }
        

    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "timeControlStatus", let change = change, let newValue = change[NSKeyValueChangeKey.newKey] as? Int, let oldValue = change[NSKeyValueChangeKey.oldKey] as? Int {
            let oldStatus = AVPlayer.TimeControlStatus(rawValue: oldValue)
            let newStatus = AVPlayer.TimeControlStatus(rawValue: newValue)
            if newStatus != oldStatus {
                DispatchQueue.main.async {[weak self] in
                    if newStatus == .playing || newStatus == .paused {
                        
                        self?.activityIndicatorView.stopAnimating()
                    } 
                }
            }
        }
    }


    @objc func playerItemDidReachEnd(notification: Notification) {
            let p: AVPlayerItem = notification.object as! AVPlayerItem
        p.seek(to: CMTime.zero)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        avPlayer.play()
        paused = false
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        avPlayer.pause()
        paused = true
    }
}

extension PrimaryContentViewController: PulleyDrawerViewControllerDelegate {
    func drawerChangedDistanceFromBottom(drawer: PulleyViewController, distance: CGFloat, bottomSafeArea: CGFloat) {
        
    }
}


