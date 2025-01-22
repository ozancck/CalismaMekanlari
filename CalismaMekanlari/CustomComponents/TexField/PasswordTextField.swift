//
//  PasswordTextField.swift
//  isteportal
//
//  Created by Ozan Çiçek on 25.06.2024.
//

import UIKit

@IBDesignable
class PasswordTextField: DefaultTextField {

    // Sağdaki göz butonu
    private let eyeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "eye"), for: .normal)
        button.setImage(UIImage(systemName: "eye.slash"), for: .selected)
        button.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        button.tintColor = StyleVars.labelColor
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupEyeButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupEyeButton()
    }
    
    private func setupEyeButton() {
        rightView = eyeButton
        rightViewMode = .always
        isSecureTextEntry = true
    }
    
    @objc private func togglePasswordVisibility() {
        isSecureTextEntry.toggle()
        eyeButton.isSelected.toggle()
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        let padding: CGFloat = 10
        let size = CGSize(width: 30, height: 30)
        let rect = CGRect(
            x: bounds.width - size.width - padding,
            y: (bounds.height - size.height) / 2,
            width: size.width,
            height: size.height
        )
        return rect
    }
}

