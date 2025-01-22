//
//  UINavigationController+Extension.swift
//  CalismaMekanlari
//
//  Created by Ozan Çiçek on 22.01.2025.
//

import UIKit

extension UINavigationController {
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
