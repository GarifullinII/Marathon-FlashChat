//
//  RegisterViewController.swift
//  FlashChat
//
//  Created by Ildar Garifullin on 14/10/2024.
//

import UIKit
import SwiftUI

class RegisterViewController: UIViewController {
    
    //MARK: - UI elements
    lazy var emailTextField: UITextField = {
        let t = UITextField()
        t.placeholder = "Email"
        t.borderStyle = .roundedRect
        t.layer.cornerRadius = 10
        t.layer.borderWidth = 2
        t.layer.borderColor = UIColor.specialTurquoise.cgColor
        t.layer.masksToBounds.toggle()
        t.adjustsFontSizeToFitWidth = true
        t.clearButtonMode = .always
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()
    
    lazy var passwordTextField: UITextField = {
        let t = UITextField()
        t.placeholder = "Password"
        t.borderStyle = .roundedRect
        t.layer.cornerRadius = 10
        t.layer.borderWidth = 2
        t.layer.borderColor = UIColor.specialTurquoise.cgColor
        t.layer.masksToBounds.toggle()
        t.adjustsFontSizeToFitWidth = true
        t.clearButtonMode = .always
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()
    
    private let registerButton: UIButton = {
        let b = UIButton(type: .system)
        b.setTitle("Register", for: .normal)
        b.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        b.tintColor = .specialTurquoise
        b.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    var verticalStackView = UIStackView()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
        setDelegates()
    }
    
    //MARK: - Private methods
    private func setupViews() {
        view.backgroundColor = .white
        
        verticalStackView = UIStackView(
            arrangedSubviews: [
                emailTextField,
                passwordTextField,
                registerButton
            ],
            axis: .vertical,
            spacing: 12)
        view.addSubview(verticalStackView)
    }
    
    private func setDelegates() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    @objc
    private func registerButtonTapped() {
    }
    
    //MARK: - Methods
}

//MARK: - Set constraints
extension RegisterViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            verticalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            verticalStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            verticalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
        ])
    }
}

//MARK: - UITextFieldDelegate
extension RegisterViewController: UITextFieldDelegate {
}

////MARK: - ViewControllerPreview
//struct ViewControllerPreview: PreviewProvider {
//    static var previews: some View {
//        VCPreview {RegisterViewController()}
//    }
//}


