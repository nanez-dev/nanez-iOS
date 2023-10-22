//
//  MyInfoViewController.swift
//  Na'nez
//
//  Created by 최지철 on 2023/07/13.
//

import UIKit

class MyInfoViewController: BaseViewController {
    private let navibar:CustomNaviBar = CustomNaviBar(frame: .zero)
    private let myinfoView:MyInfoView = MyInfoView(frame: .zero)
    
    override func layout() {
        navibar.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(0)
            $0.width.equalToSuperview().offset(0)
            $0.height.equalTo(52)
        }
        myinfoView.snp.makeConstraints {
            $0.top.equalTo(navibar.snp.bottom).offset(0)
            $0.leading.bottom.trailing.equalToSuperview()
        }
    }
    override func configure() {
        self.view.addSubview(navibar)
        self.view.addSubview(myinfoView)
        self.navibar.backBtn.isHidden = true
        self.navibar.searchBtn.isHidden = true
        self.navibar.navititleLabel.text = "마이페이지"
    }

}
extension MyInfoViewController: CustomNaviBarDelegate{
    func backBtnClick(_ navibar: CustomNaviBar) {
        
    }
    func searchBtnClick(_ navibar: CustomNaviBar) {
        
    }
}
