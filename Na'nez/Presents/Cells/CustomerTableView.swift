//
//  CustomerTabelView.swift
//  Na'nez
//
//  Created by 최지철 on 2023/12/07.
//

import UIKit

class CustomerTabelView: UITableViewCell {
    static let identifier = "CustomerTabelView"
    
    private let label = UILabel().then {
        $0.text = ""
        $0.textColor = .black
        $0.font = .pretendard(.Regular, size: 16)
        $0.sizeToFit()
    }
    
    private func layout() {
        self.label.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
        }
    }
    
    func configureCell(_ item: BeforeCustomerTable) {
        label.text = item.text
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(label)
        self.layout()

    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
