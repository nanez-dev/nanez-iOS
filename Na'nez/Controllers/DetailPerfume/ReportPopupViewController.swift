//
//  ReportPopupViewController.swift
//  Na'nez
//
//  Created by 최지철 on 2023/07/17.
//

import UIKit

class ReportPopupViewController: UIViewController {
    private let resonView = UIView().then{
        $0.backgroundColor = UIColor(rgb: 0xF2F2F2)
        $0.layer.cornerRadius = 20

    }
    private let reportLabel = UILabel().then{
    $0.text = "신고하기"
        $0.font = .pretendard(.Bold, size: 16)
        $0.textColor = UIColor(rgb: 0x111111)
    }
    private let contentView = UIView().then{
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 20
    }
    private let reportBtn = UIButton().then{
        $0.setTitle("신고하기", for: .normal)
        $0.titleLabel?.textColor = .white
        $0.titleLabel?.font = .pretendard(.ExtraBold, size: 15)
        $0.layer.cornerRadius = 20
        $0.backgroundColor = UIColor(rgb: 0xFF4D4F)
    }
    private func layout(){
        self.reportLabel.snp.makeConstraints{
            $0.top.leading.equalToSuperview().offset(20)
        }
        self.contentView.snp.makeConstraints{
            $0.height.equalTo(419)
            $0.width.equalTo(327)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        self.reportBtn.snp.makeConstraints{
            $0.height.equalTo(48)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalToSuperview().offset(-18)
        }
    }
    private func addsubView(){
        self.view.addSubview(contentView)
        self.contentView.addSubview(reportBtn)
        self.contentView.addSubview(reportLabel)

    }
    @objc private func reportBtnClick() {
        self.dismiss(animated: true)
    }
    private func configure(){
        self.reportBtn.addTarget(self, action: #selector(reportBtnClick), for: .touchUpInside)
        self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0,alpha: 0.6)
        self.view.isOpaque = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
        self.addsubView()
        self.layout()
    }

}
