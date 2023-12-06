//
//  DetailAccordViewController.swift
//  Na'nez
//
//  Created by 최지철 on 2023/07/26.
//

import UIKit

class AccordtubeViewController: BaseViewController {
    
    let viewModle:AccordViewModel
    
    private let navibar: CustomNaviBar = CustomNaviBar(frame: .zero)
    private let AllaccordtitleLabel = UILabel().then{
        $0.text = "모든 어코드"
        $0.font = .pretendard(.Bold, size: 20)
        $0.textColor = UIColor(rgb: 0x333333)
    }
    private let AllaccordCollectionView =  UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then{
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 75, height: 84)
        $0.register(AllAccordCollectionViewCell.self, forCellWithReuseIdentifier: AllAccordCollectionViewCell.identifier)
        $0.collectionViewLayout = layout
        $0.decelerationRate = .fast
        $0.isScrollEnabled = false
        $0.backgroundColor = .clear
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = false
        layout.minimumInteritemSpacing = 0

    }
    private let RecommendaccordCollectionView =  UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then{
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 220, height: 140)
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        $0.register(PopularAccordCell.self, forCellWithReuseIdentifier: PopularAccordCell.identifier)
        $0.collectionViewLayout = layout
        $0.decelerationRate = .fast
        $0.isScrollEnabled = true
        $0.backgroundColor = .clear
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = false
        layout.minimumInteritemSpacing = 0
    }
    private let accordtitleLabel = UILabel().then{
        $0.text = "지금, 사랑받고 있는 어코드"
        $0.font = .pretendard(.Bold, size: 20)
        $0.textColor = UIColor(rgb: 0x333333)
    }
    private let contentView = UIView().then{
        $0.backgroundColor = .white
    }
    private let scrollView = UIScrollView()
    
    init(viewModle: AccordViewModel) {
        self.viewModle = viewModle
        viewModle.updateAllAccord()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func configure(){
        self.navibar.delegate = self
        self.navibar.navititleLabel.text = "어코드관"
        self.navibar.searchBtn.isHidden = true
        self.view.addSubview(navibar)
    }
    
    override func addview(){
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(contentView)
        self.contentView.addSubview(accordtitleLabel)
        self.contentView.addSubview(RecommendaccordCollectionView)
        self.contentView.addSubview(AllaccordCollectionView)
        self.contentView.addSubview(AllaccordtitleLabel)
    }
    
    override func layout() {
        self.navibar.snp.makeConstraints{
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.width.equalToSuperview().offset(0)
            $0.height.equalTo(52)
        }
        self.AllaccordCollectionView.snp.makeConstraints{
            $0.top.equalTo(AllaccordtitleLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(380)
        }
        self.AllaccordtitleLabel.snp.makeConstraints{
            $0.top.equalTo(RecommendaccordCollectionView.snp.bottom).offset(50)
            $0.leading.equalToSuperview().offset(16)
        }
        self.RecommendaccordCollectionView.snp.makeConstraints{
            $0.top.equalTo(accordtitleLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(150)

        }
        self.accordtitleLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(26)
            $0.leading.equalToSuperview().offset(16)
        }
        self.contentView.snp.makeConstraints{
            $0.width.equalToSuperview().offset(0)
            $0.edges.equalToSuperview().offset(0)
            $0.height.equalTo(820)
        }
        self.scrollView.snp.makeConstraints{
            $0.top.equalTo(self.navibar.snp.bottom)
            $0.left.right.bottom.equalToSuperview()
        }
    }
    
    override func binding() {
        viewModle.popular
            .bind(to: self.RecommendaccordCollectionView.rx.items(cellIdentifier: PopularAccordCell.identifier, cellType: PopularAccordCell.self))
        {   index, item, cell   in
            cell.configureCell(item)
        }
        .disposed(by: disposebag)
        
        viewModle.accords
            .bind(to: self.AllaccordCollectionView.rx.items(cellIdentifier: AllAccordCollectionViewCell.identifier, cellType: AllAccordCollectionViewCell.self))
        {   index, item, cell   in
            cell.configureCell(item)
        }
        .disposed(by: disposebag)
    }
}
extension AccordtubeViewController: CustomNaviBarDelegate {
    func backBtnClick(_ navibar: CustomNaviBar) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func searchBtnClick(_ navibar: CustomNaviBar) {
        
    }
}
