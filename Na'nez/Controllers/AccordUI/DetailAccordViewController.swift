//
//  DetailAccordViewController.swift
//  Na'nez
//
//  Created by 최지철 on 2023/07/30.
//

import UIKit

class DetailAccordViewController: UIViewController {
    private let accordPerfumeCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.register(HomeRecommendCollectionViewCell.self, forCellWithReuseIdentifier: HomeRecommendCollectionViewCell.identifier)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
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
    private let navititleLabel = UILabel().then{
        $0.text = "어코드"
        $0.font = .pretendard(.Bold, size: 18)
        $0.textColor = UIColor(rgb: 0x333333)
    }
    private let backBtn = UIButton().then{
        $0.setImage(UIImage(named: "Nan'Nez_Back"), for: .normal)
        $0.imageView?.contentMode = .scaleAspectFit
        $0.tintColor = UIColor(rgb: 0x333333)
    }
    private let customNaviBar = UIView().then{
        $0.backgroundColor = .white
    }
    private let contentView = UIView().then{
        $0.backgroundColor = .white
    }
    private let scrollView = UIScrollView()
    private func layout(){
        self.accordPerfumeCollectionView.snp.makeConstraints{
            $0.top.equalTo(accordPerfume.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(280)
        }
        self.accordPerfume.snp.makeConstraints{
            $0.top.equalTo(accordInfoLabel.snp.bottom).offset(52)
            $0.leading.equalToSuperview().offset(16)
        }
        self.accordInfoLabel.snp.makeConstraints{
            $0.top.equalTo(accordDesLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)

        }
        self.accordDesLabel.snp.makeConstraints{
            $0.top.equalTo(accordAniImg.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(16)
        }
        self.accordAniImg.snp.makeConstraints{
            $0.top.equalTo(accordImgView.snp.bottom).offset(24)
            $0.width.height.equalTo(40)
            $0.leading.equalToSuperview().offset(16)
        }
        self.accordImgView.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(280)
        }
        self.navititleLabel.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        self.backBtn.snp.makeConstraints{
            $0.top.equalToSuperview().offset(14)
            $0.leading.equalToSuperview().offset(24)
            $0.height.equalTo(24)
            
        }
        self.contentView.snp.makeConstraints{
            $0.width.equalToSuperview().offset(0)
            $0.edges.equalToSuperview().offset(0)
            $0.height.equalTo(812)
        }
        self.scrollView.snp.makeConstraints{
            $0.top.equalTo(customNaviBar.snp.bottom).offset(0)
            $0.left.right.bottom.equalToSuperview()
        }
        self.customNaviBar.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(0)
            $0.width.equalToSuperview().offset(0)
            $0.height.equalTo(52)
        }
    }
    private func configure(){
        self.view.backgroundColor = .white
        self.backBtn.addTarget(self, action: #selector(backBtnClick), for: .touchUpInside)
        self.accordPerfumeCollectionView.delegate = self
        self.accordPerfumeCollectionView.dataSource = self
    }
    @objc private func backBtnClick(){
        self.dismiss(animated: false)
    }
    private func addsubview(){
        self.view.addSubview(scrollView)
        self.view.addSubview(customNaviBar)
        self.scrollView.addSubview(contentView)
        self.customNaviBar.addSubview(backBtn)
        self.customNaviBar.addSubview(navititleLabel)
        self.contentView.addSubview(accordAniImg)
        self.contentView.addSubview(accordImgView)
        self.contentView.addSubview(accordDesLabel)
        self.contentView.addSubview(accordInfoLabel)
        self.contentView.addSubview(accordPerfume)
        self.contentView.addSubview(accordPerfumeCollectionView)

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        addsubview()
        layout()
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
