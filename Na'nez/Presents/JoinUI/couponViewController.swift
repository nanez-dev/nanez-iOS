//
//  CouponViewController.swift
//  Na'nez
//
//  Created by KIM Hyung Jun on 12/8/23.
//

import UIKit
import SnapKit
import Then
import RxSwift

class CouponViewController: UIViewController {
    private let couponView = CouponView()
    private let couponViewModel: CouponViewModel
    private let disposeBag = DisposeBag()
    
    private var surveyVC: SurveyViewController?
    private var surveyViewModel: SurveyViewModel?
    private var termsConditionVC: TermsConditionViewController?
    private var termsConditionViewModel: TermsConditionViewModel?
    
    var sharedViewModel: SharedViewModel!
    
    private var nickname: String?
    private var email: String?
    private var password: String?
    private var accordId: Int?
    private var isAccepted: Bool?

    init(couponViewModel: CouponViewModel, surveyViewModel: SurveyViewModel, sharedViewModel: SharedViewModel) {
        self.couponViewModel = couponViewModel
        self.surveyViewModel = surveyViewModel
        self.sharedViewModel = sharedViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "회원가입"
        
        configure()
        setupBinding()
        setupBinding2()
        setupViewModelBinding()
    }
    
    private func configure() {
        view.addSubview(couponView)
        couponView.translatesAutoresizingMaskIntoConstraints = false
        
        couponView.snp.makeConstraints {
            $0.top.left.right.bottom.equalToSuperview()
        }

        surveyVC = SurveyViewController()
        let termsConditionRP = TermsRepository()
        let termsConditionUC = TermsUseCase(repository: termsConditionRP)
        let termsConditionVM = TermsConditionViewModel(termsUseCase: termsConditionUC)
        termsConditionVC = TermsConditionViewController(viewModel: termsConditionVM)
    }
    
    private func setupBinding() {
        couponView.backButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.dismiss(animated: true, completion: nil)
            }).disposed(by: disposeBag)
        
        couponView.codeTextField.rx.text.orEmpty
            .distinctUntilChanged()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] text in
                let isEmpty = text.isEmpty
                let color = isEmpty ? #colorLiteral(red: 0.8588235378, green: 0.8588235378, blue: 0.8588235378, alpha: 1) : NicknameView.mainturquoise
                self?.couponView.checkButton.backgroundColor = color
                self?.couponView.checkButton.isEnabled = !isEmpty
                
                self?.couponView.canMatchLabel.isHidden = true
            }).disposed(by: disposeBag)
        
        
        couponView.skipButton.rx.tap
            .flatMapLatest { [weak self] _ -> Observable<SignUpDTO> in
                guard let self = self,
                      let nickname = self.nickname,
                      let email = self.email,
                      let password = self.password,
                      let accordId = self.accordId,
                      let isAccepted = self.isAccepted
                else {
                    return Observable.just(SignUpDTO(
                        nickname: "",
                        email: "",
                        password: "",
                        gender: "",
                        ageGroup: 0,
                        referCode: "",
                        accordId: 0,
                        isAccepted: false,
                        profileImage: ""
                    ))
                }
                
                print("nickname: \(nickname ?? nil)")
                print("email: \(email ?? nil)")
                print("password: \(password ?? nil)")
                print("accordId: \(accordId ?? nil)")
                print("isAccepted: \(isAccepted ?? nil)")
                
                let dto = SignUpDTO(
                    nickname: nickname,
                    email: email,
                    password: password,
                    gender: "-",
                    ageGroup: 0,
                    referCode: "",
                    accordId: accordId,
                    isAccepted: isAccepted,
                    profileImage: ""
                )
                return Observable.just(dto)
            }
            .subscribe(onNext: { [weak self] dto in
                self?.couponViewModel.signUp(dto: dto)
            }).disposed(by: disposeBag)
    }
    
    private func setupBinding2() {
        sharedViewModel.nicknameRelay
            .asObservable()
            .subscribe(onNext: { [weak self] nickname in
                if let nickname = nickname {
                    self?.nickname = nickname
                    print("Received nickname: \(nickname)")
                }
            }).disposed(by: disposeBag)
        
        sharedViewModel.emailRelay
            .asObservable()
            .subscribe(onNext: { [weak self] email in
                if let email = email {
                    self?.email = email
                    print("Received email: \(email)")
                }
            }).disposed(by: disposeBag)
        
        sharedViewModel.passwordRelay
            .asObservable()
            .subscribe(onNext: { [weak self] password in
                if let password = password {
                    self?.password = password
                    print("Received password: \(password)")
                }
            }).disposed(by: disposeBag)
        
        surveyViewModel?.selectedButtonId
            .subscribe(onNext: { [weak self] id in
                guard let strongSelf = self, let unwrappedId = id else { return }
                strongSelf.accordId = Int(unwrappedId)
                print("Accord Id: \(unwrappedId)")
            }).disposed(by: disposeBag)
        
        guard let termsConditionVC = termsConditionVC else { return }
        termsConditionVC.marketingAgreementObservable
            .subscribe(onNext: { [weak self] isMarketingAgreed in
                self?.isAccepted = isMarketingAgreed
                print("Marketing Agreed: \(isMarketingAgreed)")
            }).disposed(by: disposeBag)
    }
    
    private func setupViewModelBinding() {
        couponViewModel.signUpSuccess
            .subscribe(onNext: { [weak self] _ in
                self?.showSuccessAlert()
            }).disposed(by: disposeBag)
    }
    
    private func showSuccessAlert() {
        let alertView = CustomAlertView()
        alertView.configure(message: "축하합니다! 회원가입에 성공하셨습니다!", actionButtonTitle: "확인")
        alertView.onActionButotnTapped = {
            alertView.dismiss()
            self.navigateToLoginVC()
        }
        alertView.show(on: self.view)
    }
    
    private func navigateToLoginVC() {
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }

    private func showSameAlert() {
        let alertView = CustomAlertView()
        alertView.configure(message: "확인이 완료되었습니다.", actionButtonTitle: "확인")
        alertView.onActionButotnTapped = {
            alertView.dismiss()
        }
        alertView.show(on: self.view)
    }
    
    private func showInconsistencyAlert() {
        let alertView = CustomAlertView()
        alertView.configure(message: "일치하는 쿠폰 코드가 없습니다.", actionButtonTitle: "확인")
        alertView.onActionButotnTapped = {
            alertView.dismiss()
        }
        alertView.show(on: self.view)
    }
    
    private func handleCouponValidation(isValid: Bool) {
        if isValid {
            print("쿠폰이 등록되었습니다.")
            self.couponView.codeTextField.layer.borderColor = #colorLiteral(red: 0.2625362277, green: 0.6258890629, blue: 0.9609254003, alpha: 1)
            self.couponView.codeTextField.layer.borderWidth = 1
            self.couponView.nextButton.isEnabled = true
            self.couponView.nextButton.backgroundColor = CouponView.mainturquoise
        }
        else {
            print("사용 불가능한 쿠폰입니다.")
            self.couponView.codeTextField.layer.borderColor = UIColor.red.cgColor
            self.couponView.codeTextField.layer.borderWidth = 1
            self.couponView.nextButton.isEnabled = false
            self.couponView.nextButton.backgroundColor = #colorLiteral(red: 0.8588235378, green: 0.8588235378, blue: 0.8588235378, alpha: 1)
        }
    }
}
