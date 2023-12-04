//
//  BrandCollectionViewCell.swift
//  Na'nez
//
//  Created by 최지철 on 2023/07/15.
//

import UIKit

class BrandCollectionViewCell: UICollectionViewCell {
    static let identifier = "BrandCollectionViewCell"
    
    private var Img = UIImageView().then{
        $0.backgroundColor = .clear
        $0.contentMode = .scaleAspectFit
        $0.layer.masksToBounds = true
    }
    private let roundview = UIView().then{
           $0.layer.cornerRadius = 12
           $0.layer.masksToBounds = true
           $0.layer.borderWidth = 1
           $0.layer.borderColor = UIColor(rgb: 0xEFEFEF).cgColor
           $0.backgroundColor = .clear
       }
    private var brandLabel = UILabel().then{
        $0.text = "Brand"
        $0.textColor = UIColor(rgb: 0x111111)
        $0.font = .pretendard(.Regular, size: 14)

    }
    private func layout(){
        self.Img.snp.makeConstraints{
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        self.roundview.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.height.equalTo(88)
            $0.width.equalToSuperview()
        }
        self.brandLabel.snp.makeConstraints{
            $0.top.equalTo(roundview.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(16)
        }

       }
    private func addSubview(){
        self.addSubview(roundview)
        self.addSubview(brandLabel)
        self.roundview.addSubview(Img)
      }
    
    func configureCell(_ item: BrandDTO) {
        if let imageURL = URL(string: item.image ?? APIConstants.noImage) {
            self.Img.kf.setImage(with: imageURL)
        }
        self.brandLabel.text = item.kor
    }
       
       override init(frame: CGRect) {
           super.init(frame: .zero)
           
           self.addSubview()
           self.layout()
       }
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
}
