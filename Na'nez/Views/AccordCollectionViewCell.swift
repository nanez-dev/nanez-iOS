//
//  AccordCollectionViewCell.swift
//  Na'nez
//
//  Created by 최지철 on 2023/07/15.
//

import UIKit

class AccordCollectionViewCell: UICollectionViewCell {
    static let identifier = "AccordCollectionViewCell"
    public var Img = UIImageView().then{
        $0.backgroundColor = .clear
        $0.contentMode = .scaleAspectFit
        $0.layer.masksToBounds = true
    }
    public let roundview = UIView().then{
           $0.layer.cornerRadius = 8
           $0.layer.masksToBounds = true
           $0.layer.borderWidth = 1
           $0.layer.borderColor = UIColor(rgb: 0xEFEFEF).cgColor
           $0.backgroundColor = .clear
       }
    public var accordLabel = UILabel().then{
        $0.text = "accord"
        $0.textColor = UIColor(rgb: 0x333333)
        $0.font = .pretendard(.SemiBold, size: 14)
    }
    public func layout(){
        self.Img.snp.makeConstraints{
            $0.top.bottom.equalToSuperview()
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().offset(-10)
        }
        self.roundview.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.height.equalTo(111)
            $0.width.equalToSuperview()
        }
        self.accordLabel.snp.makeConstraints{
            $0.top.equalTo(roundview.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(16)
        }
    }
    public func addSubview(){
        self.addSubview(roundview)
        self.addSubview(accordLabel)
        self.roundview.addSubview(Img)
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
