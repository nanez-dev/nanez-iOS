//
//  BrandPerfumeCollectionViewCell.swift
//  Na'nez
//
//  Created by 최지철 on 2023/11/23.
//

import UIKit

final class BrandPerfumeCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "BrandPerfumeCollectionViewCell"
    
    private let roundview = UIView().then{
           $0.layer.cornerRadius = 20
           $0.layer.masksToBounds = true
           $0.layer.borderWidth = 1
           $0.layer.borderColor = UIColor(rgb: 0xEFEFEF).cgColor
           $0.backgroundColor = .clear
    }
    private let perfumeImg = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.backgroundColor = .clear
    }
    private let PerfumeSV = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .leading
    }
    private let perfumeBrandLabel = UILabel().then{
        $0.text = "브랜드"
        $0.textColor = UIColor(hexString: "#666666")
        $0.numberOfLines = 0
        $0.sizeToFit()
        $0.font = .pretendard(.Regular, size: 14)
    }
    private let perfumeNameLabel = UILabel().then{
        $0.text = "향수명"
        $0.textColor = UIColor(hexString: "#333333")
        $0.numberOfLines = 0
        $0.sizeToFit()
        $0.font = .pretendard(.Regular, size: 14)
    }
    private let starImg = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.backgroundColor = .clear
        $0.image = UIImage(named: "Star")
    }
    private let starRatioLabel = UILabel().then{
        $0.text = "4.32(19)"
        $0.textColor = UIColor(rgb: 0x333333)
        $0.numberOfLines = 0
        $0.sizeToFit()
        $0.font = .pretendard(.Regular, size: 14)
    }
    private let perfumeDesLabel = UILabel().then{
        $0.text = "그리스 여름에 바다에 가기 위해 태양에 젖은 야생 무화과 나무가 연상되는 느낌을 가지고 있습니다. 여름 유향지의 향을 느껴보세요."
        $0.textColor = UIColor(rgb: 0x666666)
        $0.numberOfLines = 0
        $0.sizeToFit()
        $0.font = .pretendard(.Regular, size: 14)
    }
    private let priceLabel = UILabel().then{
        $0.text = "99,000원"
        $0.textColor = UIColor(hexString: "#333333")
        $0.numberOfLines = 0
        $0.sizeToFit()
        $0.font = .pretendard(.SemiBold, size: 18)
    }
    private let notDiscountLabel = UILabel().then{
        $0.text = "104,900원"
        $0.textColor = UIColor(hexString: "#666666")
        $0.numberOfLines = 0
        $0.sizeToFit()
        $0.font = .pretendard(.Regular, size: 14)
        $0.attributedText = $0.text?.strikeThrough()
    }
    
    private func addview() {
        self.addSubview(roundview)
        self.roundview.addSubview(perfumeImg)
        self.roundview.addSubview(PerfumeSV)
        self.PerfumeSV.addArrangedSubview(perfumeBrandLabel)
        self.PerfumeSV.addArrangedSubview(perfumeNameLabel)
        self.roundview.addSubview(priceLabel)
        self.roundview.addSubview(notDiscountLabel)
        self.roundview.addSubview(perfumeDesLabel)
        self.roundview.addSubview(starImg)
        self.roundview.addSubview(starRatioLabel)
    }
    
    private func layout() {
        self.roundview.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        self.perfumeImg.snp.makeConstraints {
            $0.top.equalToSuperview().offset(14)
            $0.leading.equalToSuperview().offset(16)
            $0.height.width.equalTo(100)
        }
        self.PerfumeSV.snp.makeConstraints {
            $0.top.equalToSuperview().offset(42)
            $0.leading.equalTo(perfumeImg.snp.trailing).offset(12)
        }
        self.starImg.snp.makeConstraints {
            $0.top.equalTo(PerfumeSV.snp.bottom).offset(8)
            $0.leading.equalTo(perfumeImg.snp.trailing).offset(12)
            $0.width.height.equalTo(16)
        }
        self.starRatioLabel.snp.makeConstraints {
            $0.top.equalTo(PerfumeSV.snp.bottom).offset(8)
            $0.leading.equalTo(starImg.snp.trailing)
        }
        self.perfumeDesLabel.snp.makeConstraints {
            $0.top.equalTo(starRatioLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
        self.priceLabel.snp.makeConstraints {
            $0.top.equalTo(perfumeDesLabel.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
        }
        self.notDiscountLabel.snp.makeConstraints {
            $0.top.equalTo(perfumeDesLabel.snp.bottom).offset(16)
            $0.leading.equalTo(priceLabel.snp.trailing)
        }
    }
    
    func configureCell(_ item: BrandPerfumeDTO) {
        if let imageURL = URL(string: item.image ?? APIConstants.noImage) {
            self.perfumeImg.kf.setImage(with: imageURL)
        }
        perfumeBrandLabel.text = item.brand.kor
        perfumeNameLabel.text = item.kor
        priceLabel.text = String(item.price).formatPriceWithWon()
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
