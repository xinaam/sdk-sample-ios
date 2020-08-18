//
//  UITextField+Extension.swift
//  Pandalove
//
//  Created by dilipkumar on 22/04/19.
//  Copyright © 2019 dilipkumar. All rights reserved.
//

import UIKit

extension UITextField {
    
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
    */
    
  /*  @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!,NSAttributedString.Key.font: UIFont.init(name: Font.PoppinsRegular, size: getFontSize(FontSize: 28))!])
        }
    }*/
    
    
    @IBInspectable var bottomBorderColor: UIColor? {
        get {
            return self.bottomBorderColor
        }
        set {
            DispatchQueue.main.async {
                self.borderStyle = UITextField.BorderStyle.none;
                let border = CALayer()
                let width = CGFloat(0.5)
                border.borderColor = newValue?.cgColor
                border.frame = CGRect(x: 0, y: self.frame.size.height - width,   width:  Constants.screenWidth, height: self.frame.size.height)
                
                border.borderWidth = width
                self.layer.addSublayer(border)
                self.layer.masksToBounds = true
                self.layoutIfNeeded()
            }
        }
    }
    
    func setLeftRightText() {
        leftViewMode = .always
        let leftLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 20, height: self.frame.size.height))
        leftLabel.text = "+"
        leftLabel.textColor = UIColor.black
        leftLabel.textAlignment = .left
//        leftLabel.
        let viewLeft = UIView(frame : CGRect(x: 0, y: 0, width: 20, height: self.frame.size.height))
        viewLeft.addSubview(leftLabel)
        leftView = viewLeft
        
        rightViewMode = .always
        let rightLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 20, height: self.frame.size.height))
        rightLabel.text = "-"
        rightLabel.textColor = UIColor.label//AppColor.dark
        rightLabel.textAlignment = .center
//        rightLabel.setPoppinsRegularFont(fontSize: 26)
        let viewRight = UIView(frame : CGRect(x: 0, y: 0, width: 20, height: self.frame.size.height))
        viewRight.addSubview(rightLabel)
        rightView = viewRight
    }
    
   
}

@IBDesignable
open class PlaceholderTextView: UITextView {
    
 /*   func setPoppinsRegularFont(fontSize: CGFloat) {
        let size = getFontSize(FontSize: fontSize)
        self.font = UIFont.init(name: Font.PoppinsRegular, size: size)
    }
    
    func setPoppinsSemiBoldFont(fontSize: CGFloat) {
        let size = getFontSize(FontSize: fontSize)
        self.font = UIFont.init(name: Font.PoppinsSemiBold, size: size)
    }
    
    func setPoppinsBoldFont(fontSize: CGFloat) {
        let size = getFontSize(FontSize: fontSize)
        self.font = UIFont.init(name: Font.PoppinsBold, size: size)
    }*/
    
   
    
    private struct Constants {
        static let defaultiOSPlaceholderColor = UIColor(red: 0.0, green: 0.0, blue: 0.0980392, alpha: 0.22)
    }
    
    public let placeholderLabel: UILabel = UILabel()
    
    private var placeholderLabelConstraints = [NSLayoutConstraint]()
    
    @IBInspectable open var placeholder: String = "" {
        didSet {
            placeholderLabel.text = placeholder
        }
    }
    
    @IBInspectable open var placeholderColor: UIColor = PlaceholderTextView.Constants.defaultiOSPlaceholderColor {
        didSet {
            placeholderLabel.textColor = placeholderColor
        }
    }
    
    override open var font: UIFont! {
        didSet {
            if placeholderFont == nil {
                placeholderLabel.font = font
            }
        }
    }
    
    open var placeholderFont: UIFont? {
        didSet {
            let font = (placeholderFont != nil) ? placeholderFont : self.font
            placeholderLabel.font = font
        }
    }
    
    override open var textAlignment: NSTextAlignment {
        didSet {
            placeholderLabel.textAlignment = textAlignment
        }
    }
    
    override open var text: String! {
        didSet {
            textDidChange()
        }
    }
    
    override open var attributedText: NSAttributedString! {
        didSet {
            textDidChange()
        }
    }
    
    override open var textContainerInset: UIEdgeInsets {
        didSet {
            updateConstraintsForPlaceholderLabel()
        }
    }
    
    override public init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        #if swift(>=4.2)
        let notificationName = UITextView.textDidChangeNotification
        #else
        let notificationName = NSNotification.Name.UITextView.textDidChangeNotification
        #endif
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(textDidChange),
                                               name: notificationName,
                                               object: nil)
        
//        placeholderLabel.font = UIFont.init(name: Font.PoppinsRegular, size: getFontSize(FontSize: 28))! // font
        placeholderLabel.textColor = placeholderColor
        placeholderLabel.textAlignment = textAlignment
        placeholderLabel.text = placeholder
        placeholderLabel.numberOfLines = 0
        placeholderLabel.backgroundColor = UIColor.clear
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(placeholderLabel)
        updateConstraintsForPlaceholderLabel()
    }
    
    private func updateConstraintsForPlaceholderLabel() {
        var newConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-(\(textContainerInset.left + textContainer.lineFragmentPadding))-[placeholder]",
            options: [],
            metrics: nil,
            views: ["placeholder": placeholderLabel])
        newConstraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-(\(textContainerInset.top))-[placeholder]",
            options: [],
            metrics: nil,
            views: ["placeholder": placeholderLabel])
        newConstraints.append(NSLayoutConstraint(
            item: placeholderLabel,
            attribute: .width,
            relatedBy: .equal,
            toItem: self,
            attribute: .width,
            multiplier: 1.0,
            constant: -(textContainerInset.left + textContainerInset.right + textContainer.lineFragmentPadding * 2.0)
        ))
        removeConstraints(placeholderLabelConstraints)
        addConstraints(newConstraints)
        placeholderLabelConstraints = newConstraints
    }
    
    @objc private func textDidChange() {
        placeholderLabel.isHidden = !text.isEmpty
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        placeholderLabel.preferredMaxLayoutWidth = textContainer.size.width - textContainer.lineFragmentPadding * 2.0
    }
    
    deinit {
        #if swift(>=4.2)
        let notificationName = UITextView.textDidChangeNotification
        #else
        let notificationName = NSNotification.Name.UITextView.textDidChangeNotification
        #endif
        
        NotificationCenter.default.removeObserver(self,
                                                  name: notificationName,
                                                  object: nil)
    }
    
}
