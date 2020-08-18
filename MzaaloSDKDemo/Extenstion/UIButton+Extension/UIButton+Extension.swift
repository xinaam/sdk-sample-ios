//
//  UIButton+Extension.swift
//  Pandalove
//
//  Created by dilipkumar on 17/04/19.
//  Copyright © 2019 dilipkumar. All rights reserved.
//

import UIKit

extension UIButton {
    
    //MARK:- Set button background color
    func buttonBackgroundColor() {
        
        /*setCornerRadius()
        
        let fontSize = getFontSize(FontSize: 25)
        
        let layer = CAGradientLayer()
        
        layer.colors = [
            AppColor.buttongradientLight.cgColor,
            AppColor.buttongradientDark.cgColor
        ]
        
        layer.locations = [0, 1]
        
        layer.startPoint = CGPoint(x: 0.25, y: 0.5)
        
        layer.endPoint = CGPoint(x: 0.75, y: 0.5)
        
        layer.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: -0.98, b: 0, c: 0, d: -43.03, tx: 0.98, ty: 22.02))
        
        layer.bounds = self.bounds.insetBy(dx: -0.5*self.bounds.size.width, dy: -0.5*self.bounds.size.height)
        
        layer.position = self.center
        
        self.layer.insertSublayer(layer, at: 0)
//        self.layer.addSublayer(layer)
        
        self.backgroundColor = AppColor.clear
        self.setTitleColor(AppColor.white, for: .normal)*/
        setCornerRadius()
        let fontSize = getFontSize(FontSize: 25)
//        self.titleLabel?.font = UIFont.init(name: Font.PoppinsMedium, size: fontSize)
        
    }
        
    //MARK:- Set button background color as clear color
  /*  func buttonClearBackgroundColor() {
        let fontSize = getFontSize(FontSize: 25)
        self.setTitleColor(AppColor.buttonText, for: .normal)
        self.backgroundColor = AppColor.clear
        self.titleLabel?.font = UIFont.init(name: Font.PoppinsMedium, size: fontSize)
    }
    
    
    func setPoppinsRegularFont(fontSize: CGFloat) {
        let size = getFontSize(FontSize: fontSize)
        self.titleLabel?.font = UIFont.init(name: Font.PoppinsRegular, size: size)
    }
    
    func setPoppinsMediumFont(fontSize: CGFloat) {
        let size = getFontSize(FontSize: fontSize)
        self.titleLabel?.font = UIFont.init(name: Font.PoppinsRegular, size: size)
    }
    
    func setPoppinsSemiBoldFont(fontSize: CGFloat) {
        let size = getFontSize(FontSize: fontSize)
        self.titleLabel?.font = UIFont.init(name: Font.PoppinsRegular, size: size)
    }
    
    func setPoppinsBoldFont(fontSize: CGFloat) {
        let size = getFontSize(FontSize: fontSize)
        self.titleLabel?.font = UIFont.init(name: Font.PoppinsRegular, size: size)
    }
    
    func setPoppinsLightFont(fontSize: CGFloat) {
        let size = getFontSize(FontSize: fontSize)
        self.titleLabel?.font = UIFont.init(name: Font.PoppinsRegular, size: size)
    }
    
    func setPoppinsItalicFont(fontSize: CGFloat) {
        let size = getFontSize(FontSize: fontSize)
        self.titleLabel?.font = UIFont.init(name: Font.PoppinsRegular, size: size)
    }*/
    
    
    //MARK:- Set button corner radius
    func setCornerRadius() {
        DispatchQueue.main.async {
            self.layer.cornerRadius = self.frame.size.height/2
            self.clipsToBounds = true
        }
    }
    
    func centerTextAndImage(spacing: CGFloat) {
        let insetAmount = spacing / 2
        imageEdgeInsets = UIEdgeInsets(top: 0, left: -insetAmount, bottom: 0, right: insetAmount)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: -insetAmount)
        contentEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount + 10, bottom: 0, right: insetAmount + 10)
    }
    
    
    
   
}
