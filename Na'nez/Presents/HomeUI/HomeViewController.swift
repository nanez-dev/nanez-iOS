//
//  HomeViewController.swift
//  Na'nez
//
//  Created by 최지철 on 2023/07/13.
//

import UIKit
import SnapKit
import ImageSlideshow
import Then
import AlamofireImage
import Kingfisher
final class HomeViewController: UIViewController {
    private let BrandAPI = BrandService()
    private var Popularbrands:[Brand] = []
    private let AccordAPI = AccordService()
    private var Totalaccord:[Accord] = []
    private let PerfumeAPI = PerfumeService()
    private var TotalPerfume:[Perfume] = []
    private let homeview: HomeView = HomeView(frame: .zero)


    private func configure() {
        self.homeview.recommendCollectionView.delegate = self
        self.homeview.recommendCollectionView.dataSource = self
        self.homeview.Second_recommendCollectionView.delegate = self
        self.homeview.Second_recommendCollectionView.dataSource = self
        self.homeview.brandCollectionView.delegate = self
        self.homeview.brandCollectionView.dataSource = self
        self.homeview.accordCollectionView.delegate = self
        self.homeview.accordCollectionView.dataSource = self
        self.homeview.delegate = self
    }
    private func setUI() {
        homeview.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.bottom.leading.trailing.equalToSuperview()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(homeview)
        self.configure()
        self.setUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.BrandAPI.getPoularBrands { result in
            switch result {
            case .success(let brandList):
                self.Popularbrands = brandList.brands
                DispatchQueue.main.async {
                    self.homeview.brandCollectionView.reloadData()
                }
            case .failure(let error):
                print("/brand/popular:\(error)")
            }
        }
        self.AccordAPI.getAccord { result in
            switch result {
            case .success(let accordList):
                self.Totalaccord = accordList.accords
                self.homeview.accordCollectionView.reloadData()
                DispatchQueue.main.async {
                    self.homeview.accordCollectionView.reloadData()
                }
            case .failure(let error):
                print("/accord 오류:\(error)")
            }
        }
        self.PerfumeAPI.getAllPerfumes(offset: 0, limit: 11) { result in
            switch result {
            case .success(let perfumes):
                self.TotalPerfume = perfumes
                DispatchQueue.main.async {
                    self.homeview.recommendCollectionView.reloadData()
                    self.homeview.Second_recommendCollectionView.reloadData()
                }
            case .failure(let error):
                print("오류: \(error)")
            }
        }
    }
}
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == homeview.recommendCollectionView {
            return min(5, TotalPerfume.count)
        }
        else if collectionView == homeview.Second_recommendCollectionView{
            let startIndex = 5
            let endIndex = min(11, TotalPerfume.count)
            return max(0, endIndex - startIndex)
        }
        else if collectionView == homeview.brandCollectionView{
            return Popularbrands.count
        }
        else if collectionView == homeview.accordCollectionView{
            return Totalaccord.count
        }
        else{
            return 0
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == homeview.recommendCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeRecommendCollectionViewCell.identifier, for: indexPath) as! HomeRecommendCollectionViewCell
            let perfumeinfo = self.TotalPerfume[indexPath.item]
            cell.perfumeLabel.text = perfumeinfo.kor
            cell.descriptionLabel.text = perfumeinfo.title
            cell.brandLabel.text = perfumeinfo.brand?.kor
            cell.capacityLabel.text = String(perfumeinfo.capacity) + "ml"
            if let imageURL = URL(string: perfumeinfo.image ?? APIConstants.noImage) {
                cell.Img.af.setImage(withURL: imageURL)
            }
            return cell
        }
        else if collectionView == homeview.Second_recommendCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeRecommendCollectionViewCell.identifier, for: indexPath) as! HomeRecommendCollectionViewCell
            cell.descriptionLabel.isHidden = true
            let startIndex = 5
             let perfumeIndex = startIndex + indexPath.item
             if perfumeIndex < TotalPerfume.count {
                 let perfumeinfo = self.TotalPerfume[perfumeIndex]
                 cell.perfumeLabel.text = perfumeinfo.kor
                 cell.brandLabel.text = perfumeinfo.brand?.kor
                 cell.capacityLabel.text = String(perfumeinfo.capacity) + "ml"
     
                 if let imageURL = URL(string: perfumeinfo.image ?? APIConstants.noImage) {
                     cell.Img.kf.setImage(with:imageURL)
                 }
             }
            return cell
        }
        else if collectionView == homeview.brandCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BrandCollectionViewCell.identifier, for: indexPath) as! BrandCollectionViewCell
            let brandinfo = self.Popularbrands[indexPath.item]
            cell.brandLabel.text = brandinfo.kor
            if let imageURL = URL(string: brandinfo.image ?? APIConstants.noImage) {
                cell.Img.af.setImage(withURL: imageURL)
            }
            return cell
        }
        else if collectionView == homeview.accordCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AccordCollectionViewCell.identifier, for: indexPath) as! AccordCollectionViewCell
            let accordinfo = self.Totalaccord[indexPath.item]
            cell.accordLabel.text = accordinfo.kor
            if let imageURL = URL(string: accordinfo.image) {
                cell.Img.af.setImage(withURL: imageURL)
            }
            return cell
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeRecommendCollectionViewCell.identifier, for: indexPath) as! HomeRecommendCollectionViewCell
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == homeview.recommendCollectionView{
            print(self.TotalPerfume[indexPath.item].id!)
            self.PerfumeAPI.getPerfumeDetailInfo(id: self.TotalPerfume[indexPath.item].id!) { respnse in
                switch respnse{
                case .success(let result):
                    print(result)
                   let vc = DetailPerfumeViewController()
                    vc.PefumeInfo = result
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc,animated: false,completion: nil)
                case .failure(_):
                    print("향수상세정보 오류")
                }
            }

        }
        else if collectionView == homeview.Second_recommendCollectionView{
            self.PerfumeAPI.getPerfumeDetailInfo(id: self.TotalPerfume[indexPath.item + 5].id!) { respnse in
                switch respnse{
                case .success(let result):
                    print(result)
                   let vc = DetailPerfumeViewController()
                    vc.PefumeInfo = result
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc,animated: false,completion: nil)
                case .failure(_):
                    print("향수상세정보 오류")
                }
            }
        }
        else if collectionView == homeview.brandCollectionView {
            print(self.Popularbrands[indexPath.row].id)
            self.BrandAPI.getBrandDetail(brand_id:self.Popularbrands[indexPath.row].id, limit: 3) { resonse in
                switch resonse{
                case .success(let result):
                    let vc = DetailBrandViewController()
                    vc.brandinfo = result
                    vc.modalPresentationStyle = .fullScreen
                     self.present(vc,animated: false,completion: nil)
                case .failure(_):
                    print("상세브랜드정보 오류")
                }
            }

        }
        else if collectionView == homeview.accordCollectionView{
            
            let vc = DetailAccordViewController()
             vc.modalPresentationStyle = .fullScreen
             self.present(vc,animated: false,completion: nil)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == homeview.recommendCollectionView {
            let cellWidth :CGFloat = 200
            let cellHeight: CGFloat = 316 // 셀의 높이
            return CGSize(width: cellWidth, height: cellHeight)
        }
        else if collectionView == homeview.Second_recommendCollectionView {
            if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
                    let cellWidth: CGFloat = (collectionView.bounds.width - layout.minimumInteritemSpacing) / 2
                    let cellHeight: CGFloat = (collectionView.bounds.height - layout.minimumLineSpacing) / 3 // 셀의 높이
                    return CGSize(width: cellWidth, height: cellHeight)
                }
            return CGSize(width: 178, height: 253)
        }
        else if collectionView == homeview.brandCollectionView{
            if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
                    let cellWidth: CGFloat = (collectionView.bounds.width - layout.minimumInteritemSpacing) / 2
                let cellHeight: CGFloat = (collectionView.bounds.height - layout.minimumLineSpacing) / 4// 셀의 높이
                    return CGSize(width: cellWidth, height: cellHeight)
                }
            return CGSize(width: 0, height: 0)
        }
        else if collectionView == homeview.accordCollectionView{
            if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
                let cellWidth: CGFloat = (collectionView.bounds.width - layout.minimumInteritemSpacing) / 3.2
                    let cellHeight: CGFloat = (collectionView.bounds.height - layout.minimumLineSpacing) / 1
                    return CGSize(width: cellWidth, height: cellHeight)
                }
            return CGSize(width: 0, height: 0)
        }
        else
        {
            return CGSize(width: 0, height: 0)
        }
    }
}
extension HomeViewController: HomeVeiwDelegate {
    func allbrandBtnClick(_ homeView: HomeView) {
        let vc = BrandtubeViewController()
         vc.modalPresentationStyle = .fullScreen
         self.present(vc,animated: false,completion: nil)
    }
    func allaccordBtnClick(_ homeView: HomeView) {
        let vc = AccordtubeViewController()
         vc.modalPresentationStyle = .fullScreen
         self.present(vc,animated: false,completion: nil)
    }
}
