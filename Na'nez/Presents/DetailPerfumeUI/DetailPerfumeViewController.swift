//
//  DetailPerfumeViewController.swift
//  Na'nez
//
//  Created by 최지철 on 2023/07/16.
//

import UIKit

class DetailPerfumeViewController: BaseViewController {
    
    private let viewModel: DetailPerfumeViewModel
    
    private var navibar: CustomNaviBar = CustomNaviBar(frame: .zero)
    
    private var reviewBtn = UIButton().then{
        $0.layer.borderWidth = 0
        $0.backgroundColor = UIColor(hexString:"#65BFC4")
        $0.setTitle("시향기 작성하러가기", for: .normal)
        $0.titleLabel?.font = UIFont.pretendard(.Bold, size: 16)
        $0.setTitleColor(UIColor(hexString:"#FFFFFF"), for: .normal)
        $0.layer.cornerRadius = 12
    }

    private let noReviewImg = UIImageView().then {
        $0.backgroundColor = .clear
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "noImg")
    }
    
    private let reviewSV = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 24
    }
    
    private let reviewLabel = UILabel().then{
        $0.text = "시향기"
        $0.font = .pretendard(.Bold, size: 20)
        $0.textColor = UIColor(rgb: 0x333333)
        $0.sizeToFit()
    }
    private let reviewCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then{
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 1
        layout.itemSize = CGSize(width: 106, height: 150)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        $0.register(NoteCollectionViewCell.self, forCellWithReuseIdentifier: NoteCollectionViewCell.identifier)
        $0.collectionViewLayout = layout
        $0.decelerationRate = .fast
        $0.isScrollEnabled = false
        $0.backgroundColor = .clear
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = false
    }
    
    private let noteCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then{
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 1
        layout.itemSize = CGSize(width: 106, height: 160)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        $0.register(NoteCollectionViewCell.self, forCellWithReuseIdentifier: NoteCollectionViewCell.identifier)
        $0.collectionViewLayout = layout
        $0.decelerationRate = .fast
        $0.isScrollEnabled = false
        $0.backgroundColor = .clear
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = false
    }
    private var bottomnoteLabel = UILabel().then{
        $0.text = "BottomNote: "
        $0.font = .pretendard(.Regular, size: 18)
        $0.textColor = UIColor(rgb: 0x333333)
    }
    private var middlenoteLabel = UILabel().then{
        $0.text = "MiddleNote: "
        $0.font = .pretendard(.Regular, size: 18)
        $0.textColor = UIColor(rgb: 0x333333)
    }
    private var topnoteLabel = UILabel().then{
        $0.text = "TopNote: "
        $0.font = .pretendard(.Regular, size: 18)
        $0.textColor = UIColor(rgb: 0x333333)
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
        layout.minimumInteritemSpacing = 1
        layout.itemSize = CGSize(width: 106, height: 134)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
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
        $0.spacing = 4
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
    private let contentView = UIView().then{
        $0.backgroundColor = .white
    }
    private let scrollView = UIScrollView()
    
    init(_ viewModel: DetailPerfumeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configure(){
        self.view.backgroundColor = .white
        self.navibar.delegate = self
        self.view.addSubview(navibar)
        self.navibar.navititleLabel.text = "상품정보"
    }
    
    override func addview() {
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
        self.contentView.addSubview(noteCollectionView)
        self.contentView.addSubview(reviewLabel)
        self.scrollView.addSubview(reviewSV)
        self.reviewSV.addArrangedSubview(noReviewImg)
        self.reviewSV.addArrangedSubview(reviewBtn)
    }

    override func layout() {
        navibar.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(0)
            $0.width.equalToSuperview().offset(0)
            $0.height.equalTo(52)
        }
        self.reviewBtn.snp.makeConstraints {
            $0.height.equalTo(52)
        }
        self.noReviewImg.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(169)
        }
        self.reviewSV.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalToSuperview()
        }
        self.reviewLabel.snp.makeConstraints {
            $0.top.equalTo(noteCollectionView.snp.bottom).offset(52)
            $0.leading.equalToSuperview().offset(16)
        }
        self.noteCollectionView.snp.makeConstraints{
            $0.top.equalTo(noteSV.snp.bottom).offset(12)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(160)
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
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
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

        self.contentView.snp.makeConstraints{
            $0.width.equalToSuperview()
            $0.trailing.left.top.equalToSuperview()
            $0.bottom.equalTo(reviewSV.snp.top)
            $0.height.equalTo(1350)
        }
        self.scrollView.snp.makeConstraints{
            $0.top.equalTo(self.navibar.snp.bottom).offset(0)
            $0.left.right.bottom.equalToSuperview()
        }
    }
    
    override func binding() {
        viewModel.perfumeDetailInfo
            .bind(onNext: { [weak self] perfume in
                if let imageURL = URL(string: perfume.image ?? APIConstants.noImage) {
                    self?.PerfumeImg.kf.setImage(with: imageURL)
                }
                self?.EngLabel.text = perfume.eng
                self?.brandLabel.text = perfume.brand.kor
                self?.priceLabel.text = String(perfume.price).formatPriceWithWon()
                self?.kor_capacityLabel.text = "\(perfume.kor), \(String(perfume.capacity))ml"
                self?.notetitleLabel.text = perfume.title
                self?.notedesLabel.text = perfume.subtitle
                self?.topnoteLabel.text! += perfume.perfume_notes[0].note.kor
                self?.middlenoteLabel.text! += perfume.perfume_notes[1].note.kor
                self?.bottomnoteLabel.text! += perfume.perfume_notes[2].note.kor
            })
            .disposed(by: disposebag)
        
        viewModel.perfumeAccords
            .bind(to: self.detailaccordCollectionView.rx.items(cellIdentifier: AccordCollectionViewCell.identifier, cellType: AccordCollectionViewCell.self))
            {   index, item, cell in
                cell.configureCell(item.accord)
            }
            .disposed(by: disposebag)
        
        viewModel.perfumeNotes
            .bind(to: self.noteCollectionView.rx.items(cellIdentifier: NoteCollectionViewCell.identifier, cellType: NoteCollectionViewCell.self))
            {   index, item, cell in
                cell.configureCell(item)
            }
            .disposed(by: disposebag)
        
    }
}
extension DetailPerfumeViewController: CustomNaviBarDelegate {
    func backBtnClick(_ navibar: CustomNaviBar) {
        self.navigationController?.popViewController(animated: true)
    }
    func searchBtnClick(_ navibar: CustomNaviBar) {
        
    }
    
    
}

