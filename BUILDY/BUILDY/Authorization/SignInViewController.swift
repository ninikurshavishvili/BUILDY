//
//  SignUpViewController.swift
//  FinalProjectDemo
//
//  Created by Nino Kurshavishvili on 04.01.25.
//

import UIKit
import FirebaseAuth

class SignInViewController: UIViewController {

    private let viewModel = AuthorizationViewModel()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Sign In"
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome back!"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email or Phone Number"
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.orange.cgColor
        textField.layer.cornerRadius = 16
        textField.leftViewMode = .always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        return textField
    }()

    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.orange.cgColor
        textField.layer.cornerRadius = 16
        textField.leftViewMode = .always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        return textField
    }()

    private let signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign In", for: .normal)
        button.backgroundColor = UIColor.lightGray
        button.setTitleColor(.darkGray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        button.layer.cornerRadius = 16
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let socialSignInLabel: UILabel = {
        let label = UILabel()
        label.text = "or sign in using:"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .gray
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let socialStackView: UIStackView = {
        let facebookButton = UIButton()
        facebookButton.setImage(UIImage(named: "facebook_icon"), for: .normal)
        
        let appleButton = UIButton()
        appleButton.setImage(UIImage(named: "apple_icon"), for: .normal)

        let googleButton = UIButton()
        googleButton.setImage(UIImage(named: "google_icon"), for: .normal)

        let stackView = UIStackView(arrangedSubviews: [facebookButton, appleButton, googleButton])
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let termsLabel: UILabel = {
        let label = UILabel()
        label.text = "I accept the Terms of Use and Privacy Policy"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        setupBindings()
    }

    private func setupUI() {
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(signInButton)
        view.addSubview(socialSignInLabel)
        view.addSubview(socialStackView)
        view.addSubview(termsLabel)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            subtitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            emailTextField.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 40),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),

            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),

            signInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30),
            signInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            signInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            signInButton.heightAnchor.constraint(equalToConstant: 50),

            socialSignInLabel.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 40),
            socialSignInLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            socialStackView.topAnchor.constraint(equalTo: socialSignInLabel.bottomAnchor, constant: 20),
            socialStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            socialStackView.heightAnchor.constraint(equalToConstant: 50),

            termsLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            termsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])

        signInButton.addTarget(self, action: #selector(signInTapped), for: .touchUpInside)
    }
    
    private func setupBindings() {
        viewModel.onSignInSuccess = { user in
            print("✅ Successfully signed in!")
            print("User Email: \(user.email ?? "N/A")")
            print("User UID: \(user.uid)")

            let tabBarController = MainTabBarController()
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let window = windowScene.windows.first else { return }
            window.rootViewController = tabBarController
            window.makeKeyAndVisible()

        }

        viewModel.onSignInFailure = { [weak self] errorMessage in
            let alert = UIAlertController(title: "Sign-In Failed", message: errorMessage, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self?.present(alert, animated: true, completion: nil)
        }
    }

    @objc private func signInTapped() {
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        viewModel.signIn(email: email, password: password)
    }
}


