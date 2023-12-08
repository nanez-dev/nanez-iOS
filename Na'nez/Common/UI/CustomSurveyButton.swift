//
//  CustomSurveyButton.swift
//  Na'nez
//
//  Created by KIM Hyung Jun on 12/7/23.
//

import UIKit
import SnapKit
import Then

class CustomSurveyButton: UIButton {
    private let incenseImageView = UIImageView()
    private let incenseLabel = UILabel()
    
    override var isSelected: Bool {
        didSet {
            UIView.animate(withDuration: 0.3) {
                self.alpha = self.isSelected ? 1.0 : 0.5
            }
        }
    }
    
    init(imageName: String, title: String) {
        super.init(frame: .zero)
        setupViews(imageName: imageName, title: title)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews(imageName: String, title: String) {
        incenseImageView.then {
            $0.contentMode = .scaleAspectFit
            $0.image = UIImage(named: imageName)
        }
        
        incenseLabel.then {
            $0.textColor = .black
            $0.textAlignment = .center
            $0.font = UIFont.systemFont(ofSize: 11)
            $0.text = title
        }
        
        addSubview(incenseImageView)
        addSubview(incenseLabel)
        
        incenseImageView.snp.makeConstraints {
            $0.top.centerX.equalToSuperview()
            $0.size.equalTo(CGSize(width: 50, height: 50))
        }
        
        incenseLabel.snp.makeConstraints {
            $0.top.equalTo(incenseImageView.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }
    }
    
    private func commonInit() {
        self.alpha = 0.5
        self.addTarget(self, action: #selector(toggleButton), for: .touchUpInside)
    }
    
    @objc private func toggleButton() {
        self.isSelected.toggle()
    }
    
    func configure(imageName: String, title: String) {
        incenseImageView.image = UIImage(named: imageName)
        incenseLabel.text = title
    }
}
