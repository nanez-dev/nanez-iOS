//
//  BannerView.swift
//  Na'nez
//
//  Created by 최지철 on 2023/10/12.
//

import UIKit

class BannerView: UIView, UIScrollViewDelegate, UICollectionViewDelegate{
    
    public let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.register(BannerCell.self, forCellWithReuseIdentifier: BannerCell.identifier)
         let layout = UICollectionViewFlowLayout()
         let cellWidth = UIScreen.main.bounds.width
         let cellHeight = CGFloat(240)
         
         layout.scrollDirection = .horizontal
         layout.minimumInteritemSpacing = 0
         layout.minimumLineSpacing = 0
         layout.itemSize = .init(width: cellWidth, height: cellHeight)
         layout.sectionInsetReference = .fromContentInset
         layout.sectionInset = .zero
         
         $0.collectionViewLayout = layout
         $0.decelerationRate = .fast
         $0.backgroundColor = .clear
         $0.contentInsetAdjustmentBehavior = .never
         $0.isPagingEnabled = true
         $0.showsHorizontalScrollIndicator = false
         $0.translatesAutoresizingMaskIntoConstraints = false
    }
    let pageControl = CustomPageControlView(numberOfPages: 4)


    private func layout() {
        
        self.collectionView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
            }
        self.pageControl.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(8)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(20)
            }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(collectionView)
        self.addSubview(pageControl)
        self.layout()
        self.backgroundColor = .white
        self.collectionView.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 현재 보이는 셀의 인덱스를 가져옵니다.
        let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        
        if let indexPath = collectionView.indexPathForItem(at: visiblePoint) {
            let currentIndex = indexPath.item
            
          pageControl.setCurrentPage(currentIndex)
        }
    }
}
