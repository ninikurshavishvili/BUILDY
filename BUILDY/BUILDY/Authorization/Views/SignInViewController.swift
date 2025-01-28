//
//  SignUpViewController.swift
//  FinalProjectDemo
//
//  Created by Nino Kurshavishvili on 04.01.25.
//

import UIKit

final class SignInViewController: UIViewController {

    private let viewModel = AuthorizationViewModel()

    private let titleLabel = UIHelper.createLabel(text: "Sign In", font: .boldSystemFont(ofSize: 30))
    private let subtitleLabel = UIHelper.createLabel(text: "Welcome back!", font: .systemFont(ofSize: 18), textColor: .gray)
    private let emailTextField = UIHelper.createTextField(placeholder: "Email or Phone Number")
    private let passwordTextField = UIHelper.createTextField(placeholder: "Password", isSecure: true)
    private let signInButton = UIHelper.createButton(title: "Sign In", backgroundColor: .secondarySystemFill, titleColor: .darkGray)
    private let socialSignInLabel = UIHelper.createLabel(text: "or sign in using:", font: .systemFont(ofSize: 16), textColor: .gray, alignment: .center)

    private let socialStackView: UIStackView = {
        let googleButton = UIButton()
        googleButton.setImage(UIImage(named: "google_icon"), for: .normal)

        let stackView = UIStackView(arrangedSubviews: [googleButton])
        stackView.axis = .horizontal
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
        setupCustomBackButton()
    }

    private func setupCustomBackButton() {
        let backButton = UIButton(type: .system)
        let chevronImage = UIImage(systemName: "chevron.left")?.withRenderingMode(.alwaysTemplate)
        backButton.setImage(chevronImage, for: .normal)
        backButton.tintColor = .black
        backButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        backButton.translatesAutoresizingMaskIntoConstraints = false

        let customBarButtonItem = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = customBarButtonItem
    }

    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
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
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

            emailTextField.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 100),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),

            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),

            signInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 40),
            signInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            signInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            signInButton.heightAnchor.constraint(equalToConstant: 50),

            socialSignInLabel.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 100),
            socialSignInLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            socialStackView.topAnchor.constraint(equalTo: socialSignInLabel.bottomAnchor, constant: 20),
            socialStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            socialStackView.heightAnchor.constraint(equalToConstant: 40),
            socialStackView.widthAnchor.constraint(equalToConstant: 40),

            termsLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            termsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])


        signInButton.addTarget(self, action: #selector(signInTapped), for: .touchUpInside)

        if let googleButton = socialStackView.arrangedSubviews.last as? UIButton {
            googleButton.addTarget(self, action: #selector(googleSignInTapped), for: .touchUpInside)
        }
    }
    
    private func setupBindings() {
        viewModel.onSignInSuccess = { user in

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
    
    @objc private func googleSignInTapped() {
        viewModel.signInWithGoogle()
    }
}
