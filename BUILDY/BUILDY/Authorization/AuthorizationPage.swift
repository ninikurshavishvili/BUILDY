//
//  SignInViewController.swift
//  FinalProjectDemo
//
//  Created by Nino Kurshavishvili on 03.01.25.
//


import UIKit

class AuthorizationPage: UIViewController {
    
    let viewModel = AuthorizationViewModel()

    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "BUILDY_LOGO")
        return imageView
    }()

    let signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign In", for: .normal)
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let createAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Create new account", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let guestButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Enter as a Guest", for: .normal)
        button.setTitleColor(.orange, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let languageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("EN", for: .normal)
        button.setTitleColor(.orange, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        
        viewModel.onSignInRequested = { [weak self] in
            self?.showSignIn()
        }
        viewModel.onCreateAccountRequested = { [weak self] in
            self?.showSignup()
        }
        
        guestButton.addTarget(self, action: #selector(guestButtonTapped), for: .touchUpInside)
    }

    private func setupUI() {
        view.addSubview(logoImageView)
        view.addSubview(signInButton)
        view.addSubview(createAccountButton)
        view.addSubview(guestButton)
        view.addSubview(languageButton)
        
        signInButton.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
        createAccountButton.addTarget(self, action: #selector(createAccountButtonTapped), for: .touchUpInside)

        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 100),
            logoImageView.widthAnchor.constraint(equalToConstant: 200),

            signInButton.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 50),
            signInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            signInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            signInButton.heightAnchor.constraint(equalToConstant: 50),

            createAccountButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 20),
            createAccountButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            createAccountButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            createAccountButton.heightAnchor.constraint(equalToConstant: 50),

            guestButton.topAnchor.constraint(equalTo: createAccountButton.bottomAnchor, constant: 30),
            guestButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            languageButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            languageButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    @objc private func signInButtonTapped() {
        viewModel.signInTapped()
    }
    
    @objc private func createAccountButtonTapped() {
        viewModel.createAccountTapped()
    }

    @objc private func guestButtonTapped() {
        viewModel.enterAsGuest()
        let tabBarController = MainTabBarController()
        navigationController?.setViewControllers([tabBarController], animated: true)
    }
    
    private func showSignIn() {
        let signInVC = SignInViewController()
        navigationController?.pushViewController(signInVC, animated: true)
    }
    
    private func showSignup() {
        let signUpVC = SignUpViewController()
        navigationController?.pushViewController(signUpVC, animated: true)
    }
}
