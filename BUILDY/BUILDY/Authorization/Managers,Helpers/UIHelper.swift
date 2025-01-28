//
//  UIHelper.swift
//  BUILDY
//
//  Created by Nino Kurshavishvili on 27.01.25.
//

import UIKit

class UIHelper {
    
    static func createTextField(placeholder: String, isSecure: Bool = false) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        textField.isSecureTextEntry = isSecure
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = AppColors.customOrange.cgColor
        textField.layer.cornerRadius = 16
        textField.leftViewMode = .always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.autocapitalizationType = .none
        return textField
    }
    
    static func createButton(title: String, backgroundColor: UIColor, titleColor: UIColor, fontSize: CGFloat = 18) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.backgroundColor = backgroundColor
        button.setTitleColor(titleColor, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: fontSize)
        button.layer.cornerRadius = 16
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    static func createLabel(text: String, font: UIFont, textColor: UIColor = .black, alignment: NSTextAlignment = .left) -> UILabel {
         let label = UILabel()
         label.text = text
         label.font = font
         label.textColor = textColor
         label.textAlignment = alignment
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
     }
    
    static func createStackView(views: [UIView], axis: NSLayoutConstraint.Axis, spacing: CGFloat, distribution: UIStackView.Distribution) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = axis
        stackView.spacing = spacing
        stackView.distribution = distribution
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
    
    static func createSignInButton() -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle("Sign In", for: .normal)
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.layer.cornerRadius = 16
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }

    static func createAccountButton() -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle("Create new account", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 16
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }


}

