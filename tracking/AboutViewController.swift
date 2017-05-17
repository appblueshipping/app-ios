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
    
    var player: AVPlayer!
    var canPlay = true
    let videoLink = "http://www.blueshipping.com.br/video2017/videoinstitucional.mp4"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initSubViews()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        if player != nil {
            player.pause()
        }
        
    }
    // TODO: - IMPROVE!
    override func viewDidAppear(_ animated: Bool) {
        if player == nil {
            
            DispatchQueue.global(qos: .userInteractive).async {
                self.player = AVPlayer(url: URL(string: self.videoLink)!)
                
                NotificationCenter.default.addObserver(self, selector: #selector(self.playerDidFinishPlaying), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: self.player)
                
                let controller = AVPlayerViewController()
                controller.player = self.player
                
                
                self.addChildViewController(controller)
                controller.view.frame = self.myView.frame
                
                DispatchQueue.main.async {
                    self.myView.addSubview(controller.view)
                }
            }
            
        }
    }

    
    func initSubViews() {
        self.dismissKeyboard()
        self.navigationItem.titleView = logoView
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "LOGOUT", style: .plain, target: nil, action: nil)
    }
    
    func playerDidFinishPlaying(notitication: NSNotification) {
        
        if player != nil {
            player.pause()
        }
        
    }

}
