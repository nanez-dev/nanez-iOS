//
//  DetailPerfumeViewController.swift
//  Na'nez
//
//  Created by 최지철 on 2023/07/16.
//

import UIKit

class DetailPerfumeViewController: UIViewController {
    public var PefumeInfo: Perfume?
    private let second_accordcollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then{
        let layout = UICollectionViewFlowLayout()
        $0.register(AccordCollectionViewCell.self, forCellWithReuseIdentifier: AccordCollectionViewCell.identifier)
        $0.collectionViewLayout = layout
        $0.decelerationRate = .fast
        $0.isScrollEnabled = false
        $0.backgroundColor = .clear
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = false
    }
    private var bottomnoteLabel = UILabel().then{
        $0.text = "BottomNote:Lemon"
        $0.font = .pretendard(.Regular, size: 18)
        $0.textColor = UIColor(rgb: 0x000000)
    }
    private var middlenoteLabel = UILabel().then{
        $0.text = "MiddleNote:Lemon"
        $0.font = .pretendard(.Regular, size: 18)
        $0.textColor = UIColor(rgb: 0x000000)
    }
    private var topnoteLabel = UILabel().then{
        $0.text = "TopNote:Lemon"
        $0.font = .pretendard(.Regular, size: 18)
        $0.textColor = UIColor(rgb: 0x000000)
    }
    private let noteSV = UIStackView().then{
        $0.spacing = 5
        $0.axis = .vertical
        $0.distribution = .fill
    }
    private var notedesLabel = UILabel().then{
        $0.text = "설명블라블라블라"
        $0.font = .pretendard(.Light, size: 16)
        $0.textColor = UIColor(rgb: 0x333333)
        $0.numberOfLines = 0
        $0.numberOfLines = 0
        $0.sizeToFit()

    }
    private var notetitleLabel = UILabel().then{
        $0.text = "가을의 정수"
        $0.font = .pretendard(.SemiBold, size: 18)
        $0.textColor = UIColor(rgb: 0xF27766)
        $0.numberOfLines = 0
        $0.sizeToFit()
    }
    private let noteLabel = UILabel().then{
        $0.text = "노트"
        $0.font = .pretendard(.Bold, size: 20)
        $0.textColor = UIColor(rgb: 0x333333)
    }
    private let detailaccordCollectionView =  UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then{
        let layout = UICollectionViewFlowLayout()
        $0.register(AccordCollectionViewCell.self, forCellWithReuseIdentifier: AccordCollectionViewCell.identifier)
        $0.collectionViewLayout = layout
        $0.decelerationRate = .fast
        $0.isScrollEnabled = false
        $0.backgroundColor = .clear
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = false
    }
    private let accordLabel = UILabel().then{
        $0.text = "어코드"
        $0.font = .pretendard(.Bold, size: 20)
        $0.textColor = UIColor(rgb: 0x333333)
    }
    private let spacebarView = UIView().then{
        $0.backgroundColor = .gragray
    }
    private let infoBtnSV = UIStackView().then{
        $0.spacing = 8
        $0.axis = .horizontal
        $0.distribution = .fill
    }
    private let perfumeinfoSV = UIStackView().then{
        $0.spacing = 0
        $0.axis = .vertical
        $0.distribution = .fill
    }
    private var reportBtn = UIButton().then{
        $0.layer.borderWidth = 0
        $0.backgroundColor = .clear
        $0.setTitle("신고", for: .normal)
        $0.titleLabel?.font = UIFont.pretendard(.Light, size: 14)
        $0.setTitleColor(UIColor(rgb: 0xFF0000), for: .normal)
        
    }
    private var heartBtn = UIButton().then{
        $0.setImage(UIImage(systemName: "heart"), for: .normal)
        $0.contentMode = .scaleAspectFit
        $0.layer.masksToBounds = true
        $0.tintColor = .black
    }
    private var checkBtn = UIButton().then{
        $0.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
        $0.contentMode = .scaleAspectFit
        $0.layer.masksToBounds = true
        $0.tintColor = .black

    }
    private var priceLabel = UILabel().then{
        $0.text = "99,000원"
        $0.font = .pretendard(.Bold, size: 24)
        $0.textColor = UIColor(rgb: 0x65BFC4)
        let attributedStr = NSMutableAttributedString(string: $0.text!)
        attributedStr.addAttribute(.foregroundColor, value: UIColor.black, range: ($0.text! as NSString).range(of: "원"))
        $0.attributedText = attributedStr
    }
    private var kor_capacityLabel = UILabel().then{
        $0.text = "향수, 30ml"
        $0.font = .pretendard(.Regular, size: 14)
        $0.textColor = UIColor(rgb: 0x333333)
    }
    private var EngLabel = UILabel().then{
        $0.text = "Eng"
        $0.font = .pretendard(.Bold, size: 16)
        $0.textColor = UIColor(rgb: 0x333333)
    }
    private var brandLabel = UILabel().then{
        $0.text = "brand"
        $0.font = .pretendard(.Regular, size: 14)
        $0.textColor = UIColor(rgb: 0x666666)
    }
    private let perfumeInfoView = UIView().then{
        $0.backgroundColor = .clear
    }
    private var PerfumeImg = UIImageView().then{
        $0.contentMode = .scaleAspectFit
        $0.layer.masksToBounds = true
        $0.backgroundColor = .clear
    }
    private let perfumeView = UIView().then {
        $0.backgroundColor = UIColor(rgb: 0xFAFAFD)
    }
    private let perfumetitleLabel = UILabel().then{
        $0.text = "상품정보"
        $0.font = .pretendard(.Bold, size: 18)
        $0.textColor = UIColor(rgb: 0x333333)
    }
    private let backBtn = UIButton().then{
        $0.setImage(UIImage(named: "Nan'Nez_Back"), for: .normal)
        $0.imageView?.contentMode = .scaleAspectFit
    }
    private let searchBtn = UIButton().then{
        $0.setImage(UIImage(named: "Nan'Nez_Search"), for: .normal)
        $0.imageView?.contentMode = .scaleAspectFit
    }
    private let customNaviBar = UIView().then{
        $0.backgroundColor = .white
    }
    private let contentView = UIView().then{
        $0.backgroundColor = .white
    }
    private let scrollView = UIScrollView()
    
    private func layout(){
        self.second_accordcollectionView.snp.makeConstraints{
            $0.top.equalTo(noteSV.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-22)
            $0.height.equalTo(137)
        }
        self.noteSV.snp.makeConstraints{
            $0.top.equalTo(notedesLabel.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(16)
        }
        self.notedesLabel.snp.makeConstraints{
            $0.top.equalTo(notetitleLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-22)
        }
        self.notetitleLabel.snp.makeConstraints{
            $0.top.equalTo(noteLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-22)
        }
        self.noteLabel.snp.makeConstraints{
            $0.top.equalTo(detailaccordCollectionView.snp.bottom).offset(50)
            $0.leading.equalToSuperview().offset(16)
            $0.height.equalTo(25)
        }
        self.detailaccordCollectionView.snp.makeConstraints{
            $0.top.equalTo(accordLabel.snp.bottom).offset(21)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-22)
            $0.height.equalTo(137)
        }
        self.accordLabel.snp.makeConstraints{
            $0.top.equalTo(spacebarView.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(16)
        }
        self.spacebarView.snp.makeConstraints{
            $0.top.equalTo(perfumeInfoView.snp.bottom).offset(0)
            $0.height.equalTo(8)
            $0.leading.trailing.equalToSuperview()

        }
        self.reportBtn.snp.makeConstraints{
            $0.trailing.equalToSuperview().offset(-22)
            $0.bottom.equalToSuperview().offset(-24)
            $0.height.equalTo(24)

        }
        self.heartBtn.snp.makeConstraints{
            $0.height.equalTo(24)
            $0.width.equalTo(24)

        }
        self.backBtn.snp.makeConstraints{
            $0.height.equalTo(24)
            $0.width.equalTo(24)

        }
        self.infoBtnSV.snp.makeConstraints{
            $0.top.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().offset(-22)
        }
        self.priceLabel.snp.makeConstraints{
            $0.bottom.equalToSuperview().offset(-24)
            $0.leading.equalToSuperview().offset(16)
        }
        self.perfumeinfoSV.snp.makeConstraints{
            $0.top.equalToSuperview().offset(24)
            $0.leading.equalToSuperview().offset(16)
        }
        self.perfumeInfoView.snp.makeConstraints{
            $0.top.equalTo(perfumeView.snp.bottom).offset(0)
            $0.leading.trailing.equalToSuperview().offset(0)
            $0.height.equalTo(144)
        }
        self.PerfumeImg.snp.makeConstraints{
            $0.top.leading.equalToSuperview().offset(27)
            $0.bottom.trailing.equalToSuperview().offset(-28)
        }
        self.perfumeView.snp.makeConstraints{
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(375)
        }
        self.perfumetitleLabel.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        self.backBtn.snp.makeConstraints{
            $0.top.equalToSuperview().offset(14)
            $0.leading.equalToSuperview().offset(14)
            $0.height.equalTo(24)
        }
        self.searchBtn.snp.makeConstraints{
            $0.top.equalToSuperview().offset(14)
            $0.trailing.equalToSuperview().offset(-14)
            $0.height.equalTo(24)
        }
        self.contentView.snp.makeConstraints{
            $0.width.equalToSuperview().offset(0)
            $0.edges.equalToSuperview().offset(0)
            $0.height.equalTo(1300)
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
    private func addSubview(){
        self.view.addSubview(customNaviBar)
        self.customNaviBar.addSubview(perfumetitleLabel)
        self.customNaviBar.addSubview(searchBtn)
        self.customNaviBar.addSubview(backBtn)
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(contentView)
        self.contentView.addSubview(perfumeView)
        self.perfumeView.addSubview(PerfumeImg)
        self.contentView.addSubview(perfumeInfoView)
        self.perfumeInfoView.addSubview(perfumeinfoSV)
        self.perfumeInfoView.addSubview(infoBtnSV)
        self.infoBtnSV.addArrangedSubview(checkBtn)
        self.infoBtnSV.addArrangedSubview(heartBtn)
        self.perfumeinfoSV.addArrangedSubview(brandLabel)
        self.perfumeinfoSV.addArrangedSubview(EngLabel)
        self.perfumeinfoSV.addArrangedSubview(kor_capacityLabel)
        self.perfumeInfoView.addSubview(priceLabel)
        self.perfumeInfoView.addSubview(reportBtn)
        self.contentView.addSubview(spacebarView)
        self.contentView.addSubview(accordLabel)
        self.contentView.addSubview(detailaccordCollectionView)
        self.contentView.addSubview(noteLabel)
        self.contentView.addSubview(notetitleLabel)
        self.contentView.addSubview(notetitleLabel)
        self.contentView.addSubview(notedesLabel)
        self.contentView.addSubview(noteSV)
        self.noteSV.addArrangedSubview(topnoteLabel)
        self.noteSV.addArrangedSubview(middlenoteLabel)
        self.noteSV.addArrangedSubview(bottomnoteLabel)
        self.contentView.addSubview(second_accordcollectionView)
    }
    private func configure(){
        self.detailaccordCollectionView.dataSource = self
        self.detailaccordCollectionView.delegate = self
        self.second_accordcollectionView.dataSource = self
        self.second_accordcollectionView.delegate = self
        self.view.backgroundColor = .white
        self.backBtn.addTarget(self, action: #selector(backBtnClick), for: .touchUpInside)
        self.reportBtn.addTarget(self, action: #selector(reportBtnClick), for: .touchUpInside)

    }
    @objc private func reportBtnClick(){
        let vc = ReportPopupViewController()
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc,animated: false,completion: nil)
    }
    @objc private func backBtnClick(){
        self.dismiss(animated: false)
    }
    override func viewWillAppear(_ animated: Bool) {
        if PefumeInfo != nil {
            self.EngLabel.text = PefumeInfo?.eng ?? "Eng"
            self.brandLabel.text = PefumeInfo?.brand?.kor ?? "브랜드"
            self.kor_capacityLabel.text = PefumeInfo!.kor + ", " + String(PefumeInfo!.capacity) + "ml"
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            self.priceLabel.text = numberFormatter.string(from: NSNumber(value: PefumeInfo!.price))! + "원"
            let attributedStr = NSMutableAttributedString(string: priceLabel.text!)
            attributedStr.addAttribute(.foregroundColor, value: UIColor.black, range: (priceLabel.text! as NSString).range(of: "원"))
            priceLabel.attributedText = attributedStr
            self.notetitleLabel.text = PefumeInfo!.title
            self.notedesLabel.text = PefumeInfo!.subtitle
            if PefumeInfo!.perfume_notes.count < 3 {
                self.topnoteLabel.text = "TopNote: " + PefumeInfo!.perfume_notes[0].note.eng
                 self.middlenoteLabel.text = "MiddleNote: " + PefumeInfo!.perfume_notes[1].note.eng
            }
            else{
                self.topnoteLabel.text = "TopNote: " + PefumeInfo!.perfume_notes[0].note.eng
                 self.middlenoteLabel.text = "MiddleNote: " + PefumeInfo!.perfume_notes[1].note.eng
                 self.bottomnoteLabel.text = "BottomNote: " + PefumeInfo!.perfume_notes[2].note.eng
            }
            self.detailaccordCollectionView.reloadData()
            self.second_accordcollectionView.reloadData()
            let url = URL(string: PefumeInfo!.image ?? APIConstants.noImage)
            self.PerfumeImg.kf.setImage(with: url)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
        self.addSubview()
        self.layout()

    }
    
}
extension DetailPerfumeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == detailaccordCollectionView {
            return PefumeInfo!.perfume_accords.count
        }
        else{
            return PefumeInfo!.perfume_notes.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AccordCollectionViewCell.identifier, for: indexPath) as! AccordCollectionViewCell
        if PefumeInfo != nil{
            if collectionView == detailaccordCollectionView {
                let url = URL(string: PefumeInfo!.perfume_accords[indexPath.row].accord.image)
                cell.Img.kf.setImage(with: url)
                cell.accordLabel.text =  PefumeInfo!.perfume_accords[indexPath.row].accord.eng
            }else{
                let url = URL(string: PefumeInfo!.perfume_notes[indexPath.row].note.image ?? APIConstants.noImage )
                cell.Img.kf.setImage(with: url)
                cell.accordLabel.text =  PefumeInfo!.perfume_notes[indexPath.row].note.eng
            }
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            let cellWidth: CGFloat = (collectionView.bounds.width - layout.minimumInteritemSpacing) / 3.2
                let cellHeight: CGFloat = (collectionView.bounds.height - layout.minimumLineSpacing) / 1
                return CGSize(width: cellWidth, height: cellHeight)
            }
        return CGSize(width: 0, height: 0)
    }

 }
