//
//  CustomAlertTwoAnswerView.swift
//  Na'nez
//
//  Created by KIM Hyung Jun on 2/20/24.
//

import UIKit
import SnapKit
import Then
import SwiftUI

class CustomAlertTwoAnswerView: UIView {
    
    class var mainturquoise: UIColor { UIColor(named: "mainturquoise") ?? UIColor() }
    
    private let backgroundView = UIView()
    private let messageLabel = UILabel()
    private let subMessageLabel = UILabel()
    private let cancelButton = UIButton()
    private let actionButton = UIButton()
    private let topBorder = UIView()
    private let middleBorder = UIView()
    
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
            $0.width.equalTo(300)
            $0.height.equalTo(200)
        }
        
        containerView.addSubview(messageLabel)
        messageLabel.snp.makeConstraints {
            $0.top.equalTo(containerView.snp.top).offset(50)
            $0.left.right.equalTo(containerView).inset(20)
        }
        
        containerView.addSubview(subMessageLabel)
        subMessageLabel.snp.makeConstraints {
            $0.top.equalTo(messageLabel.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(230)
        }
        
        let buttonStackView = UIStackView(arrangedSubviews: [cancelButton, actionButton])
        buttonStackView.axis = .horizontal
        buttonStackView.distribution = .fillEqually
        buttonStackView.spacing = 10

        containerView.addSubview(buttonStackView)
        buttonStackView.snp.makeConstraints {
            $0.left.right.equalTo(containerView).inset(20)
            $0.bottom.equalTo(containerView.snp.bottom).offset(-10)
            $0.height.equalTo(44)
        }
        
        topBorder.backgroundColor = #colorLiteral(red: 0.9372548461, green: 0.9372549057, blue: 0.9372549057, alpha: 1)
        containerView.addSubview(topBorder)
        
        topBorder.snp.makeConstraints {
            $0.top.equalTo(buttonStackView.snp.top)
            $0.left.right.equalTo(containerView).inset(20)
            $0.height.equalTo(1)
        }
        
        middleBorder.backgroundColor = #colorLiteral(red: 0.9372548461, green: 0.9372549057, blue: 0.9372549057, alpha: 1)
        containerView.addSubview(middleBorder)
        
        middleBorder.snp.makeConstraints {
            $0.centerX.equalTo(containerView)
            $0.top.equalTo(buttonStackView)
            $0.bottom.equalTo(buttonStackView)
            $0.width.equalTo(1)
        }
        
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.boldSystemFont(ofSize: 16)
        messageLabel.numberOfLines = 0
        
        subMessageLabel.textAlignment = .center
        subMessageLabel.textColor = UIColor(hexString: "999999")
        subMessageLabel.font = UIFont.systemFont(ofSize: 14)
        subMessageLabel.numberOfLines = 0
        subMessageLabel.isHidden = true
        
        cancelButton.backgroundColor = UIColor.white
        cancelButton.setTitleColor(.mainturquoise, for: .normal)
        cancelButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        
        actionButton.backgroundColor = UIColor.white
        actionButton.setTitleColor(.black, for: .normal)
        actionButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
    }
    
    func configure(message: String, subMessage: String?=nil, actionButtonTitle: String, cancelButtonTitle: String) {
        messageLabel.text = message
        messageLabel.textColor = CustomAlertTwoAnswerView.mainturquoise
        actionButton.setTitle(actionButtonTitle, for: .normal)
        cancelButton.setTitle(cancelButtonTitle, for: .normal)
        
        if let subMessage = subMessage, !subMessage.isEmpty {
            subMessageLabel.text = subMessage
            subMessageLabel.isHidden = false
        }
        else {
            subMessageLabel.isHidden = true
        }
    }
    
    private func setupBackGroundTouch() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissAlert))
        backgroundView.isUserInteractionEnabled = true
        backgroundView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func dismissAlert() {
        self.removeFromSuperview()
    }

    @objc private func cancelButtonTapped() {
        dismissAlert()
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

