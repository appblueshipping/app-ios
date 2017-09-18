//
//  AboutViewController.swift
//  tracking
//
//  Created by Jonatha Lima on 12/05/17.
//  Copyright © 2017 Blue Shipping do Brasil. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class AboutViewController: UIViewController {
    
    @IBOutlet weak var aboutTextView: UITextView!
    @IBOutlet weak var myView: UIView!
    @IBOutlet var logoView: UIView!
    var backgroundImageView: UIImageView!
    var btnPlayer: UIButton!
    
    var player: AVPlayer!
    var canPlay = true
    let videoLink = "https://www.blueshipping.com.br/video2017/videoinstitucional.mp4"
    let imageLink = "http://www.blueshipping.com.br/video2017/framevideo.jpg"
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initSubViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        aboutTextView.isScrollEnabled = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        self.registerGoogleAnalytics(classForCoder: self.classForCoder)
        
        aboutTextView.isScrollEnabled = true
        
        // TODO: IMPROVE!
        if player == nil {
            
            self.player = AVPlayer(url: URL(string: self.videoLink)!)
            
            NotificationCenter.default.addObserver(self, selector: #selector(self.playerDidFinishPlaying), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: self.player)
            
            let controller = AVPlayerViewController()
            controller.player = self.player
            
            self.addChildViewController(controller)
            controller.view.frame = self.myView.frame
            btnPlayer.frame = self.myView.frame
            backgroundImageView.frame = self.myView.frame
            
            self.myView.addSubview(controller.view)
            
            DispatchQueue.main.async {
                controller.view.addSubview(self.backgroundImageView!)
                controller.view.addSubview(self.btnPlayer)
            }
            
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        if player != nil {
            player.pause()
        }
        
    }
    
    
    // MARK: - IBAction
    func playAction(_ sender: Any) {
        
        if player != nil {
            player.play()
            btnPlayer.isHidden = true
            backgroundImageView.isHidden = true
        }
        
    }
    
    // MARK: - Custom Methods
    
    func initSubViews() {
        self.dismissKeyboard()
        self.navigationItem.titleView = logoView
        //self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "LOGOUT", style: .plain, target: nil, action: nil)
        
        btnPlayer = {
            let button = UIButton(frame: CGRect(x: 0, y: 0, width: 400, height: 400))
            let tintedImage = UIImage(named: "ic_play_arrow_white")?.withRenderingMode(.alwaysTemplate)
            button.setImage(tintedImage, for: .normal)
            button.addTarget(self, action: #selector(playAction(_:)), for: .touchUpInside)
            button.tintColor = UIColor().UIColorFromRGB(colorCode: "A9A9A9")
            return button
        }()
        
        backgroundImageView = {
            let imageView = UIImageView()
            imageView.downloadedFrom(url: URL(string: self.imageLink)!, contentMode: .scaleAspectFill)
            return imageView
        }()
        
    }
    
    func playerDidFinishPlaying(notitication: NSNotification) {
        
        if player != nil {
            player.pause()
        }
        
    }
    
}
