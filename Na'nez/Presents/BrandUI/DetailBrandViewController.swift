//
//  DetailBrandViewController.swift
//  Na'nez
//
//  Created by 최지철 on 2023/07/31.
//

import UIKit

class DetailBrandViewController: BaseViewController {
    
    private let viewModel: BrandViewModel
    
    private var navibar: CustomNaviBar = CustomNaviBar(frame: .zero)
    private let brandPerfumeCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.register(BrandPerfumeCollectionViewCell.self, forCellWithReuseIdentifier: BrandPerfumeCollectionViewCell.identifier)
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 335, height: 238)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        $0.collectionViewLayout = layout
        $0.decelerationRate = .fast
        $0.backgroundColor = .clear
        $0.showsHorizontalScrollIndicator = false
    }
    private var brandPerfume = UILabel().then{
        $0.text = "브랜드 대표 향수"
        $0.font = .pretendard(.Bold, size: 23)
        $0.textColor = UIColor(hexString:"#333333")
    }
    private var brandSubTitleLabel = UILabel().then{
        $0.textAlignment = .center
        $0.text = "시트러스는 호불호 없이 많은 이에게 사랑받는 어코드입니다. 가볍고 청량한 느낌이 있어 S/S 시즌에 손이 가는 향기입니다. 상큼한 시트러스 향수를 만나보세요."
        $0.font = .pretendard(.Regular, size: 16)
        $0.textColor = UIColor(rgb: 0x000000)
        $0.numberOfLines = 0
    }
    private var brandTiltleLabel = UILabel().then{
        $0.text = "상큼한 향수를 찾는다면?"
        $0.font = .pretendard(.Bold, size: 20)
        $0.textColor = UIColor(rgb: 0x333333)
    }
    private var brandImg = UIImageView().then{
        $0.backgroundColor = .clear
        $0.contentMode = .scaleAspectFit
        $0.layer.masksToBounds = true
        $0.image = UIImage(named: "Na'NezLogo")
    }
    private var brandbackgroundImgView = UIImageView().then{
        $0.backgroundColor = .clear
        $0.contentMode = .scaleAspectFit
        $0.layer.masksToBounds = true
        $0.layer.shadowOpacity = 0.4
        $0.layer.shadowRadius = 12
        $0.layer.shadowColor = UIColor(hexString: "#333333").cgColor
        $0.layer.shadowOffset = CGSize(width: 10, height: 10)
        $0.image = UIImage(named: "Na'NezLogo")
    }
    private let contentView = UIView().then{
        $0.backgroundColor = .white
    }
    private let scrollView = UIScrollView()
    
    init (_ viewModel:BrandViewModel,id: Int) {
        self.viewModel = viewModel
        self.viewModel.upadateBrandDetail(id: id, limit: 2)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func configure() {
        self.navibar.delegate = self
        self.navibar.searchBtn.isHidden = true
        self.view.addSubview(navibar)
    }
    
    override func addview() {
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(contentView)
        self.contentView.addSubview(brandImg)
        self.contentView.addSubview(brandbackgroundImgView)
        self.contentView.addSubview(brandSubTitleLabel)
        self.contentView.addSubview(brandTiltleLabel)
        self.contentView.addSubview(brandPerfume)
        self.contentView.addSubview(brandPerfumeCollectionView)
    }
    
    override func layout() {
        self.navibar.snp.makeConstraints{
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.width.equalToSuperview().offset(0)
            $0.height.equalTo(52)
        }
        self.brandPerfumeCollectionView.snp.makeConstraints{
            $0.top.equalTo(brandPerfume.snp.bottom).offset(20)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(580)
        }
        self.brandPerfume.snp.makeConstraints{
            $0.top.equalTo(brandSubTitleLabel.snp.bottom).offset(52)
            $0.centerX.equalToSuperview()
        }
        self.brandSubTitleLabel.snp.makeConstraints{
            $0.top.equalTo(brandTiltleLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
        self.brandTiltleLabel.snp.makeConstraints{
            $0.top.equalTo(brandImg.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
        }
        self.brandImg.snp.makeConstraints{
            $0.top.equalTo(brandbackgroundImgView.snp.bottom).offset(10)
            $0.width.equalTo(123)
            $0.height.equalTo(40)
            $0.centerX.equalToSuperview()
        }
        self.brandbackgroundImgView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(32)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(170)
        }
        self.contentView.snp.makeConstraints{
            $0.width.equalToSuperview().offset(0)
            $0.edges.equalToSuperview().offset(0)
            $0.height.equalTo(1000)
        }
        self.scrollView.snp.makeConstraints{
            $0.top.equalTo(self.navibar.snp.bottom).offset(0)
            $0.left.right.bottom.equalToSuperview()
        }
    }
    
    override func binding() {
        viewModel.detail
            .bind(onNext: { [weak self] info in
                if let imageURL = URL(string: info.image) {
                    self?.brandImg.kf.setImage(with: imageURL)
                }
                self?.brandTiltleLabel.text = info.detail?.top_title ?? "브랜드 타이틀"
                self?.brandSubTitleLabel.text = info.detail?.top_subtitle ?? "브랜드 서브타이틀"
                self?.brandPerfume.text = "\(info.kor) 대표향수"
            })
            .disposed(by: disposebag)
        
        viewModel.brandPerfumes
        .bind(to: self.brandPerfumeCollectionView.rx.items(cellIdentifier: BrandPerfumeCollectionViewCell.identifier, cellType: BrandPerfumeCollectionViewCell.self))
        {   index, item, cell   in
            cell.configureCell(item!)
        }
        .disposed(by: disposebag)
        
        
    }
}

extension DetailBrandViewController: CustomNaviBarDelegate {
    func backBtnClick(_ navibar: CustomNaviBar) {
        self.navigationController?.popViewController(animated: true)
    }
    func searchBtnClick(_ navibar: CustomNaviBar) {
        
    }
}


