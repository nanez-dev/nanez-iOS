//
//  BannerView.swift
//  Na'nez
//
//  Created by 최지철 on 2023/10/12.
//

import UIKit

class BannerView: UIView{

    public var nowPage: Int = 0 {
        didSet {
            pageControl.currentPage = nowPage
        }
    }
    
    public let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.register(HomeRecommendCollectionViewCell.self, forCellWithReuseIdentifier: HomeRecommendCollectionViewCell.identifier)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        $0.collectionViewLayout = layout
        $0.decelerationRate = .fast
        $0.backgroundColor = .clear
        $0.contentInsetAdjustmentBehavior = .never
        $0.isPagingEnabled = true
        $0.showsHorizontalScrollIndicator = false
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    let pageControl = UIPageControl().then {
        $0.numberOfPages = 5
        $0.currentPage = 0
        let activeImage = UIImage(named: "activeDot")
        $0.pageIndicatorTintColor = UIColor(hexString: "##D9D9D9")
        $0.currentPageIndicatorTintColor = UIColor(hexString: "#424242")
        
        $0.setCurrentPageIndicatorImage(activeImage, forPage: 0)
        $0.setCurrentPageIndicatorImage(activeImage, forPage: 1)
        $0.setCurrentPageIndicatorImage(activeImage, forPage: 2)
        $0.setCurrentPageIndicatorImage(activeImage, forPage: 3)
        $0.setCurrentPageIndicatorImage(activeImage, forPage: 4)

    }
            

    private func layout() {
        
        self.collectionView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
            }
        self.pageControl.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.height.equalTo(50)
            }
        }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(collectionView)
        self.addSubview(pageControl)
        self.layout()
        self.backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

    }
    

}
