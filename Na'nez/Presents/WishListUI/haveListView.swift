//
//  HaveListView.swift
//  Na'nez
//
//  Created by 최지철 on 2023/10/13.
//

import UIKit

class HaveListView: BaseView {
    private let NoListSV = UIStackView().then {
        $0.spacing = 16
        $0.axis = .vertical
        $0.distribution = .fill
        $0.alignment = .center
    }
    private let noListImg = UIImageView().then {
        $0.backgroundColor = .clear
        $0.contentMode = .scaleAspectFit
        $0.layer.masksToBounds = true
        $0.image = UIImage(named: "noImg")
    }
    private let noListLabel = UILabel().then {
        $0.text = "아직 보유한 향수가 없어요."
        $0.font = .pretendard(.Regular, size: 16)
        $0.textColor = UIColor(hexString: "#999999")
    }
    override func layout() {
       
        self.NoListSV.snp.makeConstraints {
            $0.centerY.centerX.equalToSuperview()
        }

    }
    override func addview() {
        self.addSubview(NoListSV)
        self.NoListSV.addArrangedSubview(noListImg)
        self.NoListSV.addArrangedSubview(noListLabel)
    }
 
}
