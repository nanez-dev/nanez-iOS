//
//  CustomHeaderView.swift
//  Na'nez
//
//  Created by 최지철 on 2023/12/07.
//

import Foundation
import UIKit

class HeaderView: UIView {
    private let titleLabel: UILabel = UILabel().then {
        $0.text = "고객센터"
        $0.font = .pretendard(.SemiBold, size: 20)
        $0.textAlignment = .center
    }

    init(frame: CGRect, title: String) {
        super.init(frame: frame)
        titleLabel.text = title
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalToSuperview()
        }
    }
}
