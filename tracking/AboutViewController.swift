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

    @IBOutlet weak var myView: UIView!
    @IBOutlet var logoView: UIView!
    var backgroundImageView: UIImageView!
    var btnPlayer: UIButton!
    
    var player: AVPlayer!
    var canPlay = true
    let videoLink = "http://www.blueshipping.com.br/video2017/videoinstitucional.mp4"
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initSubViews()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        if player != nil {
            player.pause()
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // TODO: IMPROVE!
        if player == nil {
            
            btnPlayer = {
                let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
                button.setImage(UIImage(named: "ic_play_arrow_white"), for: .normal)
                button.addTarget(self, action: #selector(playAction(_:)), for: .touchUpInside)
                return button
            }()
            
            backgroundImageView = {
                let imageView = UIImageView()
                imageView.image = UIImage(named: "navio_exemplo")
                imageView.contentMode = .scaleAspectFill
                return imageView
            }()
            
            self.player = AVPlayer(url: URL(string: self.videoLink)!)
            
            NotificationCenter.default.addObserver(self, selector: #selector(self.playerDidFinishPlaying), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: self.player)
            
            let controller = AVPlayerViewController()
            controller.player = self.player
            
            self.addChildViewController(controller)
            controller.view.frame = self.myView.frame
            btnPlayer.frame = self.myView.frame
            backgroundImageView.frame = self.myView.frame
            
            self.myView.addSubview(controller.view)
            controller.view.addSubview(backgroundImageView!)
            controller.view.addSubview(btnPlayer)

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

    }
    
    func playerDidFinishPlaying(notitication: NSNotification) {
        
        if player != nil {
            player.pause()
        }
        
    }

}
