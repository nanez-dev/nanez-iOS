//
//  DetailBrandView.swift
//  Na'nez
//
//  Created by 최지철 on 2023/10/03.
//

import UIKit

class DetailBrandView: BaseView {
    public let brandPerfumeCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.register(PerfumeCollectionViewCell.self, forCellWithReuseIdentifier: PerfumeCollectionViewCell.identifier)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        $0.collectionViewLayout = layout
        $0.decelerationRate = .fast
        $0.backgroundColor = .clear
        $0.showsHorizontalScrollIndicator = false
    }
    private var brandPerfume = UILabel().then{
        $0.text = "브랜드 대표 향수"
        $0.font = .pretendard(.Bold, size: 23)
        $0.textColor = UIColor(hexString:"#333333")
    }
    public var brandSubTitleLabel = UILabel().then{
        $0.text = "시트러스는 호불호 없이 많은 이에게 사랑받는 어코드입니다. 가볍고 청량한 느낌이 있어 S/S 시즌에 손이 가는 향기입니다. 상큼한 시트러스 향수를 만나보세요."
        $0.font = .pretendard(.Regular, size: 16)
        $0.textColor = UIColor(rgb: 0x000000)
        $0.numberOfLines = 0
    }
    public var brandTiltleLabel = UILabel().then{
        $0.text = "상큼한 향수를 찾는다면?"
        $0.font = .pretendard(.Bold, size: 20)
        $0.textColor = UIColor(rgb: 0x333333)
    }
    public var brandAniImg = UIImageView().then{
        $0.backgroundColor = .clear
        $0.contentMode = .scaleAspectFit
        $0.layer.masksToBounds = true
        $0.image = UIImage(named: "Na'NezLogo")
    }
    public var brandImgView = UIImageView().then{
        $0.backgroundColor = .clear
        $0.contentMode = .scaleAspectFit
        $0.layer.masksToBounds = true
        $0.image = UIImage(named: "Na'NezLogo")

    }
    private let contentView = UIView().then{
        $0.backgroundColor = .white
    }
    private let scrollView = UIScrollView()
    override func layout(){
        self.brandPerfumeCollectionView.snp.makeConstraints{
            $0.top.equalTo(brandPerfume.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(280)
        }
        self.brandPerfume.snp.makeConstraints{
            $0.top.equalTo(brandSubTitleLabel.snp.bottom).offset(52)
            $0.leading.equalToSuperview().offset(16)
        }
        self.brandSubTitleLabel.snp.makeConstraints{
            $0.top.equalTo(brandTiltleLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)

        }
        self.brandTiltleLabel.snp.makeConstraints{
            $0.top.equalTo(brandAniImg.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(16)
        }
        self.brandAniImg.snp.makeConstraints{
            $0.top.equalTo(brandImgView.snp.bottom).offset(24)
            $0.width.equalTo(123)
            $0.height.equalTo(60)
            $0.leading.equalToSuperview().offset(16)
        }
        self.brandImgView.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(72)
        }
        self.contentView.snp.makeConstraints{
            $0.width.equalToSuperview().offset(0)
            $0.edges.equalToSuperview().offset(0)
            $0.height.equalTo(740)
        }
        self.scrollView.snp.makeConstraints{
            $0.top.equalTo(self.snp.top).offset(0)
            $0.left.right.bottom.equalToSuperview()
        }
    }
    override func addview(){
        self.addSubview(scrollView)
        self.scrollView.addSubview(contentView)
        self.contentView.addSubview(brandAniImg)
        self.contentView.addSubview(brandImgView)
        self.contentView.addSubview(brandSubTitleLabel)
        self.contentView.addSubview(brandTiltleLabel)
        self.contentView.addSubview(brandPerfume)
        self.contentView.addSubview(brandPerfumeCollectionView)
    }
}
