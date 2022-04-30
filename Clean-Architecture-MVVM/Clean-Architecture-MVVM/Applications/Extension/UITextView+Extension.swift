//
//  UITextView+Extension.swift
//  Clean-Architecture-MVVM
//
//  Created by Kim dohyun on 2022/04/30.
//

import UIKit

extension UITextView {
    public func searchAttributed(from string: [String], adress adressString: [String], color: UIColor? ,font: UIFont?) -> NSMutableAttributedString {
        let textString = text ?? ""
        let attributedString = NSMutableAttributedString(string: textString)
        
        
        string.forEach {
            let range = (textString as NSString).range(of: $0)
            attributedString.addAttributes([.font:font as Any,.foregroundColor: color as Any], range: range)
        }
        
        adressString.forEach {
            let adressRange = (textString as NSString).range(of: $0)
            attributedString.addAttributes([.font: UIFont.systemFont(ofSize: 14),.foregroundColor: UIColor.black], range: adressRange)
        }
        
        attributedString.addAttributes([.font: UIFont.boldSystemFont(ofSize: 20)], range: (textString as NSString).range(of: "tip"))
        
        return attributedString
    }
    
}
