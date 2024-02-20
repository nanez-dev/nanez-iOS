//
//  SettingViewController.swift
//  Na'nez
//
//  Created by KIM Hyung Jun on 2/19/24.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

class SettingViewController: UIViewController {
    private let disposeBag = DisposeBag()
    
    let backButton = UIButton().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setImage(UIImage(named: "Nan'Nez_Back"), for: .normal)
        $0.contentMode = .scaleAspectFit
    }
    
    let topTitleLabel = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "설정"
        $0.textColor = .black
        $0.font = UIFont(name: "SUIT-Bold", size: 18)
        $0.textAlignment = .center
    }
    
    let navigationView = UIView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let mainLabel = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "설정"
        $0.font = UIFont.boldSystemFont(ofSize: 20)
        $0.textColor = .black
    }
    
    private let settingTableView = UITableView(frame: CGRect.zero, style: .grouped).then {
        $0.backgroundColor = .clear
        $0.register(SettingTableView.self, forCellReuseIdentifier: SettingTableView.identifier)
        $0.isSpringLoaded = false
        $0.separatorInset = .zero
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        settingTableView.dataSource = self
        settingTableView.delegate = self
        setupSettingView()
        setupBinding()
    }
    
    private func setupSettingView() {
        view.addSubview(navigationView)
        navigationView.addSubview(backButton)
        navigationView.addSubview(topTitleLabel)
        view.addSubview(mainLabel)
        view.addSubview(settingTableView)
        
        navigationView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(60)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(44)
        }
        
        backButton.snp.makeConstraints {
            $0.left.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(10)
            $0.size.equalTo(CGSize(width: 24, height: 24))
        }
        
        topTitleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(backButton.snp.bottom).offset(1)
        }
        
        mainLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalTo(navigationView.snp.bottom).offset(50)
            $0.trailing.equalToSuperview().offset(-47)
        }
        
        
        settingTableView.snp.makeConstraints {
            $0.top.equalTo(mainLabel.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    private func setupBinding() {
        backButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.navigationController?.popViewController(animated: true)
            }).disposed(by: disposeBag)
        
        settingTableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                guard let self = self else { return }
                
                if indexPath.row == SettingTable.allTexts.count - 2 {
                    self.logout()
                }
                else if indexPath.row == SettingTable.allTexts.count - 1 {
                    print("회원탈퇴 버튼")
                }
            }).disposed(by: disposeBag)
    }
    
    private func logout() {
        TokenManager.shared.logout()
        navigateToMyInfoVC()
    }
    
    private func navigateToMyInfoVC() {
        let myInfoVC = MyInfoViewController(viewModel: MyInfoViewModel())
        myInfoVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(myInfoVC, animated: true)
    }
}

extension SettingViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SettingTable.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableView.identifier, for: indexPath) as! SettingTableView
        let item = SettingTable.allCases[indexPath.row]
        cell.configureCell(item)
        
        return cell
    }
}
