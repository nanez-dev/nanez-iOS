//
//  CustomAlertView.swift
//  Na'nez
//
//  Created by KIM Hyung Jun on 11/28/23.
//

import UIKit
import SnapKit
import Then

class CustomAlertView: UIView {
    
    class var mainturquoise: UIColor { UIColor(named: "mainturquoise") ?? UIColor() }
    
    private let backgroundView = UIView()
    private let messageLabel = UILabel()
    private let actionButton = UIButton()
    private let topBorder = UIView()
    
    var onActionButotnTapped: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupBackGroundTouch()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        addSubview(backgroundView)
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        let containerView = UIView()
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 12
        containerView.layer.masksToBounds = true
        
        backgroundView.addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(270)
            $0.height.greaterThanOrEqualTo(150)
        }
        
        containerView.addSubview(messageLabel)
        messageLabel.snp.makeConstraints {
            $0.top.equalTo(containerView.snp.top).offset(10)
            $0.left.right.equalTo(containerView).inset(20)
        }
        
        containerView.addSubview(actionButton)
        actionButton.snp.makeConstraints {
            $0.top.equalTo(messageLabel.snp.bottom).offset(20)
            $0.left.right.equalTo(containerView).inset(0)
            $0.bottom.equalTo(containerView.snp.bottom).offset(-5)
            $0.height.equalTo(44)
        }
        
        topBorder.backgroundColor = #colorLiteral(red: 0.9372548461, green: 0.9372549057, blue: 0.9372549057, alpha: 1)
        containerView.addSubview(topBorder)
        
        topBorder.snp.makeConstraints {
            $0.top.equalTo(actionButton.snp.top)
            $0.left.right.equalTo(actionButton)
            $0.height.equalTo(1)
        }

        
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.boldSystemFont(ofSize: 16)
        messageLabel.numberOfLines = 0
        
        actionButton.backgroundColor = UIColor.white
        actionButton.setTitleColor(.black, for: .normal)
        actionButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
    }
    
    private func setupBackGroundTouch() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissAlert))
        backgroundView.isUserInteractionEnabled = true
        backgroundView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func dismissAlert() {
        self.removeFromSuperview()
    }
    
    func configure(message: String, actionButtonTitle: String) {
        messageLabel.text = message
        messageLabel.textColor = CustomAlertView.mainturquoise
        actionButton.setTitle(actionButtonTitle, for: .normal)
    }
    
    @objc private func actionButtonTapped() {
        onActionButotnTapped?()
    }
    
    func show(on view: UIView) {
        self.frame = view.bounds
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        self.alpha = 0
        
        view.addSubview(self)
        self.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        UIView.animate(withDuration: 0.3) {
            self.alpha = 1
        }
    }
    
    func dismiss() {
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 0
        }) { _ in
            self.removeFromSuperview()
        }
    }
}
