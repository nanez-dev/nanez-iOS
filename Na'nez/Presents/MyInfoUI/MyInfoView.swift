//
//  MyInfoView.swift
//  Na'nez
//
//  Created by 최지철 on 2023/10/13.
//

import UIKit

class MyInfoView: BaseView {
    private let scrollview = UIScrollView().then {
        $0.backgroundColor = .red
    }
    
    private let contentSV = UIStackView().then {
        $0.spacing = 0
        $0.axis = .vertical
        $0.distribution = .fill
        $0.alignment = .center
    }
    private let loginyetView = UIView().then{
        $0.backgroundColor = .blue
    }
    override func addview() {
        self.addSubview(scrollview)
        self.scrollview.addSubview(contentSV)
        self.contentSV.addArrangedSubview(loginyetView)
    }
    
    override func layout() {
        self.scrollview.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
        self.contentSV.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
        self.loginyetView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(242)
        }
    }
    
    override func configure() {
        
    }

}
