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
    
    private var nicknameVC: NicknameViewController?
    private var selectEmailVC: SelectEmailViewController?
    private var passwordVC: PasswordViewController?
    private var surveyVC: SurveyViewController?
    private var surveyViewModel: SurveyViewModel?
    private var termsConditionVC: TermsConditionViewController?
    private var termsConditionViewModel: TermsConditionViewModel?
    
    private var nickname: String?
    private var email: String?
    private var password: String?
    private var accordId: Int?
    private var isAccepted: Bool?

    init(couponViewModel: CouponViewModel, surveyViewModel: SurveyViewModel) {
        self.couponViewModel = couponViewModel
        self.surveyViewModel = surveyViewModel
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
    }
    
    private func configure() {
        view.addSubview(couponView)
        couponView.translatesAutoresizingMaskIntoConstraints = false
        
        couponView.snp.makeConstraints {
            $0.top.left.right.bottom.equalToSuperview()
        }
        
        let nicknameRP = NicknameRepository(nicknameVerifyService: NicknameVerifyService())
        let nicknameUC = NicknameUseCase(repository: nicknameRP)
        let nicknameVM = NicknameViewModel(useCase: nicknameUC)
        nicknameVC = NicknameViewController(viewModel: nicknameVM)
        
        let selectEmailRP = SelectEmailRepository(emailSendService: EmailSendService(), emailVerifyService: EmailVerifyService())
        let selectEmailUC = SelectEmailUseCase(repository: selectEmailRP)
        let selectEmailVM = SelectEmailViewModel(useCase: selectEmailUC)
        selectEmailVC = SelectEmailViewController(viewModel: selectEmailVM)
        
        passwordVC = PasswordViewController()
        
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
        guard let nicknameVC = nicknameVC else { return }
        nicknameVC.nicknameObservable
            .subscribe(onNext: { [weak self] newNickname in
                self?.nickname = newNickname
                print("Nickname: \(newNickname)")
            }).disposed(by: disposeBag)
        
        guard let selectEmailVC = selectEmailVC else { return }
        selectEmailVC.emailObservable
            .subscribe(onNext: { [weak self] newEmail in
                self?.email = newEmail
                print("Email: \(newEmail)")
            }).disposed(by: disposeBag)
        
        guard let passwordVC = passwordVC else { return }
        passwordVC.passwordObservable
            .subscribe(onNext: { [weak self] newPassword in
                self?.password = newPassword
                print("Password: \(newPassword)")
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
//        alertView.messageLabel.textColor = .red
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

