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
    private let exampleLabel: UILabel = {
        let label = UILabel()
        label.text = "Example example"
        label.textColor = .gray
        label.font = UIFont(name: "Roboto-Medium", size: 24)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var exampleImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "sun.max")
        iv.contentMode = .scaleAspectFill
        iv.layer.borderWidth = 5
        iv.clipsToBounds = true
        iv.layer.borderColor = UIColor.red.cgColor
        iv.tintColor = .label
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let exampleButton: UIButton = {
        let b = UIButton(type: .system)
        b.backgroundColor = .label
        b.layer.cornerRadius = 10
        b.setTitle("Example", for: .normal)
        b.titleLabel?.font = UIFont(name: "Roboto-Medium", size: 24)
        b.tintColor = .green
        b.setImage(UIImage(named: "addWorkout"), for: .normal)
        b.addTarget(self, action: #selector(exampleButtonTapped), for: .touchUpInside)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    lazy var exampleTextField: UITextField = {
        let t = UITextField()
        t.placeholder = "Example"
        t.borderStyle = .roundedRect
        t.layer.cornerRadius = 10
        t.layer.borderWidth = 2
        t.layer.borderColor = UIColor.red.cgColor
        t.adjustsFontSizeToFitWidth = true
        t.clearButtonMode = .always
        t.returnKeyType = .search
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
        setDelegates()
    }
    
    //MARK: - Private methods
    private func setupViews() {
        view.backgroundColor = .blue
        
        view.addSubview(exampleImageView)
    }
    
    private func setDelegates() {
        //        exampleTextField.delegate = self
    }
    
    @objc
    private func exampleButtonTapped() {
    }
    
    //MARK: - Methods
}

//MARK: - Set constraints
extension WelcomeViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            exampleImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            exampleImageView.topAnchor.constraint(equalTo: view.topAnchor),
            exampleImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            exampleImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
        ])
    }
}

////MARK: - ViewControllerPreview
//struct ViewControllerPreview: PreviewProvider {
//    static var previews: some View {
//        VCPreview {ViewController()}
//    }
//}


