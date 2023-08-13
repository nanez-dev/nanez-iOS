//
//  NaviBar.swift
//  Na'nez
//
//  Created by 최지철 on 2023/08/13.
//

import UIKit

class NaviBar: UIView {
    private let writeBtn = UIButton().then{
        $0.setImage(UIImage(named: "pencil"), for: .normal)
        $0.imageView?.contentMode = .scaleAspectFit
    }
    private let logoImgView = UIImageView().then{
        $0.contentMode = .scaleAspectFit
        $0.layer.masksToBounds = true
        $0.image = UIImage(named: "FontLogo")
    }
    
    private func addsubview() {
        self.addSubview(logoImgView)
        self.addSubview(writeBtn)
    }
    
    private func layout() {
        self.writeBtn.snp.makeConstraints{
            $0.top.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-22)
            $0.bottom.equalToSuperview().offset(-9.63)
        }
        self.logoImgView.snp.makeConstraints{
            $0.width.equalTo(86)
            $0.height.equalTo(28)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.backgroundColor = .white
        self.addsubview()
        self.layout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
