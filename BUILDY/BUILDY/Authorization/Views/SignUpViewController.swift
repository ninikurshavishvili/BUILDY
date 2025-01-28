//
//  SignUpViewController.swift
//  FinalProjectDemo
//
//  Created by Nino Kurshavishvili on 04.01.25.
//


import UIKit

final class SignUpViewController: UIViewController {
    
    private let viewModel = AuthorizationViewModel()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Sign Up"
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Enter your Email & Password"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let fullNameTextField = UIHelper.createTextField(placeholder: "Full Name")
    let emailTextField = UIHelper.createTextField(placeholder: "Email")
    let passwordTextField = UIHelper.createTextField(placeholder: "Password", isSecure: true)
    let confirmPasswordTextField = UIHelper.createTextField(placeholder: "Confirm Password", isSecure: true)

    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.layer.cornerRadius = 16
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        setupCustomBackButton()
        setupViewModelBindings()
    }
    
    private func setupCustomBackButton() {
        let backButton = UIButton(type: .system)
        let chevronImage = UIImage(systemName: "chevron.left")?.withRenderingMode(.alwaysTemplate)
        backButton.setImage(chevronImage, for: .normal)
        backButton.tintColor = .black
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        backButton.translatesAutoresizingMaskIntoConstraints = false

        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }

    private func setupUI() {
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(fullNameTextField)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(confirmPasswordTextField)
        view.addSubview(signUpButton)

        signUpButton.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            fullNameTextField.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 100),
            fullNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            fullNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            fullNameTextField.heightAnchor.constraint(equalToConstant: 50),
            
            emailTextField.topAnchor.constraint(equalTo: fullNameTextField.bottomAnchor, constant: 20),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            confirmPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            confirmPasswordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            confirmPasswordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            confirmPasswordTextField.heightAnchor.constraint(equalToConstant: 50),

            signUpButton.topAnchor.constraint(equalTo: confirmPasswordTextField.bottomAnchor, constant: 50),
            signUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            signUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            signUpButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    private func setupViewModelBindings() {
        viewModel.onSignInFailure = { [weak self] message in
            self?.showAlert(message: message)
        }
        viewModel.onSignInSuccess = { [weak self] _ in
            self?.navigateToSignIn()
        }
    }

    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func signUpTapped() {
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty,
              let confirmPassword = confirmPasswordTextField.text, !confirmPassword.isEmpty else {
            showAlert(message: "Please fill in all fields.")
            return
        }
        
        if password != confirmPassword {
            showAlert(message: "Passwords do not match.")
            return
        }
        
        viewModel.createAccount(email: email, password: password)
    }

    private func showAlert(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    private func navigateToSignIn() {
        if let navigationController = navigationController {
            let signInViewController = SignInViewController()
            navigationController.pushViewController(signInViewController, animated: true)
        }
    }
}

