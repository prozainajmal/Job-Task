//
//  TextHelper.swift
//  JT
//
//  Created by Zany on 18/09/2024.
//

import Foundation
import UIKit
class TextHelper {
    
    
    func formattedText(text: String) -> NSAttributedString {
        // Split the text into components
        let components = text.split(separator: " ")
        
        // Ensure there are exactly two components: "SAR" and the number
        guard components.count == 2 else {
            return NSAttributedString(string: text) // Return unformatted text if the format is unexpected
        }
        
        let currency = String(components[0])
        let amount = String(components[1])
        
        // Create an NSMutableAttributedString from the full text
        let attributedString = NSMutableAttributedString(string: text)
        
        // Define the attributes for the currency part ("SAR")
        let currencyAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 13),
            .foregroundColor: UIColor.black
                
        ]
        
        // Define the attributes for the amount part ("1200")
        let amountAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 16),
            .foregroundColor: UIColor.systemBlue
        ]
        
        // Apply the attributes to the respective ranges
        attributedString.addAttributes(currencyAttributes, range: (text as NSString).range(of: currency))
        attributedString.addAttributes(amountAttributes, range: (text as NSString).range(of: amount))
        
        return attributedString
    }
    
}

@IBDesignable
class CustomView: UIView {

    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }

    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var shadowColor: UIColor = UIColor.clear {
        didSet {
            self.layer.shadowColor = shadowColor.cgColor
        }
    }

    @IBInspectable var shadowOpacity: Float = 0 {
        didSet {
            self.layer.shadowOpacity = shadowOpacity
        }
    }

    @IBInspectable var shadowOffset: CGSize = CGSize.zero {
        didSet {
            self.layer.shadowOffset = shadowOffset
        }
    }

    @IBInspectable var shadowRadius: CGFloat = 0 {
        didSet {
            self.layer.shadowRadius = shadowRadius
        }
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setupView()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupView()
    }

    private func setupView() {
        self.layer.masksToBounds = true
    }
}
