//
//  BaseView.swift
//  Na'nez
//
//  Created by 최지철 on 2023/08/22.
//

import UIKit

class BaseView: UIView {
    func layout() {}
    func configure() {}
    func addsubview() {}
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.backgroundColor = .white
        self.addsubview()
        self.configure()
        self.layout()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
