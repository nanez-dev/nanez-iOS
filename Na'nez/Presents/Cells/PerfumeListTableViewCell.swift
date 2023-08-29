//
//  PerfumeListTableViewCell.swift
//  Na'nez
//
//  Created by 최지철 on 2023/08/26.
//

import UIKit

class PerfumeListTableViewCell: UITableViewCell {
    static let identifier = "PerfumeListTableViewCell"
    public var Img = UIImageView().then{
        $0.backgroundColor = .clear
        $0.contentMode = .scaleAspectFit
        $0.backgroundColor = .red
    }
    public var brandLabel = UILabel().then{
        $0.text = "브랜드이름"
        $0.textColor = UIColor(hexString: "#666666")
        $0.font = .pretendard(.Regular, size: 14)
    }
    public var engLabel = UILabel().then{
        $0.text = "PerfumeName"
        $0.textColor = UIColor(hexString: "#333333")
        $0.font = .pretendard(.Bold, size: 16)
    }
    public var korLabel = UILabel().then{
        $0.text = "향수이름"
        $0.textColor = UIColor(hexString: "#333333")
        $0.font = .pretendard(.Regular, size: 14)
    }
    private func layout(){
        self.Img.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(16)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(48)
        }
        self.brandLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(18)
            $0.leading.equalTo(Img.snp.trailing).offset(16)
        }
        self.engLabel.snp.makeConstraints{
            $0.top.equalTo(brandLabel.snp.bottom).offset(4)
            $0.leading.equalTo(Img.snp.trailing).offset(16)
        }
        self.korLabel.snp.makeConstraints{
            $0.top.equalTo(engLabel.snp.bottom).offset(2)
            $0.leading.equalTo(Img.snp.trailing).offset(16)
        }
    }
    private func addsubview(){
        self.addSubview(Img)
        self.addSubview(brandLabel)
        self.addSubview(engLabel)
        self.addSubview(korLabel)
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addsubview()
        self.layout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
