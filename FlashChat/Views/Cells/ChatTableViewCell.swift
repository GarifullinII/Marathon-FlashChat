//
//  ChatTableViewCell.swift
//  FlashChat
//
//  Created by Ildar Garifullin on 17.10.2024.
//

import UIKit

class ChatTableViewCell: UITableViewCell {
    
    //MARK: - UI elements
    let backgroundCell: UIView = {
        let v = UIView()
        v.backgroundColor = .none
        v.layer.cornerRadius = 10
        v.layer.borderWidth = 2
        v.layer.borderColor = UIColor.specialTurquoise.cgColor
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let bodyLabel: UILabel = {
        let l = UILabel()
        l.text = "Body"
        l.textColor = .specialTurquoise
        l.numberOfLines = 0
        l.adjustsFontSizeToFitWidth = true
        l.minimumScaleFactor = 0.5
        l.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let senderMyLabel: UILabel = {
        let l = UILabel()
        l.text = "Sender"
        l.textColor = .specialBrown
        l.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let senderYourLabel: UILabel = {
        let l = UILabel()
        l.text = "Sender"
        l.textColor = .specialTurquoise
        l.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    //MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private methods
    private func setupViews() {
        backgroundColor = .clear
        selectionStyle = .none
        addSubview(backgroundCell)
        addSubview(bodyLabel)
        addSubview(senderMyLabel)
        addSubview(senderYourLabel)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            backgroundCell.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            backgroundCell.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            backgroundCell.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            backgroundCell.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            
            bodyLabel.leadingAnchor.constraint(equalTo: backgroundCell.leadingAnchor, constant: 10),
            bodyLabel.topAnchor.constraint(equalTo: backgroundCell.topAnchor, constant: 4),
            bodyLabel.trailingAnchor.constraint(equalTo: backgroundCell.trailingAnchor, constant: -10),
            bodyLabel.bottomAnchor.constraint(equalTo: backgroundCell.bottomAnchor, constant: -4),
            
            senderMyLabel.topAnchor.constraint(equalTo: backgroundCell.bottomAnchor, constant: 2),
            senderMyLabel.trailingAnchor.constraint(equalTo: backgroundCell.trailingAnchor, constant: -10),
            senderMyLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2),
            
            senderYourLabel.topAnchor.constraint(equalTo: backgroundCell.bottomAnchor, constant: 2),
            senderYourLabel.leadingAnchor.constraint(equalTo: backgroundCell.leadingAnchor, constant: 10),
            senderYourLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2),
        ])
    }
    
    //MARK: - Methods
    func cellConfigure(_ body: String, _ sender: String) {
        bodyLabel.text =  body
        senderMyLabel.text = sender
        senderYourLabel.text = sender
    }
}
