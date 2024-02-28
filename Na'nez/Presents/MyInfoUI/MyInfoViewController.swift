//
//  MyInfoViewController.swift
//  Na'nez
//
//  Created by 최지철 on 2023/07/13.
//

import UIKit
import RxCocoa
import RxSwift
import Kingfisher
import Alamofire

class MyInfoViewController: BaseViewController {
    private let viewModel: MyInfoViewModel
    private let navibar: CustomNaviBar = CustomNaviBar(frame: .zero)
    private let loginYetView: BeforeLoginView = BeforeLoginView(frame: .zero)
    private let loginAfterView: AfterLoginView = AfterLoginView(frame: .zero)
    private let headerView: HeaderView = HeaderView(frame: .zero, title: "고객센터")
    private let disposeBag = DisposeBag()
    
    private let loginInfoSV = UIStackView().then {
        $0.distribution = .fill
        $0.axis = .vertical
    }
    
    private let customerTableView = UITableView(frame: CGRect.zero, style: .grouped).then{
        $0.backgroundColor = .clear
        $0.register(CustomerTableView.self, forCellReuseIdentifier: CustomerTableView.identifier)
        $0.isScrollEnabled = true
        $0.separatorInset = .zero
    }
    
    init(viewModel: MyInfoViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViewBasedOnLoginStatus()
        updateTableViewHeight()
        configure()
        addview()
        layout()
        binding()
    }
    
    override func configure() {
        self.view.addSubview(navibar)
        self.navibar.backBtn.isHidden = true
        self.navibar.searchBtn.isHidden = true
        self.navibar.navititleLabel.text = "내 정보"
        customerTableView.tableHeaderView = headerView
    }
    
    override func addview() {
        self.view.addSubview(navibar)
        self.view.addSubview(loginInfoSV)
        self.view.addSubview(customerTableView)
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
        
        self.customerTableView.snp.makeConstraints {
            $0.top.equalTo(loginInfoSV.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(320)
        }
        
        self.loginYetView.snp.makeConstraints {
            $0.height.equalTo(240)
        }
        
        self.loginAfterView.snp.makeConstraints {
            $0.height.equalTo(280)
        }
        
        self.headerView.snp.makeConstraints {
            $0.height.equalTo(44)
        }
    }

    private func updateTableViewHeight() {
        let cellsCount = AfterCustomerTable.allTexts.count
        let cellHeight = 52
        let totalHeight = cellsCount * cellHeight
        
        customerTableView.snp.updateConstraints {
            $0.height.equalTo(totalHeight)
        }
        self.view.layoutIfNeeded()
    }
    
    override func binding() {
        customerTableView.delegate = nil
        customerTableView.dataSource = nil
        
        let isLoggedInObservable = Observable.just(TokenManager.shared.getAccessToken() != nil)
        let input = MyInfoViewModel.Input(isLoggedIn: isLoggedInObservable)
        let output = viewModel.transform(input: input)
        
        output.tableData
            .drive(customerTableView.rx.items(cellIdentifier: CustomerTableView.identifier, cellType: CustomerTableView.self)) { index, model, cell in
                cell.textLabel?.text = model
            }
            .disposed(by: disposeBag)
        
        output.tableData
            .drive(onNext: { [weak self] _ in
                self?.updateTableViewHeight()
            }).disposed(by: disposeBag)
        
        output.userInfo
            .drive(onNext: { [weak self] userInfo in
                guard let self = self, let userInfo = userInfo else { return }
                
                if let imageURL = URL(string: userInfo.profileImage ?? ""), UIApplication.shared.canOpenURL(imageURL) {
                    self.loginAfterView.accordProfileImage.kf.setImage(with: imageURL)
                }
                else {
                    self.loginAfterView.accordProfileImage.image = UIImage(named: "citus")
                }
                self.loginAfterView.nicknameLabel.text = "\(userInfo.nickname)님 안녕하세요."
                self.loginAfterView.emailLabel.text = userInfo.email
            }).disposed(by: disposeBag)
        
        customerTableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                guard let self = self else { return }
                
                self.customerTableView.deselectRow(at: indexPath, animated: true)
                
                if indexPath.row == AfterCustomerTable.allTexts.count - 1 {
                    self.navigateToSettingVC()
                }
                else if indexPath.row == AfterCustomerTable.allTexts.count - 4 {
                    self.navigateToChangePwVC()
                }
                else {
                    let selectedModel = AfterCustomerTable.allTexts[indexPath.row]
                    print(selectedModel)
                }
            }).disposed(by: disposeBag)
        
        loginYetView.loginBtn.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.navigateToLoginVC()
            }).disposed(by: disposeBag)
    }
    
    private func updateViewBasedOnLoginStatus() {
        let isLoggedIn = TokenManager.shared.getAccessToken() != nil
        loginYetView.isHidden = isLoggedIn
        loginAfterView.isHidden = !isLoggedIn
        
        if isLoggedIn {
            loginInfoSV.removeArrangedSubview(loginYetView)
            loginYetView.removeFromSuperview()
            loginInfoSV.addArrangedSubview(loginAfterView)
        }
        else {
            loginInfoSV.removeArrangedSubview(loginAfterView)
            loginAfterView.removeFromSuperview()
            loginInfoSV.addArrangedSubview(loginYetView)
        }
    }
    
    private func navigateToChangePwVC() {
        if let viewControllers = self.navigationController?.viewControllers {
            for viewController in viewControllers {
                if viewController is ChangePwViewController {
                    return
                }
            }
        }
        
        let changePwVC = ChangePwViewController()
        changePwVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(changePwVC, animated: true)
    }
    
    private func navigateToLoginVC() {
        if let viewControllers = self.navigationController?.viewControllers {
            for viewController in viewControllers {
                if viewController is RecommendLoginViewController {
                    return
                }
            }
        }
        
        let recommendLoginVC = RecommendLoginViewController()
        recommendLoginVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(recommendLoginVC, animated: true)
    }
    
    private func navigateToSettingVC() {
        if let vcs = self.navigationController?.viewControllers {
            for vc in vcs {
                if vc is SettingViewController {
                    return
                }
            }
        }
        
        let settingVC = SettingViewController()
        settingVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(settingVC, animated: true)
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
