//
//  UILabel+Extension.swift
//  Pandalove
//
//  Created by dilipkumar on 19/04/19.
//  Copyright © 2019 dilipkumar. All rights reserved.
//

import UIKit

extension UILabel {
    
    //MARK:- Adjuct font
    
   /* func setPoppinsRegularFont(fontSize: CGFloat) {
        let size = getFontSize(FontSize: fontSize)
        self.font = UIFont.init(name: Font.PoppinsRegular, size: size)
    }
    
    func setPoppinsMediumFont(fontSize: CGFloat) {
        let size = getFontSize(FontSize: fontSize)
        self.font = UIFont.init(name: Font.PoppinsMedium, size: size)
    }
    
    func setPoppinsSemiBoldFont(fontSize: CGFloat) {
        let size = getFontSize(FontSize: fontSize)
        self.font = UIFont.init(name: Font.PoppinsSemiBold, size: size)
    }
    
    func setPoppinsBoldFont(fontSize: CGFloat) {
        let size = getFontSize(FontSize: fontSize)
        self.font = UIFont.init(name: Font.PoppinsBold, size: size)
    }
    
    func setPoppinsLightFont(fontSize: CGFloat) {
        let size = getFontSize(FontSize: fontSize)
        self.font = UIFont.init(name: Font.PoppinsLight, size: size)
    }
    
    func setPoppinsItalicFont(fontSize: CGFloat) {
        let size = getFontSize(FontSize: fontSize)
        self.font = UIFont.init(name: Font.PoppinsItalic, size: size)
    }
    
    



    
    /** Sets up the label with two different kinds of attributes in its attributed text.
     *  @params:
     *  - primaryString: the normal attributed string.
     *  - secondaryString: the bold or highlighted string.
     */
    
    func setAttributedText(primaryString: String, textColor: UIColor, secondaryString: String, secondaryTextColor: UIColor,tupr:Bool) {
        
        let completeString = "\(primaryString) \(secondaryString)"
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .justified
        
        let completeAttributedString = NSMutableAttributedString(
            string: completeString, attributes: [
                .font: setPoppinsBoldFont(fontSize: Constants.screenWidth/21),
                .foregroundColor: textColor,
                .paragraphStyle: paragraphStyle
            ]
        )
        
        let secondStringAttribute: [NSAttributedString.Key: Any]!
        
        if tupr == true{
            secondStringAttribute = [
                .font: setPoppinsRegularFont(fontSize: 25),
                .foregroundColor: secondaryTextColor,
                .paragraphStyle: paragraphStyle,
                .underlineStyle : true
            ]
        }else{
            secondStringAttribute = [
                .font: setPoppinsRegularFont(fontSize: 25),
                .foregroundColor: secondaryTextColor,
                .paragraphStyle: paragraphStyle
            ]
        }
        
        let range = (completeString as NSString).range(of: secondaryString)
        
        completeAttributedString.addAttributes(secondStringAttribute, range: range)
        
        self.attributedText = completeAttributedString
    }*/
}
