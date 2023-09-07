//
//  DetailAccordViewController.swift
//  Na'nez
//
//  Created by 최지철 on 2023/07/26.
//

import UIKit

class AccordtubeViewController: BaseViewController {
    private var Totalaccord:[Accord] = []
    private var popularAccord:[Accord] = []
    private let api = AccordService()
    private let accordtubeView: AccordtubeView = AccordtubeView(frame: .zero)
    private let navibar: CustomNaviBar = CustomNaviBar(frame: .zero)
    
    override func configure(){
        self.accordtubeView.RecommendaccordCollectionView.dataSource = self
        self.accordtubeView.RecommendaccordCollectionView.delegate = self
        self.accordtubeView.AllaccordCollectionView.dataSource = self
        self.accordtubeView.AllaccordCollectionView.delegate = self
        self.navibar.delegate = self
        self.navibar.navititleLabel.text = "어코드관"
        self.navibar.searchBtn.isHidden = true
        self.view.addSubview(accordtubeView)
        self.view.addSubview(navibar)
    }
    override func layout() {
        self.navibar.snp.makeConstraints{
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.width.equalToSuperview().offset(0)
            $0.height.equalTo(52)
        }
        self.accordtubeView.snp.makeConstraints{
            $0.top.equalTo(navibar.snp.bottom)
            $0.leading.bottom.trailing.equalToSuperview()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        self.api.getAccord { response in
            switch response {
            case .success(let accordList):
                self.Totalaccord = accordList.accords
                DispatchQueue.main.async {
                    self.accordtubeView.AllaccordCollectionView.reloadData()
                    self.accordtubeView.RecommendaccordCollectionView.reloadData()
                }
            case .failure(_):
                break
            }
        }
    }
}
extension AccordtubeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == accordtubeView.RecommendaccordCollectionView {
            return min(5, Totalaccord.count)
    }
        else{
            return Totalaccord.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AccordCollectionViewCell.identifier, for: indexPath) as! AccordCollectionViewCell
        cell.roundview.layer.borderWidth = 0
 
            let accordinfo = Totalaccord[indexPath.row]
            cell.accordLabel.text = accordinfo.kor
            if let imageURL = URL(string: accordinfo.image) {
                cell.Img.kf.setImage(with: imageURL)

        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == accordtubeView.RecommendaccordCollectionView{
            if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
                let cellWidth: CGFloat = (collectionView.bounds.width - layout.minimumInteritemSpacing) / 5.2
                let cellHeight: CGFloat = (collectionView.bounds.height - layout.minimumLineSpacing) / 2
                    return CGSize(width: cellWidth, height: cellHeight)
                }
            return CGSize(width: 0, height: 0)
        }else{
            if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
                let cellWidth: CGFloat = (collectionView.bounds.width - layout.minimumInteritemSpacing) / 5
                let cellHeight: CGFloat = (collectionView.bounds.height - layout.minimumLineSpacing) / 4.2
                    return CGSize(width: cellWidth, height: cellHeight)
                }
            return CGSize(width: 0, height: 0)
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailAccordViewController()
         vc.modalPresentationStyle = .fullScreen
         self.present(vc,animated: false,completion: nil)
    }
}
extension AccordtubeViewController: CustomNaviBarDelegate {
    func backBtnClick(_ navibar: CustomNaviBar) {
        self.dismiss(animated: false)
    }
    
    func searchBtnClick(_ navibar: CustomNaviBar) {
        
    }
}
