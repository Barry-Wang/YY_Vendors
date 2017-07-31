//
//  OTPlaceHoldTextView.swift
//  onetrip
//
//  Created by WangWei on 18/5/17.
//  Copyright © 2017年 rehulu. All rights reserved.
//

import UIKit

class OTPlaceHoldTextView: UITextView {

    
    var placeHold:String? {
       
        didSet {
          
            self.setNeedsDisplay()
        }
    }
    var placeHoldColor:UIColor? {
       
        didSet {
          
            self.setNeedsDisplay()
        }
    }
    
    override var text: String! {
       
        get {
          
            return super.text
        }
        set {
        
            super.text = newValue
            self.textChanged(notification: nil)
        }
    }
    
    var placeHolderLabel:UILabel?
    
    
    public override init(frame: CGRect, textContainer: NSTextContainer?) {
       
      super.init(frame: frame, textContainer: textContainer)
        
        NotificationCenter.default.addObserver(self, selector: #selector(OTPlaceHoldTextView.textChanged(notification:)), name:NSNotification.Name.UITextViewTextDidChange, object: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
 
    override func draw(_ rect: CGRect) {
        
        if(self.placeHold != nil && self.placeHold!.characters.count > 0) {
            
            if (placeHolderLabel == nil ) {
                placeHolderLabel = UILabel(frame:CGRect(x:0, y:0, width:self.frame.size.width - 20, height:20))
                placeHolderLabel!.lineBreakMode = .byWordWrapping
                placeHolderLabel!.numberOfLines = 0
                placeHolderLabel!.font = UIFont.systemFont(ofSize: 14.0)
                placeHolderLabel!.backgroundColor = UIColor.clear
                placeHolderLabel!.textColor = self.placeHoldColor
                placeHolderLabel!.alpha = 0
                placeHolderLabel!.tag = 999
                placeHolderLabel!.center = CGPoint(x:self.frame.size.width / 2 + self.textContainerInset.left, y:self.frame.size.height / 2)
                self.addSubview(placeHolderLabel!)
            }
            placeHolderLabel!.text = self.placeHold
            self.sendSubview(toBack: placeHolderLabel!)
        }
        
        if self.text.characters.count == 0 && self.placeHold != nil && self.placeHold!.characters.count > 0 {
            
            self.viewWithTag(999)?.alpha = 1
            
        }
        
    }
    
    func textChanged(notification:Notification?) {
        
        if placeHold != nil && placeHold!.characters.count > 0 {
            
            if self.text != nil {
                
                UIView.animate(withDuration: 0.25, animations: {
                    
                    
                    if self.text!.characters.count > 0 {
                        
                        self.viewWithTag(999)?.alpha = 0
                        
                    } else {
                        
                        self.viewWithTag(999)?.alpha = 1;
                        
                    }
                    
                })

            }
        }
        
    }
    
    
    
    

}
