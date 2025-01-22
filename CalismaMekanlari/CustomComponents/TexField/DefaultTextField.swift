//
//  DefaultTextField.swift
//  isteportal
//
//  Created by Ozan Çiçek on 14.06.2024.
//

import UIKit

@IBDesignable
class DefaultTextField: UITextField {

   
    
    // Private storage
       private var _cornerRadius: CGFloat = 12.0
       
       // Public property
    override var cornerRadius: CGFloat {
           get { return _cornerRadius }
           set {
               _cornerRadius = newValue
               self.layer.cornerRadius = newValue
           }
       }
    
    // Sol boşluk özelliği
    @IBInspectable var leftPadding: CGFloat = 10.0
    
    // Sağ boşluk özelliği
    @IBInspectable var rightPadding: CGFloat = 10.0
    
    // Placeholder metin rengi özelliği
    @IBInspectable var placeholderColor: UIColor = UIColor.white {
        didSet {
            setPlaceholder()
        }
    }
    
    
   
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        
        self.borderStyle = .none
        self.font = UIFont(name: TextFonts.MediumR, size: 16)
        self.backgroundColor = StyleVars.cellBackground
        self.layer.cornerRadius = cornerRadius
        setPlaceholder()
    }
    
    private func setPlaceholder() {
        var attributes: [NSAttributedString.Key: Any] = [:]
        attributes[.foregroundColor] = placeholderColor
        
        if let font = UIFont(name: TextFonts.MediumR, size: 16) {
            attributes[.font] = font
            
        }
        
        
        
        if let placeholder = placeholder {
            self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: attributes)
        }
        
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: leftPadding, bottom: 0, right: rightPadding))
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: leftPadding, bottom: 0, right: rightPadding))
    }
}
