//
//  CustomTextField.swift
//  CustomTextFields
//
//  Created by Michael Evensen on 07/09/2017.
//  Copyright © 2017 Michael Evensen. All rights reserved.
//

import UIKit


@IBDesignable
open class CustomTextField: UITextField {
    
    /// The internal `UILabel` that displays the selected, deselected title or error message based on the current state.
    open var titleLabel: UILabel!
    
    /// The internal `UILabel` that displays the selected, deselected title or error message based on the current state.
     @IBInspectable open var titleLabelText: String? {
        didSet {
            guard let text = self.titleLabelText else {
                return
            }
            self.titleLabel.text = text.uppercased()
        }
    }
    
    fileprivate func createTitleLabel() {
        
        // Add label
        let label = UILabel()
        
        // Set font
        if let font = self.font {
            label.font = UIFont(name: font.fontName, size: font.pointSize * 0.9)
        } else {
            label.font = UIFont.systemFont(ofSize: 12)
        }
        
        label.textColor = UIColor.darkGray
        label.textAlignment = .left
        label.autoresizingMask = [.flexibleTopMargin, .flexibleRightMargin]
        
        addSubview(label)
        self.titleLabel = label
    }
    
    /// Invoked when the interface builder renders the control
    override open func prepareForInterfaceBuilder() {
        if #available(iOS 8.0, *) {
            super.prepareForInterfaceBuilder()
        }
        borderStyle = .none
        
        self.isSelected = true
        invalidateIntrinsicContentSize()
    }
    
    fileprivate func calculateFrameForLabel() -> CGRect {
        return CGRect(x: 0, y: -self.titleHeight() * 1.5, width: bounds.size.width, height: self.titleHeight())
    }
    
    /// Invoked by layoutIfNeeded automatically
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        // Set frame for titleLabel
        self.titleLabel.frame = self.calculateFrameForLabel()
    }
    
    /**
     Calculate the height of the title label.
     -returns: the calculated height of the title label. Override to size the title with a different height
     */
    open func titleHeight() -> CGFloat {
        if let titleLabel = titleLabel,
            let font = titleLabel.font {
            return font.lineHeight
        }
        return 15.0
    }
    
    /**
     Calcualte the height of the textfield.
     -returns: the calculated height of the textfield. Override to size the textfield with a different height
     */
    open func textHeight() -> CGFloat {
        return self.font!.lineHeight + 7.0
    }
    
    override open var intrinsicContentSize: CGSize {
        return CGSize(width: bounds.size.width, height: titleHeight() + textHeight())
    }
    
    /**
     Initializes the control
     - parameter frame the frame of the control
     */
    override public init(frame: CGRect) {
        super.init(frame: frame)
        createTitleLabel()
    }
    
    /**
     Intialzies the control by deserializing it
     - parameter coder the object to deserialize the control from
     */
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createTitleLabel()
    }
}

//extension CustomTextField: UITextFieldDelegate {
//    public func textFieldDidEndEditing(_ textField: UITextField) {
//        self.titleLabelText = "Done"
//    }
//}
