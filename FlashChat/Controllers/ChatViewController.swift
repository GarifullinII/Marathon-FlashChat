//
//  ChatViewController.swift
//  FlashChat
//
//  Created by Ildar Garifullin on 14/10/2024.
//

import UIKit
import SwiftUI
import FirebaseAuth

class ChatViewController: UIViewController {
    
    var messages: [Message] = [
        Message(sender: "a@a.com", body: "Hello"),
        Message(sender: "q@q.com", body: "Hi"),
        Message(sender: "q@q.com", body: "What's happend?")
    ]
    
    let idTableViewCell = "idTableViewCell"
    
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
    
    lazy var sendButton: UIButton = {
        let b = UIButton(type: .system)
        b.tintColor = .specialBrown
        b.setImage(UIImage(systemName: "paperplane.fill"), for: .normal)
        b.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    var horizontalStackView = UIStackView()
    
    private let tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .none
        tv.separatorStyle = .none
        tv.bounces = false
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
        setDelegates()
        
        navigationItem.hidesBackButton = true
        addRightBarButton()
        
        tableView.register(ChatTableViewCell.self, forCellReuseIdentifier: idTableViewCell)
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
        
        view.addSubview(tableView)
    }
    
    private func setDelegates() {
        messageTextField.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @objc
    private func sendButtonTapped() {
    }
    
    @objc
    private func logOutButtonTapped() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    //MARK: - Methods
    func addRightBarButton() {
        let rightBarButton = UIBarButtonItem(
            image: UIImage(systemName: "square.and.arrow.up.fill"),
            style: .plain,
            target: self,
            action: #selector(logOutButtonTapped))
        navigationItem.rightBarButtonItem = rightBarButton
        rightBarButton.tintColor = .specialBrown
    }
}

//MARK: - Set constraints
extension ChatViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: horizontalStackView.topAnchor),
            
            horizontalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            horizontalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            horizontalStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -12),
        ])
    }
}

//MARK: - UITextFieldDelegate
extension ChatViewController: UITextFieldDelegate {
}

//MARK: - UITableViewDataSource
extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idTableViewCell, for: indexPath) as! ChatTableViewCell
        cell.cellConfigure(messages[indexPath.row].body, messages[indexPath.row].sender)
        
        return cell
    }
}

//MARK: - UITableViewDelegate
extension ChatViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
}

////MARK: - ViewControllerPreview
//struct ViewControllerPreview: PreviewProvider {
//    static var previews: some View {
//        VCPreview {ChatViewController()}
//    }
//}


