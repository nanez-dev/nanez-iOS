//
//  BrandtubeView.swift
//  Na'nez
//
//  Created by 최지철 on 2023/10/08.
//

import UIKit

class BrandtubeView: BaseView {
    
    private let scrollView = UIScrollView()
    public let brandCollectionView2 =  UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then{
        let layout = UICollectionViewFlowLayout()
        $0.register(BrandCollectionViewCell.self, forCellWithReuseIdentifier: BrandCollectionViewCell.identifier)
        $0.collectionViewLayout = layout
        $0.decelerationRate = .fast
        $0.isScrollEnabled = false
        $0.backgroundColor = .clear
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = false
    }
    public let brandCollectionView =  UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then{
        let layout = UICollectionViewFlowLayout()
        $0.register(BrandCollectionViewCell.self, forCellWithReuseIdentifier: BrandCollectionViewCell.identifier)
        $0.collectionViewLayout = layout
        $0.decelerationRate = .fast
        $0.isScrollEnabled = false
        $0.backgroundColor = .clear
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = false
    }
    public let brandLabel2 = UILabel().then{
        $0.text = "모든 브랜드"
        $0.font = .pretendard(.Bold, size: 20)
        $0.textColor = UIColor(rgb: 0x333333)
        $0.backgroundColor = .clear
    }
    public let brandLabel = UILabel().then{
        $0.text = "지금, 사랑받고 있는 브랜드"
        $0.font = .pretendard(.Bold, size: 20)
        $0.textColor = UIColor(rgb: 0x333333)
        $0.backgroundColor = .clear
    }
    private let contentView = UIView().then{
        $0.backgroundColor = .white
    }
    
    
    override func layout(){
        self.brandCollectionView2.snp.makeConstraints{
            $0.top.equalTo(brandLabel2.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().offset(-24)
            $0.bottom.equalToSuperview().offset(-20)
        }
        self.brandLabel2.snp.makeConstraints{
            $0.top.equalTo(brandCollectionView.snp.bottom).offset(26)
            $0.leading.equalToSuperview().offset(24)
            
        }
        self.brandCollectionView.snp.makeConstraints{
            $0.top.equalTo(brandLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().offset(-24)
            $0.height.equalTo(280)
        }
        self.brandLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(26)
            $0.leading.equalToSuperview().offset(24)
        }
        self.contentView.snp.makeConstraints{
            $0.width.equalToSuperview().offset(0)
            $0.edges.equalToSuperview().offset(0)
            $0.height.equalTo(3500)
        }
        self.scrollView.snp.makeConstraints{
            $0.top.equalTo(self.snp.top).offset(0)
            $0.left.right.bottom.equalToSuperview()
        }
    }
    
     override func addview(){
        self.addSubview(scrollView)
        self.scrollView.addSubview(contentView)
        self.contentView.addSubview(brandCollectionView2)
        self.contentView.addSubview(brandLabel2)
        self.contentView.addSubview(brandLabel)
        self.contentView.addSubview(brandCollectionView)
    }
    override func configure(){
        self.backgroundColor = .white
    }
}
