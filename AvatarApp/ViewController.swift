//
//  ViewController.swift
//  AvatarApp
//
//  Created by Nikolay Pochekuev on 24.04.2024.
//

import UIKit

class ViewController: UIViewController {
    var observer: NSKeyValueObservation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    @objc func funcyFunk() {
        print("hello")
    }
    
    private let rightButton = UIButton()
    private let scrollView = UIScrollView()
    private let contentView = UIView()
}

private extension ViewController {
    func setup() {
        self.view.backgroundColor = .white
        self.view.addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        makeConstraints()
        
        setupObservation()
        setupNavBar()
    }
    
    func setupNavBar() {
        self.title = "Avatar"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        rightButton.setImage(UIImage(systemName: "person.crop.circle.fill"), for: .normal)
        rightButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.fill
        rightButton.contentVerticalAlignment =  UIControl.ContentVerticalAlignment.fill
        rightButton.tintColor = .systemGray3
        rightButton.addTarget(self, action: #selector(funcyFunk), for: .touchUpInside)
        navigationController?.navigationBar.addSubview(rightButton)
        
        guard let targetView = self.navigationController?.navigationBar else { return }
        
        rightButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rightButton.heightAnchor.constraint(equalToConstant: 36),
            rightButton.widthAnchor.constraint(equalToConstant: 36),
            rightButton.trailingAnchor.constraint(equalTo: targetView.trailingAnchor, constant: -16),
            rightButton.bottomAnchor.constraint(equalTo: targetView.bottomAnchor, constant: -8)
        ])
        
    }
    
    func setupObservation() {
        self.observer = self.navigationController?.navigationBar.observe(\.bounds, options: [.new], changeHandler: { (navigationBar, changes) in
            if let height = changes.newValue?.height {
                if height > 44.0 {
                    self.rightButton.isHidden = false
                } else {
                    self.rightButton.isHidden = true
                }
            }
        })
    }
    
    func makeConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant:  0),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
        ])
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            contentView.heightAnchor.constraint(equalToConstant: 1000)
        ])
    }
}
