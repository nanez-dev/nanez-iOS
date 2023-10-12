//
//  BannerCell.swift
//  Na'nez
//
//  Created by 최지철 on 2023/10/12.
//

import UIKit

class BannerCell: UICollectionViewCell {
    static let identifier = "BannerCell"
    
    public var BannerImg = UIImageView().then {
        $0.backgroundColor = .clear
        $0.contentMode = .scaleAspectFit
        $0.layer.masksToBounds = true
    }
    
    private func layout() {
        self.BannerImg.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    private func addview() {
        self.addSubview(BannerImg)
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.addview()
        self.layout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
