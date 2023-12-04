//
//  AllAccordCollectionViewCell.swift
//  Na'nez
//
//  Created by 최지철 on 2023/11/24.
//

import UIKit

class AllAccordCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "AllAccordCollectionViewCell"
    
    private var Img = UIImageView().then{
        $0.backgroundColor = .clear
        $0.contentMode = .scaleAspectFit
        $0.layer.masksToBounds = true
    }
    private var accordLabel = UILabel().then{
        $0.text = "accord"
        $0.textColor = UIColor(rgb: 0x333333)
        $0.font = .pretendard(.SemiBold, size: 14)
        $0.sizeToFit()
    }
    private func layout(){
        self.Img.snp.makeConstraints{
            $0.top.equalToSuperview().offset(8)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(48)
        }
        self.accordLabel.snp.makeConstraints{
            $0.top.equalTo(Img.snp.bottom).offset(4)
            $0.centerX.equalToSuperview()
        }
    }
    
    private func addSubview(){
        self.addSubview(accordLabel)
        self.addSubview(Img)
      }
    
    func configureCell(_ item: AccordDTO) {
        if let imageURL = URL(string: item.image) {
            self.Img.kf.setImage(with: imageURL)
        }
        self.accordLabel.text = item.kor
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
