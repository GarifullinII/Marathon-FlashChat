//
//  ChatViewController.swift
//  FlashChat
//
//  Created by Ildar Garifullin on 14/10/2024.
//

import UIKit
import SwiftUI

class ChatViewController: UIViewController {
    
    //MARK: - UI elements
    lazy var messageTextField: UITextField = {
        let t = UITextField()
        t.placeholder = "Write a message..."
        t.borderStyle = .roundedRect
        t.layer.cornerRadius = 10
        t.layer.borderWidth = 2
        t.layer.borderColor = UIColor.specialBrown.cgColor
        t.layer.masksToBounds.toggle()
        t.adjustsFontSizeToFitWidth = true
        t.clearButtonMode = .always
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()
    
    private let sendButton: UIButton = {
        let b = UIButton(type: .system)
        b.tintColor = .specialBrown
        b.setImage(UIImage(systemName: "paperplane.fill"), for: .normal)
        b.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    var horizontalStackView = UIStackView()
    
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
        
        horizontalStackView = UIStackView(
            arrangedSubviews: [
                messageTextField,
                sendButton
            ],
            axis: .horizontal,
            spacing: 12)
        view.addSubview(horizontalStackView)
    }
    
    private func setDelegates() {
        messageTextField.delegate = self
    }
    
    @objc
    private func sendButtonTapped() {
    }
    
    //MARK: - Methods
}

//MARK: - Set constraints
extension ChatViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            horizontalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            horizontalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            horizontalStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -12),
            
            
        ])
    }
}

//MARK: - UITextFieldDelegate
extension ChatViewController: UITextFieldDelegate {
}

//MARK: - ViewControllerPreview
struct ViewControllerPreview: PreviewProvider {
    static var previews: some View {
        VCPreview {ChatViewController()}
    }
}


