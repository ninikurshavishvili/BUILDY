//
//  SignInViewController.swift
//  FinalProjectDemo
//
//  Created by Nino Kurshavishvili on 03.01.25.
//


import UIKit

final class AuthorizationPage: UIViewController {
    
    let viewModel = AuthorizationViewModel()

    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "BUILDY_LOGO")
        return imageView
    }()

    let signInButton: UIButton = UIHelper.createSignInButton()
    let createAccountButton: UIButton = UIHelper.createAccountButton()

    let guestButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.black, for: .normal)
        
        let attributedString = NSMutableAttributedString(string: "Enter as a Guest")
        
        attributedString.addAttributes([
            .foregroundColor: AppColors.customOrange,
            .font: UIFont.boldSystemFont(ofSize: 16)
        ], range: (attributedString.string as NSString).range(of: "Guest"))
        
        button.setAttributedTitle(attributedString, for: .normal)
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
        
        signInButton.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
        createAccountButton.addTarget(self, action: #selector(createAccountButtonTapped), for: .touchUpInside)

        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 70),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 150),
            logoImageView.widthAnchor.constraint(equalToConstant: 300),

            signInButton.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 50),
            signInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            signInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            signInButton.heightAnchor.constraint(equalToConstant: 50),

            createAccountButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 16),
            createAccountButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            createAccountButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            createAccountButton.heightAnchor.constraint(equalToConstant: 50),

            guestButton.topAnchor.constraint(equalTo: createAccountButton.bottomAnchor, constant: 70),
            guestButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
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

