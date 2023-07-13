//
//  HomeViewController.swift
//  Na'nez
//
//  Created by 최지철 on 2023/07/13.
//

import UIKit
import SnapKit
import Then
class HomeViewController: UIViewController {
    private let customNaviBar = UIView().then{
        $0.backgroundColor = .white
    }
    private let logoImgView = UIImageView().then{
        $0.contentMode = .scaleAspectFit
        $0.layer.masksToBounds = true
        $0.image = UIImage(named: "FontLogo")
    }
    private let contentView = UIView().then{
        $0.backgroundColor = .white
    }
    private let scrollView = UIScrollView()
    
    private func layout(){
        self.logoImgView.snp.makeConstraints{
            $0.width.equalTo(86)
            $0.height.equalTo(28)
            $0.centerX.equalTo(customNaviBar)
            $0.centerY.equalTo(customNaviBar)
        }
        self.contentView.snp.makeConstraints{
            $0.width.equalToSuperview().offset(0)
            $0.edges.equalToSuperview().offset(0)
            $0.height.equalTo(3059)
        }
        self.scrollView.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.left.right.bottom.equalToSuperview()
        }
        self.customNaviBar.snp.makeConstraints{
            $0.width.equalToSuperview().offset(0)
            $0.height.equalTo(52)
        }
    }
    private func addsubView(){
        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        self.contentView.addSubview(customNaviBar)
        self.customNaviBar.addSubview(logoImgView)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.addsubView()
        self.layout()
    }
}
