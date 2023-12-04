//
//  NoteCollectionViewCell.swift
//  Na'nez
//
//  Created by 최지철 on 2023/11/17.
//

import Foundation
import UIKit

class NoteCollectionViewCell: UICollectionViewCell {
    static let identifier = "NoteCollectionViewCell"
    
    private var noteStateLabel = UILabel().then{
        $0.text = "TopNote"
        $0.textColor = UIColor(rgb: 0x666666)
        $0.font = .pretendard(.Light, size: 11)
        $0.sizeToFit()
    }
    private var Img = UIImageView().then{
        $0.backgroundColor = .clear
        $0.contentMode = .scaleAspectFit
        $0.layer.masksToBounds = true
    }
    private var noteLabel = UILabel().then{
        $0.text = "accord"
        $0.textColor = UIColor(rgb: 0x333333)
        $0.numberOfLines = 0
        $0.sizeToFit()
        $0.font = .pretendard(.Regular, size: 14)
    }
    private func layout(){
        self.Img.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.width.height.equalTo(106)
        }
        self.noteStateLabel.snp.makeConstraints {
            $0.top.equalTo(Img.snp.bottom).offset(8)
            $0.leading.equalToSuperview()
        }
        self.noteLabel.snp.makeConstraints{
            $0.top.equalTo(noteStateLabel.snp.bottom)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()

        }
    }
    
    private func addview(){
        self.addSubview(noteLabel)
        self.addSubview(noteStateLabel)
        self.addSubview(Img)
      }
    
    func configureCell(_ item: PerfumeNoteDTO) {
        if let imageURL = URL(string: item.note.image ?? APIConstants.noImage) {
            self.Img.kf.setImage(with: imageURL)
        }
        self.noteStateLabel.text = item.type.fromNoteString(item.type)
        self.noteLabel.text = item.note.eng
    }
       
       override init(frame: CGRect) {
           super.init(frame: .zero)
           
           self.addview()
           self.layout()
       }
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
}
