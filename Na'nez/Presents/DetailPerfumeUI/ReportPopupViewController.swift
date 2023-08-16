//
//  ReportPopupViewController.swift
//  Na'nez
//
//  Created by 최지철 on 2023/07/17.
//

import UIKit

class ReportPopupViewController: UIViewController {
    private let dropdownTableView = UITableView().then{
        $0.backgroundColor = .white
        $0.register(DropDownTableViewCell.self, forCellReuseIdentifier: DropDownTableViewCell.identifier)
        $0.layer.shadowColor = UIColor.darkGray.cgColor
        $0.layer.shadowOpacity = 0.5
        $0.layer.cornerRadius = 5
        $0.layer.shadowRadius = 5 //반경
        $0.layer.masksToBounds = false
        $0.layer.shadowOffset = CGSize(width: 0, height: 5)
    }
    private var wirteResonView = UITextView().then{
        $0.backgroundColor = UIColor(rgb: 0xF2F2F2)
        $0.layer.cornerRadius = 20
        $0.font = .pretendard(.Regular, size: 14)
        $0.textColor = UIColor(rgb: 0x999999)
        $0.text = "\n" + " 기타 상세 사유를 작성해주세요."
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(rgb: 0xF2F2F2).cgColor
    }
    private let dropDownView = UIView().then{
        $0.backgroundColor = .white
    }
    private let dropDownBtn = UIButton().then{
        $0.tintColor = .black
        $0.setImage(UIImage(systemName: "chevron.down"), for: .normal)
    }
    private var reportInfo = UILabel().then{
            $0.text = "신고사유"
            $0.font = .pretendard(.Regular, size: 14)
            $0.textColor = UIColor(rgb: 0x111111)
    }
    private let resonView = UIView().then{
        $0.backgroundColor = UIColor(rgb: 0xF2F2F2)
        $0.layer.cornerRadius = 20
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(rgb: 0xF2F2F2).cgColor
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
        self.dropdownTableView.snp.makeConstraints{
            $0.top.equalTo(resonView.snp.bottom).offset(0)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(225)
        }
        self.wirteResonView.snp.makeConstraints{
            $0.height.equalTo(216)
            $0.top.equalTo(resonView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
        self.dropDownBtn.snp.makeConstraints{
            $0.height.width.equalTo(24)
            $0.top.equalToSuperview().offset(12)
            $0.trailing.equalToSuperview().offset(-20)
        }
        self.reportInfo.snp.makeConstraints{
            $0.top.equalToSuperview().offset(15)
            $0.leading.equalToSuperview().offset(16)
        }
        self.resonView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(57)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(48)
        }
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
        self.contentView.addSubview(resonView)
        self.resonView.addSubview(reportInfo)
        self.resonView.addSubview(dropDownBtn)
        self.contentView.addSubview(wirteResonView)
        self.contentView.addSubview(dropdownTableView)
    }
    @objc private func reportBtnClick() {
        self.dismiss(animated: false)
    }
    @objc private func dropDownBtnClick() {
        self.dropdownTableView.isHidden = false

    }
    private func reportReson(indexPath: Int)-> String? {
        guard let reson = Na_nez.reportReson(rawValue: indexPath) else {
            return nil
        }
        return reson.reson
    }
    private func configure(){
        self.reportBtn.addTarget(self, action: #selector(reportBtnClick), for: .touchUpInside)
        self.dropDownBtn.addTarget(self, action: #selector(dropDownBtnClick), for: .touchUpInside)
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        self.view.isOpaque = false
        self.wirteResonView.delegate = self
        self.dropdownTableView.dataSource = self
        self.dropdownTableView.delegate = self
        self.dropdownTableView.isHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
        self.addsubView()
        self.layout()
    }
}
extension ReportPopupViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = "\n "
    }
}
extension ReportPopupViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DropDownTableViewCell.identifier ,for: indexPath) as! DropDownTableViewCell
        cell.resonNameLabel.text = reportReson(indexPath: indexPath.row)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dropdownTableView.isHidden = true
        self.reportInfo.text = reportReson(indexPath: indexPath.row)
    }
    
}
