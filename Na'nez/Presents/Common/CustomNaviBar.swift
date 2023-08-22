//
//  CustomNaviBar.swift
//  Na'nez
//
//  Created by 최지철 on 2023/08/22.
//

// MARK: 자주쓰이는 커스텀 네비바

import UIKit
@objc
protocol CustomNaviBarDelegate{
    func backBtnClick(_ navibar:CustomNaviBar)
    func searchBtnClick(_ navibar:CustomNaviBar)
}
class CustomNaviBar: BaseView {
    weak var delegate: CustomNaviBarDelegate?
    public var navititleLabel = UILabel().then{
        $0.text = "상품정보"
        $0.font = .pretendard(.Bold, size: 18)
        $0.textColor = UIColor(rgb: 0x333333)
    }
    public let backBtn = UIButton().then{
        $0.setImage(UIImage(named: "Nan'Nez_Back"), for: .normal)
        $0.imageView?.contentMode = .scaleAspectFit
    }
    public let searchBtn = UIButton().then{
        $0.setImage(UIImage(named: "Nan'Nez_Search"), for: .normal)
        $0.imageView?.contentMode = .scaleAspectFit
    }

    override func configure() {
        self.backBtn.addTarget(self, action: #selector(backBtnClick), for: .touchUpInside)
        self.searchBtn.addTarget(self, action: #selector(searchBtnClick), for: .touchUpInside)
    }
    override func addsubview() {
        self.addSubview(backBtn)
        self.addSubview(searchBtn)
        self.addSubview(navititleLabel)
    }
    override func layout() {
        self.navititleLabel.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        self.backBtn.snp.makeConstraints{
            $0.top.equalToSuperview().offset(14)
            $0.leading.equalToSuperview().offset(24)
            $0.height.equalTo(24)
        }
        self.searchBtn.snp.makeConstraints{
            $0.top.equalToSuperview().offset(14)
            $0.trailing.equalToSuperview().offset(-14)
            $0.height.width.equalTo(24)
        }
    }
}
extension CustomNaviBar {
    @objc func backBtnClick(){
        self.delegate?.backBtnClick(self)
    }
    @objc func searchBtnClick(){
        self.delegate?.searchBtnClick(self)
    }
}
