 //
//  RoundedButton.swift
//  user
//
//  Created by Adson Nascimento on 20/03/17.
//  Copyright © 2017 PIPz. All rights reserved.
//

import UIKit

//@IBDesignable
class RoundedButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue >= 0 ? newValue : 0
            self.layer.masksToBounds = newValue > 0
        }
    }
    
    
    @IBInspectable var isLoadButton : Bool = false
    @IBInspectable var activityIndicatorColor: UIColor = UIColor.white
    
    @IBInspectable var hasBorder : Bool = false
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return self.layer.borderWidth
        }
        set {
            self.layer.borderWidth = newValue >= 0 ? newValue : 0
            self.layer.masksToBounds = newValue > 0
        }
    }

    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    
    private var activityIndicator : UIActivityIndicatorView?
    private var hasActivityIndicator : Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = self.frame.size.height / CGFloat(2)
        
        if hasBorder {
            self.layer.borderWidth = borderWidth
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.cornerRadius = self.frame.size.height / CGFloat(2)
        
        if hasBorder {
            self.layer.borderWidth = borderWidth
            self.layer.borderColor = borderColor.cgColor
        }

    }
        
    override func layoutSubviews() {
        super.layoutSubviews()
        if isLoadButton && !hasActivityIndicator {
            activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
            activityIndicator?.hidesWhenStopped = true
            activityIndicator?.color = activityIndicatorColor
            let activitySize = self.bounds.size.height / 2;
			activityIndicator?.center = CGPoint(x: self.bounds.size.width - activitySize, y: activitySize)
            self.addSubview(activityIndicator!)
            hasActivityIndicator = true
			
        }
        
        if hasBorder {
            self.layer.borderWidth = borderWidth
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    func changeActivityIndicatorAnimatingStatus() {
        
        guard let act = self.activityIndicator else {
            return
        }
        if act.isAnimating {
			act.stopAnimating()
			isUserInteractionEnabled = true
		} else {
			isUserInteractionEnabled = false
            act.startAnimating()
        }
    }
    
    
}
