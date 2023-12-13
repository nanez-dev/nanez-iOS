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
import RxCocoa
import RxSwift

final class HomeViewController: BaseViewController, UICollectionViewDelegate {
    
    // MARK: - Properties

    private let viewModel: HomeViewModel
    
    // MARK: - UI

    public let allaccordBtn = UIButton().then{
        $0.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        $0.semanticContentAttribute = .forceRightToLeft
        $0.setTitle("더보기 ", for: .normal)
        $0.backgroundColor = .clear
        $0.titleLabel?.font = .pretendard(.Regular, size: 14)
        $0.setTitleColor(UIColor(hexString: "#999999"), for: .normal)
        $0.tintColor = UIColor(hexString: "#999999")
        let config = UIImage.SymbolConfiguration(pointSize: 16)
        $0.setPreferredSymbolConfiguration(config, forImageIn: .normal)
    }
    public let allbrandBtn = UIButton().then{
        $0.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        $0.semanticContentAttribute = .forceRightToLeft
        $0.setTitle("더보기 ", for: .normal)
        $0.backgroundColor = .clear
        $0.titleLabel?.font = .pretendard(.Regular, size: 14)
        $0.setTitleColor(UIColor(hexString: "#999999"), for: .normal)
        $0.tintColor = UIColor(hexString: "#999999")
        let config = UIImage.SymbolConfiguration(pointSize: 16) // 이미지 크기를 20 포인트로 설정
        $0.setPreferredSymbolConfiguration(config, forImageIn: .normal)
    }
    public let accordCollectionView =  UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then{
        let layout = UICollectionViewFlowLayout()
        $0.register(AccordCollectionViewCell.self, forCellWithReuseIdentifier: AccordCollectionViewCell.identifier)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 8
        layout.itemSize = CGSize(width: 106, height: 134)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
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
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 28

        let numberOfColumns: CGFloat = 2.3

        let collectionViewWidth = UIScreen.main.bounds.width
        let cellWidth = (collectionViewWidth - (layout.minimumInteritemSpacing * (numberOfColumns - 1))) / numberOfColumns

        layout.itemSize = CGSize(width: cellWidth, height: 116)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
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
    private let Second_recommendCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 28

        let numberOfColumns: CGFloat = 2.3
        let numberOfRows: CGFloat = 3.2

        let collectionViewWidth = UIScreen.main.bounds.width
        let cellWidth = (collectionViewWidth - (layout.minimumInteritemSpacing * (numberOfColumns - 1))) / numberOfColumns

        layout.itemSize = CGSize(width: cellWidth, height: 216)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        $0.register(PerfumeCollectionViewCell.self, forCellWithReuseIdentifier: PerfumeCollectionViewCell.identifier)
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
        $0.register(PerfumeCollectionViewCell.self, forCellWithReuseIdentifier: PerfumeCollectionViewCell.identifier)
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: 200, height: 330)
        layout.sectionInsetReference = .fromContentInset
        layout.scrollDirection = .horizontal
        $0.collectionViewLayout = layout
        $0.decelerationRate = .fast
        $0.backgroundColor = .clear
        $0.showsHorizontalScrollIndicator = false
    }
    private let commentLabel = UILabel().then {
        $0.text = "a 나네?"
        $0.textColor = UIColor(rgb: 0x111111)
        $0.font = .pretendard(.Bold, size: 20)
    }
    private let subcommentLabel = UILabel().then{
        $0.text = "오늘 "
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
    public var bannerView = BannerView()
    private let searchBtn = UIButton().then{
        $0.setImage(UIImage(named: "Nan'Nez_Search"), for: .normal)
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
    
    // MARK: - Init

    init(_ viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - App Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.updateHomeInfo()
    }
    
    // MARK: - Private Methods

    
    override func configure() {
        viewModel.updateHomeInfo()
    }
    
    override func addview() {
        self.view.addSubview(navibar)
        self.navibar.addSubview(searchBtn)
        self.navibar.addSubview(logoImgView)
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(contentView)
        self.contentView.addSubview(commentSV)
        self.commentSV.addArrangedSubview(commentLabel)
        self.commentSV.addArrangedSubview(subcommentLabel)
        self.contentView.addSubview(bannerView)
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
    
    override func layout() {
        self.navibar.snp.makeConstraints{
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
        }
        self.searchBtn.snp.makeConstraints{
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
            $0.trailing.equalToSuperview().offset(-20)
            $0.top.equalTo(spacebarView3.snp.bottom).offset(32)
            $0.height.equalTo(20)
            $0.width.equalTo(53)
        }
        self.allbrandBtn.snp.makeConstraints{
            $0.trailing.equalToSuperview().offset(-20)
            $0.top.equalTo(spacebarView2.snp.bottom).offset(32)
            $0.height.equalTo(20)
            $0.width.equalTo(53)
        }
        self.accordCollectionView.snp.makeConstraints{
            $0.top.equalTo(LastcommentLabel.snp.bottom).offset(24)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
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
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(400)
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
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(720)
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
            $0.top.equalTo(bannerView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
        }
        self.bannerView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(0)
            $0.trailing.leading.equalToSuperview().offset(0)
            $0.height.equalTo(240)

        }
        
        self.scrollView.snp.makeConstraints{
            $0.top.equalTo(navibar.snp.bottom).offset(16)
            $0.left.right.bottom.equalToSuperview()
        }
        self.contentView.snp.makeConstraints{
            $0.width.equalToSuperview().offset(0)
            $0.edges.equalToSuperview().offset(0)
            $0.height.equalTo(2403)
        }
    }
    
    override func binding() {
        
        viewModel.homeInfo
            .bind(onNext: { [weak self] info in
                self?.commentLabel.text = info.top_rolling_banner.title
                self?.subcommentLabel.text = info.top_rolling_banner.subtitle
                self?.recomandLabel.text = info.special_perfumes.title
                self?.recommenLabel.text = info.recommend_perfumes.title
                self?.brandLabel.text = info.popular_brands.title
                self?.LastcommentLabel.text = info.recommend_accords.title
            })
            .disposed(by: disposebag)
        
        viewModel.bannerInfo
            .bind(to: self.bannerView.collectionView.rx.items(cellIdentifier: BannerCell.identifier ,
                                                              cellType: BannerCell.self))
        { index, item, cell in
            cell.configureCell(item)
        }
        .disposed(by: disposebag)
        
        viewModel.specialPerfumes
            .bind(to: self.recommendCollectionView.rx
                .items(cellIdentifier: PerfumeCollectionViewCell.identifier , cellType: PerfumeCollectionViewCell.self))
        { index, item, cell in
            cell.configureCell(item, true)
        }
            .disposed(by: disposebag)
        
        viewModel.recommendPerfumes
            .bind(to: self.Second_recommendCollectionView.rx.items(cellIdentifier: PerfumeCollectionViewCell.identifier ,cellType: PerfumeCollectionViewCell.self))
        {   index, item, cell in
            cell.configureCell(item, false)
        }
        .disposed(by: disposebag)
        
        viewModel.popularBrands
            .bind(to: self.brandCollectionView.rx.items(cellIdentifier: BrandCollectionViewCell.identifier, cellType: BrandCollectionViewCell.self))
        {   index, item, cell in
            cell.configureCell(item)
        }
        .disposed(by: disposebag)
        
        viewModel.recommendAccords
            .bind(to: self.accordCollectionView.rx.items(cellIdentifier: AccordCollectionViewCell.identifier, cellType: AccordCollectionViewCell.self))
        {   index, item, cell in
            cell.configureCell(item)
        }
        .disposed(by: disposebag)
        
        recommendCollectionView.rx.modelSelected(PerfumeDTO.self)
            .bind(onNext: { [weak self] cell in
                self?.pushPerfumeDetail(id: cell.id)
            })
            .disposed(by: disposebag)
        
        Second_recommendCollectionView.rx.modelSelected(PerfumeDTO.self)
            .bind(onNext: { [weak self] cell in
                self?.pushPerfumeDetail(id: cell.id)
            })
            .disposed(by: disposebag)
        
        brandCollectionView.rx.modelSelected(BrandDTO.self)
            .bind(onNext: {
                [weak self] cell in
                    self?.pushBrandDetail(id: cell.id)
            })
            .disposed(by: disposebag)

        allbrandBtn.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                self?.pushAllBrand()
            })
            .disposed(by: disposebag)
        
        accordCollectionView.rx.modelSelected(AccordDTO.self)
            .bind(onNext: { [weak self] cell in
                self?.pushAccordDetail(id: cell.id)
            })
            .disposed(by: disposebag)
        
        allaccordBtn.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                self?.pushAllAccord()
            })
            .disposed(by: disposebag)
    }
}
extension HomeViewController {
    private func pushPerfumeDetail(id: Int) {
        let usecase = DetailPerfumeUseCase(repository: DetailPerfumeRepository(detailPerfumeService: PerfumeService()))
        let vc = DetailPerfumeViewController(DetailPerfumeViewModel(usecase: usecase, id: id))
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    private func pushBrandDetail(id:Int) {
        let vc = DetailBrandViewController(BrandViewModel(usecase: BrandUseCase(BrandRepository(BrandService()))),id: id)
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    private func pushAllBrand() {
        let vc = BrandtubeViewController(BrandViewModel(usecase: BrandUseCase(BrandRepository(BrandService()))))
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    private func pushAllAccord() {
        let vc = AccordtubeViewController(viewModle: AccordViewModel(usecase: AccordUseCase(AccordRepository(AccordService()))))
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    private func pushAccordDetail(id:Int) {
        let usecase = AccordViewModel(usecase: AccordUseCase(AccordRepository(AccordService())))
        let vc = DetailAccordViewController(viewModel:usecase, id: id )
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
