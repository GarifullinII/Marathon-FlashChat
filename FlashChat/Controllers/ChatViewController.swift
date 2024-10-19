//
//  ChatViewController.swift
//  FlashChat
//
//  Created by Ildar Garifullin on 14/10/2024.
//

import UIKit
import SwiftUI
import FirebaseAuth
import FirebaseFirestore

class ChatViewController: UIViewController {
    
    var messages: [Message] = []
    
    let idTableViewCell = "idTableViewCell"
    let db = Firestore.firestore()
    
    //MARK: - UI elements
    lazy var messageTextField: UITextField = {
        let t = UITextField()
        t.placeholder = "Write a message..."
        t.borderStyle = .roundedRect
        t.layer.cornerRadius = 10
        t.layer.borderWidth = 2
        t.layer.borderColor = UIColor.specialGray.cgColor
        t.layer.masksToBounds.toggle()
        t.adjustsFontSizeToFitWidth = true
        t.clearButtonMode = .always
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()
    
    lazy var sendButton: UIButton = {
        let b = UIButton(type: .system)
        b.tintColor = .specialGray
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
        rightBarButton()
        
        tableView.register(ChatTableViewCell.self, forCellReuseIdentifier: idTableViewCell)
        
        loadMessage()
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
        guard let messageBody = messageTextField.text, let messageSender = Auth.auth().currentUser?.email  else { return }
        db.collection("messages").addDocument(data: [
            "sender": messageSender,
            "body": messageBody,
            "date": Date().timeIntervalSince1970
        ]) { (error) in
            if let error = error {
                print("There was an issue saving data to firectore, \(error)")
            } else {
                print("Successfully saved")
                
                DispatchQueue.main.async {
                    self.messageTextField.text = ""
                }
            }
        }
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
    func rightBarButton() {
        let rightBarButton = UIBarButtonItem(
            image: UIImage(systemName: "square.and.arrow.up.fill"),
            style: .plain,
            target: self,
            action: #selector(logOutButtonTapped))
        navigationItem.rightBarButtonItem = rightBarButton
        rightBarButton.tintColor = .specialGray
    }
    
    func loadMessage() {
        db.collection("messages")
            .order(by: "date")
            .addSnapshotListener { (querySnapshot, error) in
                self.messages = []
                
                if let error = error {
                    print("There was an issue retrieving data from Firestore. \(error)")
                } else {
                    if let snapshotDocuments = querySnapshot?.documents {
                        for doc in snapshotDocuments {
                            let data = doc.data()
                            if let messageSender = data["sender"] as? String, let messageBody = data["body"] as? String {
                                let newMessage = Message(sender: messageSender, body: messageBody)
                                self.messages.append(newMessage)
                                
                                DispatchQueue.main.async {
                                    self.tableView.reloadData()
                                    
                                    let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                                    self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                                }
                            }
                        }
                    }
                }
            }
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
            
            sendButton.widthAnchor.constraint(equalToConstant: 45),
        ])
    }
}

//MARK: - UITextFieldDelegate
extension ChatViewController: UITextFieldDelegate {}

//MARK: - UITableViewDataSource
extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: idTableViewCell, for: indexPath) as! ChatTableViewCell
        cell.cellConfigure(message.body, message.sender)
        
        if message.sender == Auth.auth().currentUser?.email {
            cell.senderYourLabel.isHidden = true
            cell.senderMyLabel.isHidden = false
            cell.senderMyLabel.text = message.sender
            cell.backgroundCell.layer.borderColor = UIColor.specialBrown.cgColor
            cell.bodyLabel.textColor = .specialBrown
        } else {
            cell.senderYourLabel.isHidden = false
            cell.senderYourLabel.text = message.sender
            cell.senderMyLabel.isHidden = true
            cell.backgroundCell.layer.borderColor = UIColor.specialTurquoise.cgColor
            cell.bodyLabel.textColor = .specialTurquoise
        }
        
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


