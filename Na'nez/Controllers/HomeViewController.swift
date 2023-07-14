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
class HomeViewController: UIViewController {
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
    private let collectionviewaddView = UIView().then{
        $0.backgroundColor = .red
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
    private func addsubView(){
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

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.addsubView()
        self.layout()
        self.recommendCollectionView.delegate = self
        self.recommendCollectionView.dataSource = self
    }
}
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeRecommendCollectionViewCell.identifier, for: indexPath) as! HomeRecommendCollectionViewCell
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth :CGFloat = 200
        let cellHeight: CGFloat = 316 // 셀의 높이

        return CGSize(width: cellWidth, height: cellHeight)
    }
    

}
