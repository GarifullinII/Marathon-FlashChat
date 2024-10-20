//
//  ViewController.swift
//  FlashChat
//
//  Created by Ildar Garifullin on 14/10/2024.
//

import UIKit
import SwiftUI

class WelcomeViewController: UIViewController {
    
    //MARK: - UI elements
    lazy var personImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "person.2.circle")
        iv.contentMode = .scaleAspectFill
        iv.tintColor = .specialTurquoise
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let chatLabel: UILabel = {
        let l = UILabel()
        l.text = "FlashChat"
        l.textColor = .specialTurquoise
        l.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    lazy var registerButton: UIButton = {
        let b = UIButton(type: .system)
        b.backgroundColor = .specialTurquoise
        b.setTitle("Register", for: .normal)
        b.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        b.tintColor = .white
        b.addTarget(self, action: #selector(registrationButtonTapped), for: .touchUpInside)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    lazy var logInButton: UIButton = {
        let b = UIButton(type: .system)
        b.backgroundColor = .specialGray
        b.setTitle("LogIn", for: .normal)
        b.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        b.tintColor = .specialTurquoise
        b.addTarget(self, action: #selector(logInButtonTapped), for: .touchUpInside)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    var horizontalStackView = UIStackView()
    var verticalStackView = UIStackView()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
        setDelegates()
        animationForChatLabel()
    }
    
    //MARK: - Private methods
    private func setupViews() {
        view.backgroundColor = .white
        
        horizontalStackView = UIStackView(
            arrangedSubviews: [
                personImageView,
                chatLabel
            ],
            axis: .horizontal,
            spacing: 12)
        view.addSubview(horizontalStackView)
        
        verticalStackView = UIStackView(
            arrangedSubviews: [
                registerButton,
                logInButton
            ],
            axis: .vertical,
            spacing: 4)
        view.addSubview(verticalStackView)
    }
    
    private func setDelegates() {
    }
    
    @objc
    private func registrationButtonTapped() {
        navigationController?.pushViewController(RegisterViewController(), animated: true)
    }
    
    @objc
    private func logInButtonTapped() {
        navigationController?.pushViewController(LoginViewController(), animated: true)
    }
    
    //MARK: - Methods
    func animationForChatLabel() {
        chatLabel.text = ""
        var chartIndex = 0.0
        let title = "FlashChat"
        for letter in title {
            Timer.scheduledTimer(withTimeInterval: 0.2 * chartIndex, repeats: false) { timer in
                self.chatLabel.text?.append(letter)
            }
            chartIndex += 1
        }
    }
}

//MARK: - Set constraints
extension WelcomeViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            horizontalStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            horizontalStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            verticalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            verticalStackView.topAnchor.constraint(equalTo: horizontalStackView.bottomAnchor, constant: 200),
            verticalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}

////MARK: - ViewControllerPreview
//struct ViewControllerPreview: PreviewProvider {
//    static var previews: some View {
//        VCPreview {WelcomeViewController()}
//    }
//}


