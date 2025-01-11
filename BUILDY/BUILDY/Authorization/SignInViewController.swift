//
//  SignUpViewController.swift
//  FinalProjectDemo
//
//  Created by Nino Kurshavishvili on 04.01.25.
//

import UIKit
import FirebaseAuth


class SignInViewController: UIViewController {  
    
    let emailTextField: UITextField = {  
        let textField = UITextField()  
        textField.placeholder = "Email"  
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.leftViewMode = .always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        return textField
    }()  
    
    let passwordTextField: UITextField = {  
        let textField = UITextField()  
        textField.placeholder = "Password"  
        textField.isSecureTextEntry = true  
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        return textField
    }()  
    
    let signUpButton: UIButton = {  
        let button = UIButton(type: .system)  
        button.setTitle("Sign In", for: .normal)
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)  
        button.layer.cornerRadius = 5  
        button.translatesAutoresizingMaskIntoConstraints = false  
        button.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)  
        return button  
    }()  
    
    let cancelButton: UIButton = {  
        let button = UIButton(type: .system)  
        button.setTitle("Cancel", for: .normal)  
        button.setTitleColor(.red, for: .normal)  
        button.translatesAutoresizingMaskIntoConstraints = false  
        button.addTarget(self, action: #selector(cancelTapped), for: .touchUpInside)  
        return button  
    }()  
    
    override func viewDidLoad() {  
        super.viewDidLoad()  
        view.backgroundColor = .white  
        setupUI()
        
    }
    
    private func setupUI() {  
        view.addSubview(emailTextField)  
        view.addSubview(passwordTextField)  
        view.addSubview(signUpButton)  
        view.addSubview(cancelButton)  
        
        NSLayoutConstraint.activate([  
            emailTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),  
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),  
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),  
            emailTextField.heightAnchor.constraint(equalToConstant: 40),  
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),  
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),  
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),  
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),  
            
            signUpButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30),  
            signUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),  
            signUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),  
            signUpButton.heightAnchor.constraint(equalToConstant: 50),  

            cancelButton.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 10),  
            cancelButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)  
        ])  
    }  
    
    @objc private func signUpTapped() {
        print("Sign Up tapped")
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            print("missing Field Data")
            return
        }

        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion: { [weak self] result, error in
            guard let strongSelf = self else {
                return
            }
            
            guard error == nil else {
                
                strongSelf.showCreateAccount(email: email, password: password)
                return
            }
            
            print("you signed in")
            strongSelf.emailTextField.isHidden = true
            strongSelf.passwordTextField.isHidden = true
            strongSelf.cancelButton.isHidden = true
            strongSelf.signUpButton.isHidden = true
            
            strongSelf.emailTextField.resignFirstResponder()
            strongSelf.passwordTextField.resignFirstResponder()
            
        })
    }
    
    func showCreateAccount(email: String, password: String) {
        let alert = UIAlertController(title: "Create Account", message: "Please create an account", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Continue", style: .default,
                                      handler: { _ in
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel,
                                      handler: { _ in
            FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: { [weak self] result, error in
                guard let strongSelf = self else {
                    return
                }
                
                guard error == nil else {
                    print("Account creation failed")
                    return
                }
                
                print("you signed in")
                strongSelf.emailTextField.isHidden = true
                strongSelf.passwordTextField.isHidden = true
                strongSelf.cancelButton.isHidden = true
                strongSelf.signUpButton.isHidden = true
                
                strongSelf.emailTextField.resignFirstResponder()
                strongSelf.passwordTextField.resignFirstResponder()
            })
            
        }))
        
        
        
        present(alert, animated: true)
        
    }
    
    @objc private func cancelTapped() {
        dismiss(animated: true, completion: nil)
    }
}
