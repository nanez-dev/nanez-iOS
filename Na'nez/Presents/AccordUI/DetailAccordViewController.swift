//
//  DetailAccordViewController.swift
//  Na'nez
//
//  Created by 최지철 on 2023/07/30.
//

import UIKit

class DetailAccordViewController: BaseViewController {
    private let detailaccordView:DetailAccordView = DetailAccordView(frame: .zero)
    private let navibar:CustomNaviBar = CustomNaviBar(frame: .zero)
    
    override func layout() {
        navibar.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(0)
            $0.width.equalToSuperview().offset(0)
            $0.height.equalTo(52)
        }
        detailaccordView.snp.makeConstraints {
            $0.top.equalTo(navibar.snp.bottom)
            $0.bottom.leading.trailing.equalToSuperview()
        }
    }
    override func configure(){
        self.view.backgroundColor = .white
        self.view.addSubview(navibar)
        self.view.addSubview(detailaccordView)
        self.navibar.navititleLabel.text = "어코드"
        self.navibar.searchBtn.isHidden = true
        self.navibar.delegate = self
        self.detailaccordView.accordPerfumeCollectionView.delegate = self
        self.detailaccordView.accordPerfumeCollectionView.dataSource = self
    }
}
extension DetailAccordViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeRecommendCollectionViewCell.identifier, for: indexPath) as! HomeRecommendCollectionViewCell
        cell.capacityLabel.isHidden = true
        cell.descriptionLabel.isHidden = true
        cell.brandLabel.font = .pretendard(.Regular, size: 12)
        cell.perfumeLabel.font = .pretendard(.Regular, size: 16)

        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            let cellWidth: CGFloat = (collectionView.bounds.width - layout.minimumInteritemSpacing) / 3.1
            let cellHeight: CGFloat = (collectionView.bounds.height - layout.minimumLineSpacing) / 1
                return CGSize(width: cellWidth, height: cellHeight)
            }
        return CGSize(width: 0, height: 0)

    }
}
extension DetailAccordViewController: CustomNaviBarDelegate{
    func backBtnClick(_ navibar: CustomNaviBar) {
        self.dismiss(animated: false)
    }
    
    func searchBtnClick(_ navibar: CustomNaviBar) {
        
    }
    
    
}
