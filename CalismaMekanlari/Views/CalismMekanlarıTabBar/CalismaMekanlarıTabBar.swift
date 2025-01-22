//
//  CalismaMekanlarıTabBar.swift
//  CalismaMekanlari
//
//  Created by Ozan Çiçek on 22.01.2025.
//

import UIKit

class CalismaMekanlarıTabBar: UITabBar {
    private var shapeLayer: CALayer?
        
        override func draw(_ rect: CGRect) {
            self.addShape()
        }
        
    private func addShape() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = createPath()
        shapeLayer.fillColor = UIColor.white.cgColor
        shapeLayer.shadowColor = UIColor.black.cgColor
        shapeLayer.shadowOffset = CGSize(width: 0, height: -4) // Daha yukarı gölge
        shapeLayer.shadowOpacity = 0.15 // Gölge opaklığını artır
        shapeLayer.shadowRadius = 15 // Gölge yarıçapını artır
        
        if let oldShapeLayer = self.shapeLayer {
            self.layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
        } else {
            self.layer.insertSublayer(shapeLayer, at: 0)
        }
        
        self.shapeLayer = shapeLayer
    }

    private func createPath() -> CGPath {
        let path = UIBezierPath()
        let cornerRadius: CGFloat = 30 // Köşe yuvarlaklığını artır
        
        path.move(to: CGPoint(x: 0, y: self.frame.height))
        path.addLine(to: CGPoint(x: 0, y: cornerRadius))
        path.addQuadCurve(to: CGPoint(x: cornerRadius, y: 0),
                         controlPoint: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: self.frame.width - cornerRadius, y: 0))
        path.addQuadCurve(to: CGPoint(x: self.frame.width, y: cornerRadius),
                         controlPoint: CGPoint(x: self.frame.width, y: 0))
        path.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height))
        path.close()
        
        return path.cgPath
    }
    }

    // Kullanımı:
    class TabBarController: UITabBarController {
        override func viewDidLoad() {
            super.viewDidLoad()
            setValue(CalismaMekanlarıTabBar(), forKey: "tabBar")
            
            // Arka plan rengini şeffaf yap
            tabBar.backgroundColor = .clear
            tabBar.backgroundImage = UIImage()
            tabBar.shadowImage = UIImage()
        }
    }
