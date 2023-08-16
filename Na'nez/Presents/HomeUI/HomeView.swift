//
//  HomeView.swift
//  Na'nez
//
//  Created by 최지철 on 2023/08/13.
//

import UIKit
import ImageSlideshow
@objc
protocol HomeVeiwDelegate: AnyObject {
    func allbrandBtnClick(_ homeView: HomeView)
    func allaccordBtnClick(_ homeView: HomeView)
}
class HomeView: UIView {
    
    weak var delegate: HomeVeiwDelegate?

    public let allaccordBtn = UIButton().then{
        $0.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        $0.semanticContentAttribute = .forceRightToLeft
        $0.setTitle("모든 어코드보기 ", for: .normal)
        $0.backgroundColor = .clear
        $0.titleLabel?.font = .pretendard(.Regular, size: 12)
        $0.setTitleColor(UIColor(hexString: "#333333"), for: .normal)
        $0.tintColor = UIColor(hexString: "#333333")
        let underlineText = "모든 어코드보기"
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        let underlineAttributedString = NSAttributedString(string: underlineText, attributes: underlineAttribute)
        $0.setAttributedTitle(underlineAttributedString, for: .normal)
    }
    public let allbrandBtn = UIButton().then{
        $0.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        $0.semanticContentAttribute = .forceRightToLeft
        $0.setTitle("모든 브랜드보기 ", for: .normal)
        $0.backgroundColor = .clear
        $0.titleLabel?.font = .pretendard(.Regular, size: 12)
        $0.setTitleColor(UIColor(hexString: "#333333"), for: .normal)
        $0.tintColor = UIColor(hexString: "#333333")
        let underlineText = "모든 브랜드보기"
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        let underlineAttributedString = NSAttributedString(string: underlineText, attributes: underlineAttribute)
        $0.setAttributedTitle(underlineAttributedString, for: .normal)
    }
    public let accordCollectionView =  UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then{
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
    private let brandLabel = UILabel().then{
        $0.text = "지금, 사랑받고 있는 브랜드"
        $0.font = .pretendard(.Bold, size: 20)
        $0.textColor = UIColor(rgb: 0x333333)
        $0.backgroundColor = .clear
    }
    public let Second_recommendCollectionView =  UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then{
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
    public let recommendCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
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
    public var bannerSlide = ImageSlideshow().then{
        $0.contentScaleMode = .scaleAspectFill
        $0.slideshowInterval = 3
    }
    private let writeBtn = UIButton().then{
        $0.setImage(UIImage(named: "pencil"), for: .normal)
        $0.imageView?.contentMode = .scaleAspectFit
    }
    private let logoImgView = UIImageView().then{
        $0.contentMode = .scaleAspectFit
        $0.layer.masksToBounds = true
        $0.image = UIImage(named: "FontLogo")
    }
    private let navibar = UIView().then{
        $0.backgroundColor = .white
    }
    private let contentView = UIView().then{
        $0.backgroundColor = .white
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
    
    private let scrollView = UIScrollView()

    private func addsubview() {
        self.addSubview(navibar)
        self.navibar.addSubview(writeBtn)
        self.navibar.addSubview(logoImgView)
        self.addSubview(searchbar)
        self.addSubview(scrollView)
        self.scrollView.addSubview(contentView)
        self.contentView.addSubview(commentSV)
        self.contentView.addSubview(bannerSlide)
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
        self.contentView.addSubview(allbrandBtn)
        self.contentView.addSubview(allaccordBtn)
    }
    
    private func layout() {
        self.navibar.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
        self.writeBtn.snp.makeConstraints{
            $0.top.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-22)
            $0.bottom.equalToSuperview().offset(-9.63)
        }
        self.logoImgView.snp.makeConstraints{
            $0.width.equalTo(86)
            $0.height.equalTo(28)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        self.allaccordBtn.snp.makeConstraints{
            $0.trailing.equalToSuperview().offset(-15)
            $0.top.equalTo(spacebarView3.snp.bottom).offset(32)
            $0.height.equalTo(25)
            $0.width.equalTo(100)
        }
        self.allbrandBtn.snp.makeConstraints{
            $0.trailing.equalToSuperview().offset(-15)
            $0.top.equalTo(spacebarView2.snp.bottom).offset(32)
            $0.height.equalTo(25)
            $0.width.equalTo(100)
        }
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
            $0.top.equalToSuperview().offset(0)
            $0.trailing.equalToSuperview().offset(0)
            $0.leading.equalToSuperview().offset(0)
            $0.height.equalTo(240)

        }
        self.searchbar.snp.makeConstraints{
            $0.top.equalTo(navibar.snp.bottom).offset(16)
            $0.trailing.equalToSuperview().offset(-22)
            $0.leading.equalToSuperview().offset(22)
            $0.height.equalTo(52)
        }
        
        self.scrollView.snp.makeConstraints{
            $0.top.equalTo(searchbar.snp.bottom).offset(0)
            $0.left.right.bottom.equalToSuperview()
        }
        self.contentView.snp.makeConstraints{
            $0.width.equalToSuperview().offset(0)
            $0.edges.equalToSuperview().offset(0)
            $0.height.equalTo(2780)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.addsubview()
        self.layout()
        self.allbrandBtn.addTarget(self, action: #selector(allbrandBtnClick), for: .touchUpInside)
        self.allaccordBtn.addTarget(self, action: #selector(allaccordBtnClick), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
extension HomeView {
    @objc func allbrandBtnClick() {
        delegate?.allbrandBtnClick(self)
    }
    @objc func allaccordBtnClick() {
        delegate?.allaccordBtnClick(self)
    }
}


