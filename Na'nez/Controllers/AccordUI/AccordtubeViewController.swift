//
//  DetailAccordViewController.swift
//  Na'nez
//
//  Created by 최지철 on 2023/07/26.
//

import UIKit

class AccordtubeViewController: UIViewController {
    private var Totalaccord:[Accord] = []
    private var popularAccord:[Accord] = []
    private let api = AccordService()

    private let AllaccordtitleLabel = UILabel().then{
        $0.text = "모든 어코드"
        $0.font = .pretendard(.Bold, size: 20)
        $0.textColor = UIColor(rgb: 0x333333)
    }
    private let AllaccordCollectionView =  UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then{
        let layout = UICollectionViewFlowLayout()
        $0.register(AccordCollectionViewCell.self, forCellWithReuseIdentifier: AccordCollectionViewCell.identifier)
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
        $0.register(AccordCollectionViewCell.self, forCellWithReuseIdentifier: AccordCollectionViewCell.identifier)
        $0.collectionViewLayout = layout
        $0.decelerationRate = .fast
        $0.isScrollEnabled = false
        $0.backgroundColor = .clear
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = false
        layout.minimumInteritemSpacing = 0
    }
    private let accordtitleLabel = UILabel().then{
        $0.text = "지금 계절에 어울리는 어코드"
        $0.font = .pretendard(.Bold, size: 20)
        $0.textColor = UIColor(rgb: 0x333333)
    }
    private let navititleLabel = UILabel().then{
        $0.text = "어코드관"
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
    private func configure(){
        self.view.backgroundColor = .white
        self.RecommendaccordCollectionView.dataSource = self
        self.RecommendaccordCollectionView.delegate = self
        self.AllaccordCollectionView.dataSource = self
        self.AllaccordCollectionView.delegate = self
        self.backBtn.addTarget(self, action: #selector(backBtnClick), for: .touchUpInside)

    }
    private func addsubview(){
        self.view.addSubview(customNaviBar)
        self.customNaviBar.addSubview(backBtn)
        self.customNaviBar.addSubview(navititleLabel)
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(contentView)
        self.contentView.addSubview(accordtitleLabel)
        self.contentView.addSubview(RecommendaccordCollectionView)
        self.contentView.addSubview(AllaccordCollectionView)
        self.contentView.addSubview(AllaccordtitleLabel)
    }
    private func layout(){
        self.AllaccordCollectionView.snp.makeConstraints{
            $0.top.equalTo(AllaccordtitleLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(600)
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
            $0.height.equalTo(920)
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
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
        self.addsubview()
        self.layout()
    }
    @objc private func backBtnClick(){
        self.dismiss(animated: false)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.api.getAccord { response in
            switch response {
            case .success(let accordList):
                self.Totalaccord = accordList.accords
                DispatchQueue.main.async {
                    self.AllaccordCollectionView.reloadData()
                    self.RecommendaccordCollectionView.reloadData()

                }
            case .failure(_):
                break
            }
        }
    }
}
extension AccordtubeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == RecommendaccordCollectionView {
            return min(5, Totalaccord.count)
    }
        else{
            return Totalaccord.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AccordCollectionViewCell.identifier, for: indexPath) as! AccordCollectionViewCell
        cell.roundview.layer.borderWidth = 0
 
            let accordinfo = Totalaccord[indexPath.row]
            cell.accordLabel.text = accordinfo.kor
            if let imageURL = URL(string: accordinfo.image) {
                cell.Img.kf.setImage(with: imageURL)

        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == RecommendaccordCollectionView{
            if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
                let cellWidth: CGFloat = (collectionView.bounds.width - layout.minimumInteritemSpacing) / 5.2
                let cellHeight: CGFloat = (collectionView.bounds.height - layout.minimumLineSpacing) / 2
                    return CGSize(width: cellWidth, height: cellHeight)
                }
            return CGSize(width: 0, height: 0)
        }else{
            if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
                let cellWidth: CGFloat = (collectionView.bounds.width - layout.minimumInteritemSpacing) / 5
                let cellHeight: CGFloat = (collectionView.bounds.height - layout.minimumLineSpacing) / 4.2
                    return CGSize(width: cellWidth, height: cellHeight)
                }
            return CGSize(width: 0, height: 0)
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailAccordViewController()
         vc.modalPresentationStyle = .fullScreen
         self.present(vc,animated: false,completion: nil)
    }
}
