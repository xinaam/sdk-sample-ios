//
//  UIImageView+Extension.swift
//  Pandalove
//
//  Created by dilipkumar on 16/04/19.
//  Copyright © 2019 dilipkumar. All rights reserved.
//

import UIKit

extension UIImageView {
    //--------------------------------------------------------------------------------------------------------------------
    //MARK: - Set Gradient Color
   /* func setGradientColor() {
        self.backgroundColor = AppColor.clear
        
        for layer in self.layer.sublayers ?? [] {
            if layer.name == "gradientLayer" {
                layer.removeFromSuperlayer()
            }
        }
        let layer:CAGradientLayer = CAGradientLayer()
        layer.colors = [
            AppColor.gradient1.cgColor,
            AppColor.gradient1.cgColor,
            AppColor.gradient1.cgColor,
            AppColor.gradient1.cgColor,
            AppColor.gradient1.cgColor
        ]
        layer.locations = [0, 0.24, 0.48, 0.72, 1]
        layer.startPoint = CGPoint(x: 0.25, y: 0.5)
        layer.endPoint = CGPoint(x: 0.75, y: 0.5)
        layer.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 1.11, b: 1.08, c: -1.08, d: 0.28, tx: 0.43, ty: -0.22))
        layer.bounds = self.bounds.insetBy(dx: -0.5*self.bounds.size.width, dy: -0.5*self.bounds.size.height)
        
        layer.position = self.center
        layer.name = "gradientLayer"
        self.layer.addSublayer(layer)
        
    }*/
    func imageAvatarOverlay() {
        DispatchQueue.main.async {
            if let overlayView = self.viewWithTag(2345){
                overlayView.removeFromSuperview()
            }
          let view = UIView()
            print("Radius2222",self.bounds)
          view.frame = self.bounds
          view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2)
            view.tag = 2345
          
          self.addSubview(view)
          let maskLayer = CAShapeLayer()
          maskLayer.frame = self.bounds
          let radius: CGFloat = self.bounds.height/2
          let rect = CGRect(x: 0, y: 0, width: 2 * radius, height: 2 * radius)
          let circlePath = UIBezierPath(ovalIn: rect)
          let path = UIBezierPath(rect: view.bounds)
          path.append(circlePath)
          maskLayer.fillRule = CAShapeLayerFillRule.evenOdd
          maskLayer.path = path.cgPath
          view.layer.mask = maskLayer
        }
      }
    //-------------------------------------------------------------------------------------------------------------------
    
    func setCornerradius() {
        DispatchQueue.main.async {
            print("Radius",self.bounds)
            self.layer.cornerRadius = self.bounds.size.height / 2.0
            self.layer.masksToBounds = true
        }
    }
}

extension UIImage {
    func imageWithColor(color: UIColor) -> UIImage? {
        var image = withRenderingMode(.alwaysTemplate)
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        color.set()
        image.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        image = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
        UIGraphicsEndImageContext()
        return image
    }
}
