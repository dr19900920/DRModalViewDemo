//
//  UIView+Inspectable.swift
//  drwd
//
//  Created by dengrui on 15/10/9.
//  Copyright © 2015年 dengrui. All rights reserved.
//

import Foundation
import UIKit


@IBDesignable
extension UIView {
    
    
    @IBInspectable var cornerRadius: CGFloat {
        
        get{
            return self.layer.cornerRadius
        }
        
        set{
            self.layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        
        get{
            return self.layer.borderWidth
        }
        
        set{
            self.layer.borderWidth = newValue
        }
        
    }
    
    @IBInspectable var borderColor: UIColor {
        get{
            return UIColor(CGColor: self.layer.borderColor ?? UIColor.clearColor().CGColor)
        }
        
        set{
            self.layer.borderColor = newValue.CGColor
        }
    }
    
    
}
