//
//  DetailBrandViewController.swift
//  Na'nez
//
//  Created by 최지철 on 2023/07/31.
//

import UIKit

class DetailBrandViewController: UIViewController {
    public var brandinfo : DetailBrandInfo?
    private let PerfumeAPI = PerfumeService()
    private let brandPerfumeCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.register(HomeRecommendCollectionViewCell.self, forCellWithReuseIdentifier: BrandCollectionViewCell.identifier)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
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
    private var brandAniImg = UIImageView().then{
        $0.backgroundColor = .clear
        $0.contentMode = .scaleAspectFit
        $0.layer.masksToBounds = true
        $0.image = UIImage(named: "Na'NezLogo")
    }
    private var brandImgView = UIImageView().then{
        $0.backgroundColor = .clear
        $0.contentMode = .scaleAspectFit
        $0.layer.masksToBounds = true
        $0.image = UIImage(named: "Na'NezLogo")

    }
    private var navititleLabel = UILabel().then{
        $0.text = "brand"
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
        self.brandPerfumeCollectionView.snp.makeConstraints{
            $0.top.equalTo(brandPerfume.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(280)
        }
        self.brandPerfume.snp.makeConstraints{
            $0.top.equalTo(brandSubTitleLabel.snp.bottom).offset(52)
            $0.leading.equalToSuperview().offset(16)
        }
        self.brandSubTitleLabel.snp.makeConstraints{
            $0.top.equalTo(brandTiltleLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)

        }
        self.brandTiltleLabel.snp.makeConstraints{
            $0.top.equalTo(brandAniImg.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(16)
        }
        self.brandAniImg.snp.makeConstraints{
            $0.top.equalTo(brandImgView.snp.bottom).offset(24)
            $0.width.equalTo(123)
            $0.height.equalTo(60)
            $0.leading.equalToSuperview().offset(16)
        }
        self.brandImgView.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(72)
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
            $0.height.equalTo(740)
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
        self.brandPerfumeCollectionView.delegate = self
        self.brandPerfumeCollectionView.dataSource = self
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
        self.contentView.addSubview(brandAniImg)
        self.contentView.addSubview(brandImgView)
        self.contentView.addSubview(brandSubTitleLabel)
        self.contentView.addSubview(brandTiltleLabel)
        self.contentView.addSubview(brandPerfume)
        self.contentView.addSubview(brandPerfumeCollectionView)

    }
    override func viewWillAppear(_ animated: Bool) {
        if brandinfo != nil {
            self.navititleLabel.text = brandinfo?.kor
            let url = URL(string:APIConstants.noImage)
            self.brandImgView.kf.setImage(with: url)
            let url2 = URL(string: brandinfo?.image ?? APIConstants.noImage)
            self.brandAniImg.kf.setImage(with: url2)
            self.brandTiltleLabel.text = brandinfo?.detail?.topTitle ?? "브랜드 탑 타이틀"
            self.brandSubTitleLabel.text = brandinfo?.detail?.topSubtitle ?? "조 말론 런던은 영국에 뿌리를 둔 것을 자부심으로 여깁니다. 한 폭의 그림 같은 마을부터 구불구불한 언덕, 바람이 불어오는 해변까지, 우리는 영국의 가장 좋은 것들로부터 영감을 받습니다."
            self.brandPerfumeCollectionView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        addsubview()
        layout()
    }
}
extension DetailBrandViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return brandinfo?.relativePerfumes.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BrandCollectionViewCell.identifier, for: indexPath) as! HomeRecommendCollectionViewCell
        cell.capacityLabel.isHidden = true
        cell.descriptionLabel.isHidden = true
        cell.brandLabel.font = .pretendard(.Regular, size: 12)
        cell.perfumeLabel.font = .pretendard(.Regular, size: 16)
        cell.brandLabel.text = self.brandinfo!.relativePerfumes[indexPath.row].brand.kor
        cell.perfumeLabel.text = self.brandinfo!.relativePerfumes[indexPath.row].kor
        let url = URL(string: (self.brandinfo?.relativePerfumes[indexPath.row].image) ?? APIConstants.noImage)
        cell.Img.kf.setImage(with: url)
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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.PerfumeAPI.getPerfumeDetailInfo(id: self.brandinfo!.relativePerfumes[indexPath.row].id) { respnse in
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
}

