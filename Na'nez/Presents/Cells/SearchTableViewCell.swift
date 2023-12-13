//
//  SearchTableViewCell.swift
//  Na'nez
//
//  Created by 최지철 on 2023/12/13.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    static let identifier = "SearchTableViewCell"
    
    private let searchImg = UIImageView().then {
        $0.image = UIImage(named: "Nan'Nez_Search")
        $0.contentMode = .scaleAspectFit
    }
    
    private let arrowImg = UIImageView().then {
        $0.image = UIImage(named: "diagonalArrow")
        $0.contentMode = .scaleAspectFit
    }
    
    private let label = UILabel().then {
        $0.text = ""
        $0.font = .pretendard(.Regular, size: 16)
        $0.textColor = UIColor(hexString: "#333333")
        $0.sizeToFit()
    }
    
    private func layout(){
        self.searchImg.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(24)
            $0.leading.equalToSuperview().offset(20)
        }
        self.label.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(searchImg.snp.trailing).offset(8)
            $0.trailing.equalTo(arrowImg.snp.leading).inset(8)
        }
        self.arrowImg.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(24)
            $0.trailing.equalToSuperview().offset(-20)
        }
    }
    
    private func addsubview(){
        self.addSubview(searchImg)
        self.addSubview(arrowImg)
        self.addSubview(label)
    }
    
    private func configure(){
        self.backgroundColor = .white
    }
    
    func configureCell(_ item: SearchPerfumeDTO) {
        self.label.text = item.kor
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addsubview()
        self.layout()

    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
