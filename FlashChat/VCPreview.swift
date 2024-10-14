//
//  VCPreview.swift
//  FlashChat
//
//  Created by Ildar Garifullin on 14/10/2024.
//

import SwiftUI

struct VCPreview<T: UIViewController>: UIViewControllerRepresentable {
    let viewController: T
    
    init(_ viewControllerBuilder: @escaping () -> T) {
        viewController = viewControllerBuilder()
    }
    
    func makeUIViewController(context: Context) -> T {
        viewController
    }
    
    func updateUIViewController(_ uiViewController: T, context: Context) {}
}
