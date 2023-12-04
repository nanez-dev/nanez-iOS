//
//  PopularBrandCollectionViewCell.swift
//  Na'nez
//
//  Created by 최지철 on 2023/11/22.
//

import UIKit
import SnapKit

class PopularAccordCell: UICollectionViewCell {
    static let identifier = "PopularAccordCell"
    
    private let eng = UILabel().then {
        $0.text = "asd"
        $0.textColor = UIColor(rgb: 0x333333)
        $0.font = .pretendard(.Regular, size: 11)
    }
    
    private let kor = UILabel().then {
        $0.text = "asd"
        $0.textColor = UIColor(rgb: 0x333333)
        $0.font = .pretendard(.SemiBold, size: 16)
    }
    
    private let infoSV = UIStackView().then {
        $0.axis = .vertical
    }
    
    private let img = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }

    private let desLabel = UILabel().then {
        $0.text = "asd"
        $0.textColor = UIColor(rgb: 0x333333)
        $0.font = .pretendard(.Regular, size: 14)
        $0.numberOfLines = 0
    }
    
    private func configure() {
        self.backgroundColor = UIColor(hexString: "#FDFCF9")
        self.layer.cornerRadius = 20
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(hexString: "##F6F4EC").cgColor
    }
    
    private func addView() {
        self.addSubview(desLabel)
        self.addSubview(img)
        self.addSubview(infoSV)
        self.infoSV.addArrangedSubview(kor)
        self.infoSV.addArrangedSubview(eng)
    }
    
    private func layout() {
        
        self.infoSV.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalTo(img.snp.trailing).offset(8)
        }
        
        self.img.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(16)
            $0.width.height.equalTo(40)
        }
        
        self.desLabel.snp.makeConstraints {
            $0.top.equalTo(img.snp.bottom).offset(8)
            $0.bottom.equalToSuperview().inset(16)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
    }
    
    func configureCell(_ item: PopularAccord) {
        self.desLabel.text = item.desc
        self.kor.text = item.kor
        self.eng.text = item.eng
        if let imageURL = URL(string: item.image) {
            self.img.kf.setImage(with: imageURL)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.configure()
        self.addView()
        self.layout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
