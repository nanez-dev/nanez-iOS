//
//  DetailPerfumeViewController.swift
//  Na'nez
//
//  Created by 최지철 on 2023/07/16.
//

import UIKit

class DetailPerfumeViewController: UIViewController {
    public var PefumeInfo: Perfume?
    private var detailperfumeView: DetailPerfumeView = DetailPerfumeView(frame: .zero)

    private func setUI() {
        detailperfumeView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.bottom.leading.trailing.equalToSuperview()
        }
    }
    private func configure(){
        self.detailperfumeView.detailaccordCollectionView.dataSource = self
        self.detailperfumeView.detailaccordCollectionView.delegate = self
        self.detailperfumeView.second_accordcollectionView.dataSource = self
        self.detailperfumeView.second_accordcollectionView.delegate = self
        self.view.backgroundColor = .white
        self.detailperfumeView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        if PefumeInfo != nil {
            self.detailperfumeView.EngLabel.text = PefumeInfo?.eng ?? "Eng"
            self.detailperfumeView.brandLabel.text = PefumeInfo?.brand?.kor ?? "브랜드"
            self.detailperfumeView.kor_capacityLabel.text = PefumeInfo!.kor + ", " + String(PefumeInfo!.capacity) + "ml"
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            self.detailperfumeView.priceLabel.text = numberFormatter.string(from: NSNumber(value: PefumeInfo!.price))! + "원"
            let attributedStr = NSMutableAttributedString(string: detailperfumeView.priceLabel.text!)
            attributedStr.addAttribute(.foregroundColor, value: UIColor.black, range: (detailperfumeView.priceLabel.text! as NSString).range(of: "원"))
            detailperfumeView.priceLabel.attributedText = attributedStr
            self.detailperfumeView.notetitleLabel.text = PefumeInfo!.title
            self.detailperfumeView.notedesLabel.text = PefumeInfo!.subtitle
            if PefumeInfo!.perfume_notes.count < 3 {
                self.detailperfumeView.topnoteLabel.text = "TopNote: " + PefumeInfo!.perfume_notes[0].note.eng
                self.detailperfumeView.middlenoteLabel.text = "MiddleNote: " + PefumeInfo!.perfume_notes[1].note.eng
            }
            else{
                self.detailperfumeView.topnoteLabel.text = "TopNote: " + PefumeInfo!.perfume_notes[0].note.eng
                 self.detailperfumeView.middlenoteLabel.text = "MiddleNote: " + PefumeInfo!.perfume_notes[1].note.eng
                 self.detailperfumeView.bottomnoteLabel.text = "BottomNote: " + PefumeInfo!.perfume_notes[2].note.eng
            }
            self.detailperfumeView.detailaccordCollectionView.reloadData()
            self.detailperfumeView.second_accordcollectionView.reloadData()
            let url = URL(string: PefumeInfo!.image ?? APIConstants.noImage)
            self.detailperfumeView.PerfumeImg.kf.setImage(with: url)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
        self.view.addSubview(detailperfumeView)
        
        self.setUI()
    }
    
}
extension DetailPerfumeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == detailperfumeView.detailaccordCollectionView {
            return PefumeInfo!.perfume_accords.count
        }
        else{
            return PefumeInfo!.perfume_notes.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AccordCollectionViewCell.identifier, for: indexPath) as! AccordCollectionViewCell
        if PefumeInfo != nil{
            if collectionView == detailperfumeView.detailaccordCollectionView {
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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailAccordViewController()
         vc.modalPresentationStyle = .fullScreen
         self.present(vc,animated: false,completion: nil)
    }

 }
extension DetailPerfumeViewController: DetailPerfumeViewDelegate {
    func backBtnClick(_ detailperfumeView: DetailPerfumeView) {
        self.dismiss(animated: false)
    }
    
    func reportBtnClick(_ detailperfumeView: DetailPerfumeView) {
        
        let vc = ReportPopupViewController()
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc,animated: false,completion: nil)
    }
}
