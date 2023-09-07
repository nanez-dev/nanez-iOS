//
//  AccordtubeView.swift
//  Na'nez
//
//  Created by 최지철 on 2023/09/07.
//

import UIKit

class AccordtubeView: BaseView {
    private let AllaccordtitleLabel = UILabel().then{
        $0.text = "모든 어코드"
        $0.font = .pretendard(.Bold, size: 20)
        $0.textColor = UIColor(rgb: 0x333333)
    }
    public let AllaccordCollectionView =  UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then{
        let layout = UICollectionViewFlowLayout()
        $0.register(AccordCollectionViewCell.self, forCellWithReuseIdentifier: AccordCollectionViewCell.identifier)
        $0.collectionViewLayout = layout
        $0.decelerationRate = .fast
        $0.isScrollEnabled = false
        $0.backgroundColor = .clear
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = false
        layout.minimumInteritemSpacing = 0

    }
    public let RecommendaccordCollectionView =  UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then{
        let layout = UICollectionViewFlowLayout()
        $0.register(AccordCollectionViewCell.self, forCellWithReuseIdentifier: AccordCollectionViewCell.identifier)
        $0.collectionViewLayout = layout
        $0.decelerationRate = .fast
        $0.isScrollEnabled = false
        $0.backgroundColor = .clear
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = false
        layout.minimumInteritemSpacing = 0
    }
    private let accordtitleLabel = UILabel().then{
        $0.text = "지금 계절에 어울리는 어코드"
        $0.font = .pretendard(.Bold, size: 20)
        $0.textColor = UIColor(rgb: 0x333333)
    }
    private let contentView = UIView().then{
        $0.backgroundColor = .white
    }
    private let scrollView = UIScrollView()

    override func addsubview(){
        self.addSubview(scrollView)
        self.scrollView.addSubview(contentView)
        self.contentView.addSubview(accordtitleLabel)
        self.contentView.addSubview(RecommendaccordCollectionView)
        self.contentView.addSubview(AllaccordCollectionView)
        self.contentView.addSubview(AllaccordtitleLabel)
    }
    override func layout(){
        self.AllaccordCollectionView.snp.makeConstraints{
            $0.top.equalTo(AllaccordtitleLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(600)
        }
        self.AllaccordtitleLabel.snp.makeConstraints{
            $0.top.equalTo(RecommendaccordCollectionView.snp.bottom).offset(50)
            $0.leading.equalToSuperview().offset(16)
        }
        self.RecommendaccordCollectionView.snp.makeConstraints{
            $0.top.equalTo(accordtitleLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(150)

        }
        self.accordtitleLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(26)
            $0.leading.equalToSuperview().offset(16)
        }
        self.contentView.snp.makeConstraints{
            $0.width.equalToSuperview().offset(0)
            $0.edges.equalToSuperview().offset(0)
            $0.height.equalTo(920)
        }
        self.scrollView.snp.makeConstraints{
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(0)
            $0.left.right.bottom.equalToSuperview()
        }
    }
}
