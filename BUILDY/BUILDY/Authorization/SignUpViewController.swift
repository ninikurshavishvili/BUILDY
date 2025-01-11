//
//  SignUpViewController.swift
//  FinalProjectDemo
//
//  Created by Nino Kurshavishvili on 04.01.25.
//


import UIKit  
import FirebaseAuth  

class SignUpViewController: UIViewController {  
    
    let fullNameTextField: UITextField = {  
        let textField = UITextField()  
        textField.placeholder = "Full Name"  
        textField.borderStyle = .roundedRect  
        textField.translatesAutoresizingMaskIntoConstraints = false  
        textField.leftViewMode = .always  
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))  
        return textField  
    }()  

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
        textField.leftViewMode = .always  
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))  
        return textField  
    }()  
    
    let confirmPasswordTextField: UITextField = {  
        let textField = UITextField()  
        textField.placeholder = "Confirm Password"  
        textField.isSecureTextEntry = true  
        textField.borderStyle = .roundedRect  
        textField.autocapitalizationType = .none  
        textField.translatesAutoresizingMaskIntoConstraints = false  
        textField.leftViewMode = .always  
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))  
        return textField  
    }()  
    
    let signUpButton: UIButton = {  
        let button = UIButton(type: .system)  
        button.setTitle("Sign Up", for: .normal)  
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
        view.addSubview(fullNameTextField)  
        view.addSubview(emailTextField)  
        view.addSubview(passwordTextField)  
        view.addSubview(confirmPasswordTextField)  
        view.addSubview(signUpButton)  
        view.addSubview(cancelButton)  
        
        NSLayoutConstraint.activate([  
            fullNameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),  
            fullNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),  
            fullNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),  
            fullNameTextField.heightAnchor.constraint(equalToConstant: 40),  
            
            emailTextField.topAnchor.constraint(equalTo: fullNameTextField.bottomAnchor, constant: 20),  
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),  
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),  
            emailTextField.heightAnchor.constraint(equalToConstant: 40),  
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),  
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),  
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),  
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),  
            
            confirmPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),  
            confirmPasswordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),  
            confirmPasswordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),  
            confirmPasswordTextField.heightAnchor.constraint(equalToConstant: 40),  

            signUpButton.topAnchor.constraint(equalTo: confirmPasswordTextField.bottomAnchor, constant: 30),  
            signUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),  
            signUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),  
            signUpButton.heightAnchor.constraint(equalToConstant: 50),  
            
            cancelButton.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 10),  
            cancelButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)  
        ])  
    }  
    
    @objc private func signUpTapped() {  
        guard let fullName = fullNameTextField.text, !fullName.isEmpty,  
              let email = emailTextField.text, !email.isEmpty,  
              let password = passwordTextField.text, !password.isEmpty,  
              let confirmPassword = confirmPasswordTextField.text, !confirmPassword.isEmpty else {  
            print("Missing field data")  
            return  
        }  

        if password != confirmPassword {  
            print("Passwords do not match")  
            return  
        }  
        
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in  
            if let error = error {  
                print("Account creation failed: \(error.localizedDescription)")  
                return  
            }  
            print("Account created successfully")  
            self?.dismiss(animated: true, completion: nil)  
        }  
    }  
    
    @objc private func cancelTapped() {  
        dismiss(animated: true, completion: nil)  
    }  
}
