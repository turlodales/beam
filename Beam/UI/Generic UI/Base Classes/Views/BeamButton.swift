//
//  BeamButton.swift
//  beam
//
//  Created by Rens Verhoeven on 04-11-15.
//  Copyright © 2015 Awkward. All rights reserved.
//

import UIKit

class BeamButton: UIButton, BeamAppearance {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupButton()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.appearanceDidChange()
        self.setupButton()
    }
    
    func appearanceDidChange() {
        self.backgroundColor = AppearanceValue(light: UIColor.beam, dark: UIColor.beamPurpleLight)
        
        if self.buttonType == .system {
            self.tintColor = UIColor.white
        }
    }
    
    override var isEnabled: Bool {
        didSet {
            if self.buttonType == .custom {
                self.titleLabel?.alpha = isEnabled ? 1: 0.5
                self.imageView?.alpha = isEnabled ? 1: 0.5
            }
        }
    }
    
    func setupButton() {
        self.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        
        self.layer.cornerRadius = 3
        self.layer.masksToBounds = true
        self.adjustsImageWhenHighlighted = false
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width, height: 44)
    }
    
    override var isHighlighted: Bool {
        didSet {
            guard self.buttonType == .custom else {
                return
            }
            
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: UIView.AnimationOptions(), animations: { () -> Void in
                self.titleLabel?.alpha = self.isHighlighted ? 0.5: 1
                self.imageView?.alpha = self.isHighlighted ? 0.5: 1
                }, completion: nil)
        }
    }
    
}
