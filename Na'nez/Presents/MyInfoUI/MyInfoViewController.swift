//
//  MyInfoViewController.swift
//  Na'nez
//
//  Created by 최지철 on 2023/07/13.
//

import UIKit
import RxCocoa
import RxSwift

class MyInfoViewController: BaseViewController {
    private let viewModel: MyInfoViewModel
    private let navibar: CustomNaviBar = CustomNaviBar(frame: .zero)
    private let loginYetView: BeforeLoginView = BeforeLoginView(frame: .zero)
    private let loginAfterView: AfterLoginView = AfterLoginView(frame: .zero)
    private let headerView: HeaderView = HeaderView(frame: .zero, title: "고객센터")
    
    private let loginInfoSV = UIStackView().then {
        $0.distribution = .fill
        $0.axis = .vertical
    }
    
    private let customerTabelView = UITableView(frame: CGRect.zero, style: .grouped).then{
        $0.backgroundColor = .clear
        $0.register(CustomerTabelView.self, forCellReuseIdentifier: CustomerTabelView.identifier)
        $0.isScrollEnabled = false
        $0.separatorInset = .zero
    }
    
    init(viewModel: MyInfoViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configure() {
        self.view.addSubview(navibar)
        self.navibar.backBtn.isHidden = true
        self.navibar.searchBtn.isHidden = true
        self.navibar.navititleLabel.text = "내 정보"
        customerTabelView.tableHeaderView = headerView
        self.customerTabelView.delegate = self
    }
    
    override func addview() {
        self.view.addSubview(navibar)
        self.view.addSubview(loginInfoSV)
//        self.loginInfoSV.addArrangedSubview(loginYetView)
        self.loginInfoSV.addArrangedSubview(loginAfterView)
        self.view.addSubview(customerTabelView)
    }
    
    override func layout() {
        navibar.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(0)
            $0.width.equalToSuperview().offset(0)
            $0.height.equalTo(52)
        }
        
        self.loginInfoSV.snp.makeConstraints {
            $0.top.equalTo(navibar.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
        
        self.customerTabelView.snp.makeConstraints {
            $0.top.equalTo(loginInfoSV.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(312)
        }
        
        self.loginYetView.snp.makeConstraints {
            $0.height.equalTo(240)
        }
        
        self.loginAfterView.snp.makeConstraints {
            $0.height.equalTo(240)
        }
        
        self.headerView.snp.makeConstraints {
            $0.height.equalTo(44)
        }
    }
    
    override func binding() {
        let input = MyInfoViewModel.Input()
        let output = viewModel.transform(input: input)
        
        output.tableData
             .drive(customerTabelView.rx.items(cellIdentifier: CustomerTabelView.identifier,
                                               cellType: CustomerTabelView.self)) { index, model, cell in
                 cell.textLabel?.text = model
             }
             .disposed(by: disposebag)
        
        customerTabelView.rx.itemSelected
             .map { indexPath in
                 return try? self.customerTabelView.rx.model(at: indexPath) as String
             }
             .bind(onNext: { [weak self] selectedModel in
                 if let selectedModel = selectedModel {
                     print(selectedModel)
                 }
             })
             .disposed(by: disposebag)
        
        loginYetView.loginBtn.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.navigateToLoginVC()
            }).disposed(by: disposebag)
    }
    
    private func navigateToLoginVC() {
        let recommendLoginVC = RecommendLoginViewController()
        recommendLoginVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(recommendLoginVC, animated: true)
    }
    
}

extension MyInfoViewController: CustomNaviBarDelegate{
    func backBtnClick(_ navibar: CustomNaviBar) {
        
    }
    func searchBtnClick(_ navibar: CustomNaviBar) {
        
    }
}

extension MyInfoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 52
    }
}

extension MyInfoViewController {
    private func pushPerfumeRegister() {
        let vc = PerfumeRegisterViewController()
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
