//
//  DetailBrandViewController.swift
//  Na'nez
//
//  Created by 최지철 on 2023/07/31.
//

import UIKit

class DetailBrandViewController: BaseViewController {
    public var brandinfo : DetailBrandInfo?
    private let PerfumeAPI = PerfumeService()
    private var navibar: CustomNaviBar = CustomNaviBar(frame: .zero)
    private var detailBrandView : DetailBrandView = DetailBrandView(frame: .zero)

    override func viewWillAppear(_ animated: Bool) {
        if brandinfo != nil {
            self.navibar.navititleLabel.text = brandinfo?.kor
            let url = URL(string:APIConstants.noImage)
            detailBrandView.brandImgView.kf.setImage(with: url)
            let url2 = URL(string: brandinfo?.image ?? APIConstants.noImage)
            detailBrandView.brandAniImg.kf.setImage(with: url2)
            detailBrandView.brandTiltleLabel.text = brandinfo?.detail?.topTitle ?? "브랜드 탑 타이틀"
            detailBrandView.brandSubTitleLabel.text = brandinfo?.detail?.topSubtitle ?? "조 말론 런던은 영국에 뿌리를 둔 것을 자부심으로 여깁니다. 한 폭의 그림 같은 마을부터 구불구불한 언덕, 바람이 불어오는 해변까지, 우리는 영국의 가장 좋은 것들로부터 영감을 받습니다."
            detailBrandView.brandPerfumeCollectionView.reloadData()
        }
    }
    override func configure() {
        detailBrandView.brandPerfumeCollectionView.delegate = self
        detailBrandView.brandPerfumeCollectionView.dataSource = self
        self.navibar.delegate = self
        self.navibar.searchBtn.isHidden = true
        self.view.addSubview(navibar)
        self.view.addSubview(detailBrandView)
    }
    override func layout() {
        self.navibar.snp.makeConstraints{
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.width.equalToSuperview().offset(0)
            $0.height.equalTo(52)
        }
        self.detailBrandView.snp.makeConstraints{
            $0.top.equalTo(navibar.snp.bottom)
            $0.leading.bottom.trailing.equalToSuperview()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
extension DetailBrandViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return brandinfo?.relativePerfumes.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PerfumeCollectionViewCell.identifier, for: indexPath) as! PerfumeCollectionViewCell
     
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
extension DetailBrandViewController: CustomNaviBarDelegate {
    func backBtnClick(_ navibar: CustomNaviBar) {
        self.dismiss(animated: false)
    }
    func searchBtnClick(_ navibar: CustomNaviBar) {
        
    }
    
    
}


