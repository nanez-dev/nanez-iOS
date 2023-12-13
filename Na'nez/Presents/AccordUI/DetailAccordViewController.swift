//
//  DetailAccordViewController.swift
//  Na'nez
//
//  Created by 최지철 on 2023/07/30.
//

import UIKit

class DetailAccordViewController: BaseViewController {
    private let navibar:CustomNaviBar = CustomNaviBar(frame: .zero)
    private let viewModel:AccordViewModel
    private let accordPerfumeCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.register(BrandPerfumeCollectionViewCell.self, forCellWithReuseIdentifier: BrandPerfumeCollectionViewCell.identifier)
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 335, height: 238)
        $0.isScrollEnabled = false
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        $0.collectionViewLayout = layout
        $0.decelerationRate = .fast
        $0.backgroundColor = .clear
        $0.showsHorizontalScrollIndicator = false
    }
    private let accordPerfume = UILabel().then{
        $0.text = "어코드 대표 향수"
        $0.font = .pretendard(.Bold, size: 23)
        $0.textColor = UIColor(hexString:"#333333")
    }
    private let accordInfoLabel = UILabel().then{
        $0.textAlignment = .center
        $0.text = "시트러스는 호불호 없이 많은 이에게 사랑받는 어코드입니다. 가볍고 청량한 느낌이 있어 S/S 시즌에 손이 가는 향기입니다. 상큼한 시트러스 향수를 만나보세요."
        $0.font = .pretendard(.Regular, size: 16)
        $0.textColor = UIColor(rgb: 0x000000)
        $0.numberOfLines = 0
    }
    private let accordDesLabel = UILabel().then{
        $0.text = "상큼한 향수를 찾는다면?"
        $0.font = .pretendard(.Bold, size: 20)
        $0.textColor = UIColor(rgb: 0x333333)
    }
    private var accordAniImg = UIImageView().then{
        $0.backgroundColor = .clear
        $0.contentMode = .scaleAspectFit
        $0.layer.masksToBounds = true
        $0.image = UIImage(named: "Na'NezLogo")
    }
    private var accordImgView = UIImageView().then{
        $0.backgroundColor = .clear
        $0.contentMode = .scaleAspectFit
        $0.layer.masksToBounds = true
        $0.image = UIImage(named: "Na'NezLogo")
        
    }
    private let contentView = UIView().then{
        $0.backgroundColor = .white
    }
    private let scrollView = UIScrollView()
    
    init(viewModel: AccordViewModel, id:Int) {
        self.viewModel = viewModel
        self.viewModel.upadateAccordDetail(id: id)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configure(){
        self.view.backgroundColor = .white
        self.view.addSubview(navibar)
        self.navibar.navititleLabel.text = "어코드"
        self.navibar.searchBtn.isHidden = true
        self.navibar.delegate = self
    }
    
    override func addview(){
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(contentView)
        self.contentView.addSubview(accordAniImg)
        self.contentView.addSubview(accordImgView)
        self.contentView.addSubview(accordDesLabel)
        self.contentView.addSubview(accordInfoLabel)
        self.contentView.addSubview(accordPerfume)
        self.contentView.addSubview(accordPerfumeCollectionView)
        
    }
    
    override func layout() {
        navibar.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(0)
            $0.width.equalToSuperview().offset(0)
            $0.height.equalTo(52)
        }
        self.accordPerfumeCollectionView.snp.makeConstraints{
            $0.top.equalTo(accordPerfume.snp.bottom).offset(20)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(730)
        }
        self.accordPerfume.snp.makeConstraints{
            $0.top.equalTo(accordInfoLabel.snp.bottom).offset(52)
            $0.centerX.equalToSuperview()
        }
        self.accordInfoLabel.snp.makeConstraints{
            $0.top.equalTo(accordDesLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
        self.accordDesLabel.snp.makeConstraints{
            $0.top.equalTo(accordImgView.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
        }
        self.accordImgView.snp.makeConstraints{
            $0.top.equalTo(accordAniImg.snp.bottom).offset(10)
            $0.width.equalTo(123)
            $0.height.equalTo(40)
            $0.centerX.equalToSuperview()
        }
        self.accordAniImg.snp.makeConstraints{
            $0.top.equalToSuperview().offset(32)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(170)
        }
        self.contentView.snp.makeConstraints{
            $0.width.equalToSuperview().offset(0)
            $0.edges.equalToSuperview().offset(0)
            $0.height.equalTo(1200)
        }
        self.scrollView.snp.makeConstraints{
            $0.top.equalTo(self.navibar.snp.bottom).offset(0)
            $0.left.right.bottom.equalToSuperview()
        }
    }
    
    override func binding() {
        viewModel.detail
            .bind(onNext: {  info in
                if let imageURL = URL(string:  info.accord.image) {
                    self.accordImgView.kf.setImage(with: imageURL)
                }
                self.accordDesLabel.text = info.accord.kor
            })
            .disposed(by: disposebag)
        
        viewModel.accordPerfume
            .bind(to: self.accordPerfumeCollectionView.rx.items(cellIdentifier: BrandPerfumeCollectionViewCell.identifier
                                                                ,cellType: BrandPerfumeCollectionViewCell.self))
        {  index, item ,cell  in
            cell.configureCell(item)
        }
        .disposed(by: disposebag)
    }
    
}
extension DetailAccordViewController: CustomNaviBarDelegate{
    func backBtnClick(_ navibar: CustomNaviBar) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func searchBtnClick(_ navibar: CustomNaviBar) {
        
    }
    
    
}
