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

class HomeViewController: UIViewController {
    private let BrandAPI = BrandService()
    private var Popularbrands:[Brand] = []
    private let AccordAPI = AccordService()
    private var Totalaccord:[Accord] = []
    
    private let accordCollectionView =  UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then{
        let layout = UICollectionViewFlowLayout()
        $0.register(AccordCollectionViewCell.self, forCellWithReuseIdentifier: AccordCollectionViewCell.identifier)
        $0.collectionViewLayout = layout
        $0.decelerationRate = .fast
        $0.isScrollEnabled = false
        $0.backgroundColor = .clear
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = false
    }
    private let LastcommentLabel = UILabel().then{
        $0.text = "파릇한 5월에 어울리는 어코드"
        $0.font = .pretendard(.Bold, size: 20)
        $0.textColor = UIColor(rgb: 0x333333)
    }
    private let spacebarView3 = UIView().then{
        $0.backgroundColor = .gragray
    }
    private let brandCollectionView =  UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then{
        let layout = UICollectionViewFlowLayout()
        $0.register(BrandCollectionViewCell.self, forCellWithReuseIdentifier: BrandCollectionViewCell.identifier)
        $0.collectionViewLayout = layout
        $0.decelerationRate = .fast
        $0.isScrollEnabled = false
        $0.backgroundColor = .clear
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = false
    }
    private let brandLabel = UILabel().then{
        $0.text = "지금, 사랑받고 있는 브랜드"
        $0.font = .pretendard(.Bold, size: 20)
        $0.textColor = UIColor(rgb: 0x333333)
    }
    private let Second_recommendCollectionView =  UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then{
        let layout = UICollectionViewFlowLayout()
        $0.register(HomeRecommendCollectionViewCell.self, forCellWithReuseIdentifier: HomeRecommendCollectionViewCell.identifier)
        $0.collectionViewLayout = layout
        $0.decelerationRate = .fast
        $0.isScrollEnabled = false
        $0.backgroundColor = .clear
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = false
    }
    private let recommenLabel = UILabel().then{
        $0.text = "이런 향수는 어떠세요?"
        $0.font = .pretendard(.Bold, size: 20)
        $0.textColor = UIColor(rgb: 0x333333)
    }
    private let spacebarView2 = UIView().then{
        $0.backgroundColor = .gragray
    }
    private let spacebarView = UIView().then{
        $0.backgroundColor = .gragray
    }
    private let recommendCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.register(HomeRecommendCollectionViewCell.self, forCellWithReuseIdentifier: HomeRecommendCollectionViewCell.identifier)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        $0.collectionViewLayout = layout
        $0.decelerationRate = .fast
        $0.backgroundColor = .clear
        $0.showsHorizontalScrollIndicator = false
    }
    private let commentLabel = UILabel().then {
        $0.text = "어디서 좋은 향이 나네?"
        $0.textColor = UIColor(rgb: 0x111111)
        $0.font = .pretendard(.Bold, size: 20)
    }
    private let subcommentLabel = UILabel().then{
        $0.text = "오늘 나에게 맞는 향수를 찾아라!"
        $0.font = .pretendard(.Light, size: 16)
        $0.textColor = UIColor(rgb: 0x333333)

    }
    private let recomandLabel = UILabel().then{
        $0.text = "비 올 때, 향수로 더 산뜻하게!"
        $0.font = .pretendard(.Bold, size: 20)
        $0.textColor = UIColor(rgb: 0x333333)
    }
    private let commentSV = UIStackView().then{
        $0.spacing = 4
        $0.axis = .vertical
        $0.distribution = .fill
    }
    private let bannerSlide = ImageSlideshow().then{
        $0.contentScaleMode = .scaleAspectFill
        $0.slideshowInterval = 3
        $0.setImageInputs([
            ImageSource(image: UIImage(named: "bannerAD1")!),
            ImageSource(image: UIImage(named: "bannerAD2")!),
            ImageSource(image: UIImage(named: "bannerAD3")!),
            ImageSource(image: UIImage(named: "bannerAD4")!),
            ImageSource(image: UIImage(named: "bannerAD5")!)
        ])
    }
    private let searchbar = UISearchBar().then{
        $0.searchTextField.borderStyle = .none
        $0.searchTextField.layer.borderColor = UIColor.white.cgColor
        $0.searchBarStyle = .minimal
        $0.placeholder = "지금 나에게 맞는 향수를 찾아보세요"
        if let searchIconView = $0.searchTextField.leftView as? UIImageView {
             searchIconView.tintColor = .black
         }
    }
    private let writeBtn = UIButton().then{
        $0.setImage(UIImage(named: "pencil"), for: .normal)
        $0.imageView?.contentMode = .scaleAspectFit
    }
    private let customNaviBar = UIView().then{
        $0.backgroundColor = .white
    }
    private let logoImgView = UIImageView().then{
        $0.contentMode = .scaleAspectFit
        $0.layer.masksToBounds = true
        $0.image = UIImage(named: "FontLogo")
    }
    private let contentView = UIView().then{
    $0.backgroundColor = .white
    }
    private let scrollView = UIScrollView()
    
    private func layout(){
        self.accordCollectionView.snp.makeConstraints{
            $0.top.equalTo(LastcommentLabel.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-22)
            $0.height.equalTo(137)
        }
        self.LastcommentLabel.snp.makeConstraints{
            $0.top.equalTo(spacebarView3.snp.bottom).offset(32)
            $0.leading.equalToSuperview().offset(16)
            $0.height.equalTo(25)
        }
        self.spacebarView3.snp.makeConstraints{
            $0.top.equalTo(brandCollectionView.snp.bottom).offset(35)
            $0.leading.equalToSuperview().offset(0)
            $0.trailing.equalToSuperview().offset(0)
            $0.height.equalTo(8)
        }
        self.brandCollectionView.snp.makeConstraints{
            $0.top.equalTo(brandLabel.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-22)
            $0.height.equalTo(670)
        }
        self.brandLabel.snp.makeConstraints{
            $0.top.equalTo(spacebarView2.snp.bottom).offset(32)
            $0.leading.equalToSuperview().offset(16)
            $0.height.equalTo(25)
        }
        self.spacebarView2.snp.makeConstraints{
            $0.top.equalTo(Second_recommendCollectionView.snp.bottom).offset(35)
            $0.leading.equalToSuperview().offset(0)
            $0.trailing.equalToSuperview().offset(0)
            $0.height.equalTo(8)
        }
        self.Second_recommendCollectionView.snp.makeConstraints{
            $0.top.equalTo(recommenLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-22)
            $0.height.equalTo(815)
        }
        self.recommenLabel.snp.makeConstraints{
            $0.top.equalTo(spacebarView.snp.bottom).offset(32)
            $0.leading.equalToSuperview().offset(16)
            $0.height.equalTo(25)
        }
        self.spacebarView.snp.makeConstraints{
            $0.top.equalTo(recommendCollectionView.snp.bottom).offset(32)
            $0.leading.equalToSuperview().offset(0)
            $0.trailing.equalToSuperview().offset(0)
            $0.height.equalTo(8)

        }
        self.recommendCollectionView.snp.makeConstraints{
            $0.top.equalTo(recomandLabel.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().offset(-10)
            $0.height.equalTo(330)

        }
        self.recomandLabel.snp.makeConstraints{
            $0.top.equalTo(commentSV.snp.bottom).offset(52)
            $0.leading.equalToSuperview().offset(16)
            $0.height.equalTo(25)
        }
        self.commentSV.snp.makeConstraints{
            $0.top.equalTo(bannerSlide.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
        }
        self.bannerSlide.snp.makeConstraints{
            $0.top.equalTo(searchbar.snp.bottom).offset(16)
            $0.trailing.equalToSuperview().offset(0)
            $0.leading.equalToSuperview().offset(0)
            $0.height.equalTo(240)

        }
        self.searchbar.snp.makeConstraints{
            $0.top.equalTo(customNaviBar.snp.bottom).offset(16)
            $0.trailing.equalToSuperview().offset(-22)
            $0.leading.equalToSuperview().offset(22)
            $0.height.equalTo(52)
        }
        self.writeBtn.snp.makeConstraints{
            $0.top.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-22)
            $0.bottom.equalToSuperview().offset(-9.63)

        }
        self.logoImgView.snp.makeConstraints{
            $0.width.equalTo(86)
            $0.height.equalTo(28)
            $0.centerX.equalTo(customNaviBar)
            $0.centerY.equalTo(customNaviBar)
            
        }
        self.contentView.snp.makeConstraints{
            $0.width.equalToSuperview().offset(0)
            $0.edges.equalToSuperview().offset(0)
            $0.height.equalTo(3059)
        }
        self.scrollView.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.left.right.bottom.equalToSuperview()
        }
        self.customNaviBar.snp.makeConstraints{
            $0.top.equalToSuperview().offset(0)
            $0.width.equalToSuperview().offset(0)
            $0.height.equalTo(52)
        }
    }
    private func addSubview(){
        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        self.contentView.addSubview(customNaviBar)
        self.customNaviBar.addSubview(logoImgView)
        self.customNaviBar.addSubview(writeBtn)
        self.contentView.addSubview(searchbar)
        self.contentView.addSubview(bannerSlide)
        self.contentView.addSubview(commentSV)
        self.commentSV.addArrangedSubview(commentLabel)
        self.commentSV.addArrangedSubview(subcommentLabel)
        self.contentView.addSubview(recomandLabel)
        self.contentView.addSubview(recommendCollectionView)
        self.contentView.addSubview(spacebarView)
        self.contentView.addSubview(recommenLabel)
        self.contentView.addSubview(Second_recommendCollectionView)
        self.contentView.addSubview(spacebarView2)
        self.contentView.addSubview(brandLabel)
        self.contentView.addSubview(brandCollectionView)
        self.contentView.addSubview(spacebarView3)
        self.contentView.addSubview(LastcommentLabel)
        self.contentView.addSubview(accordCollectionView)


    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.addSubview()
        self.layout()
        self.recommendCollectionView.delegate = self
        self.recommendCollectionView.dataSource = self
        self.Second_recommendCollectionView.delegate = self
        self.Second_recommendCollectionView.dataSource = self
        self.brandCollectionView.delegate = self
        self.brandCollectionView.dataSource = self
        self.accordCollectionView.delegate = self
        self.accordCollectionView.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        self.BrandAPI.getPoularBrands { result in
            switch result {
            case .success(let brandList):
                self.Popularbrands = brandList.brands
                self.brandCollectionView.reloadData()
            case .failure(let error):
                print("/brand/popular 오류:\(error)")
            }
        }
        self.AccordAPI.getAccord { result in
            switch result {
            case .success(let accordList):
                self.Totalaccord = accordList.accords
                self.accordCollectionView.reloadData()
            case .failure(let error):
                print("/accord 오류:\(error)")
            }
        }
    }
}
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == recommendCollectionView {
            return 5
        }
        else if collectionView == Second_recommendCollectionView{
            return 6
        }
        else if collectionView == brandCollectionView{
            return Popularbrands.count
        }
        else if collectionView == accordCollectionView{
            return Totalaccord.count
        }
        else{
            return 0
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == recommendCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeRecommendCollectionViewCell.identifier, for: indexPath) as! HomeRecommendCollectionViewCell
            return cell
        }
        else if collectionView == Second_recommendCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeRecommendCollectionViewCell.identifier, for: indexPath) as! HomeRecommendCollectionViewCell
            cell.descriptionLabel.isHidden = true
            return cell
        }
        else if collectionView == brandCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BrandCollectionViewCell.identifier, for: indexPath) as! BrandCollectionViewCell
            let brandinfo = self.Popularbrands[indexPath.item]
            cell.brandLabel.text = brandinfo.kor
            if let imageURL = URL(string: brandinfo.image) {
                cell.Img.af.setImage(withURL: imageURL)
            }
            return cell
        }
        else if collectionView == accordCollectionView {
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
 
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == recommendCollectionView {
            let cellWidth :CGFloat = 200
            let cellHeight: CGFloat = 316 // 셀의 높이
            return CGSize(width: cellWidth, height: cellHeight)
        }
        else if collectionView == Second_recommendCollectionView {
            if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
                    let cellWidth: CGFloat = (collectionView.bounds.width - layout.minimumInteritemSpacing) / 2
                    let cellHeight: CGFloat = (collectionView.bounds.height - layout.minimumLineSpacing) / 3 // 셀의 높이
                    return CGSize(width: cellWidth, height: cellHeight)
                }
            return CGSize(width: 178, height: 253)
        }
        else if collectionView == brandCollectionView{
            if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
                    let cellWidth: CGFloat = (collectionView.bounds.width - layout.minimumInteritemSpacing) / 2
                let cellHeight: CGFloat = (collectionView.bounds.height - layout.minimumLineSpacing) / 4// 셀의 높이
                    return CGSize(width: cellWidth, height: cellHeight)
                }
            return CGSize(width: 0, height: 0)
        }
        else if collectionView == accordCollectionView{
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
