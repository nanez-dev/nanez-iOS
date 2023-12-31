//
//  PerfumeCollectionViewCell.swift
//  Na'nez
//
//  Created by 최지철 on 2023/07/14.
//

import UIKit
import SnapKit
import Then

class PerfumeCollectionViewCell: UICollectionViewCell {
    static let identifier = "PerfumeCollectionViewCell"
    
    private let Img = UIImageView().then{
        $0.backgroundColor = .clear
        $0.contentMode = .scaleAspectFit
        $0.layer.masksToBounds = true
    }
    private let roundview = UIView().then{
           $0.layer.cornerRadius = 20
           $0.layer.masksToBounds = true
           $0.layer.borderWidth = 1
           $0.layer.borderColor = UIColor(rgb: 0xEFEFEF).cgColor
           $0.backgroundColor = .clear
       }
    private var brandLabel = UILabel().then{
        $0.text = "Brand"
        $0.textColor = UIColor(rgb: 0x666666)
        $0.font = .pretendard(.Light, size: 14)
    }
    private var perfumeLabel = UILabel().then{
        $0.text = "장폴고티에 르말"
        $0.textColor = UIColor(rgb: 0x111111)
        $0.font = .pretendard(.Bold, size: 16)
        $0.numberOfLines = 0
        $0.sizeToFit()
    }
    private var capacityLabel = UILabel().then{
        $0.text = "100ml"
        $0.textColor = UIColor(rgb: 0x111111)
        $0.font = .pretendard(.Light, size: 14)
    }
    private var descriptionLabel = UILabel().then{
        $0.text = "화이트 프리지아 부케향에 이제 막 익은 배의 신선함을 입히고 호박, 파출..."
        $0.textColor = UIColor(rgb: 0x424242)
        $0.font = .pretendard(.Regular, size: 14)
        $0.numberOfLines = 2
    }
    private let infoSV = UIStackView().then{
        $0.spacing = 4
        $0.axis = .vertical
        $0.distribution = .fill
    }
    private func layout(){
        self.Img.snp.makeConstraints{
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        self.infoSV.snp.makeConstraints{
                $0.top.equalTo(roundview.snp.bottom).offset(8)
                $0.leading.trailing.equalToSuperview().offset(0)
               }
        self.descriptionLabel.snp.makeConstraints{
                   $0.top.equalTo(infoSV.snp.bottom).offset(12)
                   $0.leading.trailing.equalToSuperview().offset(0)
                   $0.height.equalTo(42)
               }
       }
    private func addSubview(){
            self.addSubview(roundview)
            self.addSubview(infoSV)
            self.infoSV.addArrangedSubview(brandLabel)
            self.infoSV.addArrangedSubview(perfumeLabel)
            self.infoSV.addArrangedSubview(capacityLabel)
            self.addSubview(descriptionLabel)
            self.roundview.addSubview(Img)
      }
    
    func configureCell(_ item: PerfumeDTO, _ subTitle: Bool) {
        if let imageURL = URL(string: item.image) {
            self.Img.kf.setImage(with: imageURL)
        }
        if subTitle != true {
            self.descriptionLabel.isHidden = true
            self.roundview.snp.makeConstraints{
                $0.top.equalToSuperview()
                $0.height.equalTo(164)
                $0.width.equalToSuperview()
            }
            self.capacityLabel.isHidden = true
        }
        else{
            self.roundview.snp.makeConstraints{
                $0.top.equalToSuperview()
                $0.height.equalTo(186)
                $0.width.equalToSuperview()
            }
            self.descriptionLabel.text = item.subtitle
            self.capacityLabel.text = String(item.capacity) + "ml"
        }
        self.brandLabel.text = item.brand.kor
        self.perfumeLabel.text = item.kor
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
