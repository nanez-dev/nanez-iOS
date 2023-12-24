//
//  TermsConditionViewController.swift
//  Na'nez
//
//  Created by KIM Hyung Jun on 11/24/23.
//

import UIKit
import RxSwift
import RxCocoa
import SafariServices

class TermsConditionViewController: UIViewController {
    private let termsConditionView: TermsConditionView = TermsConditionView(frame: .zero)
    private let viewModel: TermsConditionViewModel
    private let disposeBag = DisposeBag()
    
    var marketingAgreementObservable: Observable<Bool> {
        return viewModel.isMarketingAgreement.asObservable()
    }
    
    init(viewModel: TermsConditionViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
            
        self.view.addSubview(termsConditionView)
        self.navigationItem.hidesBackButton = true
                
        configure()
        bindViewModel()
    }
    
    private func configure() {
        termsConditionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.bottom.leading.trailing.equalToSuperview()
        }
        view.backgroundColor = .white
    }
    
    private func bindViewModel() {
        
        termsConditionView.backButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.dismiss(animated: true, completion: nil)
            }).disposed(by: disposeBag)
        
        termsConditionView.checkboxButton1.rx.tap
            .bind(to: viewModel.inputServiceAgreement)
            .disposed(by: disposeBag)
        
        termsConditionView.checkboxButton2.rx.tap
            .bind(to: viewModel.inputPrivacyAgreement)
            .disposed(by: disposeBag)
        
        termsConditionView.checkboxButton3.rx.tap
            .bind(to: viewModel.inputMarketingAgreement)
            .disposed(by: disposeBag)

        termsConditionView.agreeTitle.rx.tap
            .flatMapLatest { [weak self] _ -> Observable<TermsAgreement> in
                guard let self = self else { return .empty() }
                return self.viewModel.agreementStatus().take(1)
            }
            .map { agreement in
                return !(agreement.isServiceTermsAgreed && agreement.isPrivacyTermsAgreed && agreement.isMarketingAgreed)
            }
            .bind(to: viewModel.inputAllAgreements)
            .disposed(by: disposeBag)
        
        termsConditionView.agreeButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                guard let self = self, self.termsConditionView.agreeButton.isEnabled else { return }
                print("동의합니다")
                
                showSelectEmailVC()
            }).disposed(by: disposeBag)
        
        viewModel.agreementStatus()
            .subscribe(onNext: { [weak self] agreement in
                
                let checkMarkImage = UIImage(named: "checkMark")
                let unCheckMarkImage = UIImage(named: "unCheckMark")
                
                let allAgreed = agreement.isServiceTermsAgreed && agreement.isPrivacyTermsAgreed && agreement.isMarketingAgreed
                
                self?.termsConditionView.checkboxButton1.setImage(agreement.isServiceTermsAgreed ? checkMarkImage : unCheckMarkImage, for: .normal)
                self?.termsConditionView.checkboxButton2.setImage(agreement.isPrivacyTermsAgreed ? checkMarkImage : unCheckMarkImage, for: .normal)
                self?.termsConditionView.checkboxButton3.setImage(agreement.isMarketingAgreed ? checkMarkImage : unCheckMarkImage, for: .normal)
                self?.termsConditionView.agreeTitle.setImage(allAgreed ? checkMarkImage : unCheckMarkImage, for: .normal)
                
                let requiredAgreed = agreement.isServiceTermsAgreed && agreement.isPrivacyTermsAgreed
                self?.termsConditionView.agreeButton.isEnabled = allAgreed
                self?.termsConditionView.agreeButton.backgroundColor = allAgreed ? UIColor(named: "mainturquoise") : #colorLiteral(red: 0.8588235378, green: 0.8588235378, blue: 0.8588235378, alpha: 1)
                self?.termsConditionView.agreeButton.isEnabled = requiredAgreed
                self?.termsConditionView.agreeButton.backgroundColor = requiredAgreed ? UIColor(named: "mainturquoise") : #colorLiteral(red: 0.8588235378, green: 0.8588235378, blue: 0.8588235378, alpha: 1)
            }).disposed(by: disposeBag)
        
        termsConditionView.selectButton1.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.openWebPage(urlString: "https://nanez.notion.site/Na-nez-3d1026fa415d44f2afb456bc24bbf6dc")
            }).disposed(by: disposeBag)
        
        termsConditionView.selectButton2.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.openWebPage(urlString: "https://nanez.notion.site/Na-nez-ba8a5a47341a455ba26cbb3807be2585")
            }).disposed(by: disposeBag)
        
        termsConditionView.selectButton3.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.openWebPage(urlString: "https://nanez.notion.site/Na-nez-SNS-3f74db9bc4d64415ba2d775268290a8c")
            }).disposed(by: disposeBag)
    }

    
    private func openWebPage(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let safariViewController = SFSafariViewController(url: url)
        self.present(safariViewController, animated: true, completion: nil)
    }
    
    private func showSelectEmailVC() {
        let selectEmailRepository = SelectEmailRepository(emailSendService: EmailSendService(), emailVerifyService: EmailVerifyService())
        let selectEmailUseCase = SelectEmailUseCase(repository: selectEmailRepository)
        let viewModel = SelectEmailViewModel(useCase: selectEmailUseCase)
        let selectEmailVC = SelectEmailViewController(viewModel: viewModel)
        selectEmailVC.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        selectEmailVC.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.present(selectEmailVC, animated: true, completion: nil)
    }
}


