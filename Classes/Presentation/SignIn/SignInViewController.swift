//
//  SignInViewController.swift
//  sello
//
//  Created by user on 28.11.2021.
//

import RxSwift
import RxCocoa
import UIKit
import PinLayout

final class SignInScreenBuilder: ScreenBuilder {
    typealias VC = SignInViewController
    
    var dependencies: VC.ViewModel.Dependencies {
        VC.ViewModel.Dependencies(
            authService: AuthService()
        )
    }
}

final class SignInViewController: UIViewController {
    
    lazy private var ui = configureUI()
    private let disposeBag = DisposeBag()
    private let didTapSubmitButton = BehaviorRelay<SignInViewModel.Inputs?>(value: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ui.backView.pin
            .all()
        
        ui.logoLabel.pin
            .hCenter()
            .top(20%)
            .sizeToFit()
        
        ui.usernameInput.pin
            .hCenter()
            .below(of: ui.logoLabel)
            .width(ui.logoLabel.bounds.width - Constants.widthMargin)
            .height(Constants.height)
        
        ui.passwordInput.pin
            .below(of: ui.usernameInput, aligned: .left)
            .marginTop(Constants.marginTop)
            .width(ui.logoLabel.bounds.width - Constants.widthMargin)
            .height(ui.usernameInput.bounds.height)
        
        ui.backViewSubmitButton.pin
            .below(of: ui.passwordInput, aligned: .left)
            .marginTop(Constants.marginTop)
            .width(ui.logoLabel.bounds.width - Constants.widthMargin)
            .height(ui.usernameInput.bounds.height)
        
        ui.submitButton.pin
            .width(ui.logoLabel.bounds.width - Constants.widthMargin)
            .height(ui.usernameInput.bounds.height)
        
        ui.containerStackView.pin
            .hCenter()
            .below(of: ui.submitButton)
            .marginTop(Constants.extraMarginTop)
            .width(50%)
            .height(Constants.height)
        
        setGradientBackground(view: ui.backView)
        setButtonGradientBackground(view: ui.backViewSubmitButton)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}

extension SignInViewController: ViewType {
    typealias ViewModel = SignInViewModel
    
    var bindings: ViewModel.Bindings {
        .init(
            didTapSubmitButton: didTapSubmitButton
                .asSignal(onErrorSignalWith: .empty())
                .compactMap { $0 }
        )
    }
    
    func bind(to viewModel: ViewModel) {
        
        ui.submitButton.rx.tap
            .asSignal(onErrorSignalWith: .empty())
            .withLatestFrom(Signal.combineLatest(
                ui.usernameInput.rx.value
                    .changed
                    .asSignal(),
                ui.passwordInput.rx.value
                    .changed
                    .asSignal()
            )
            .compactMap { SignInViewModel.Inputs(login: $0, password: $1) })
            .emit(to: didTapSubmitButton)
            .disposed(by: disposeBag)
        
        viewModel.validatedCredentials
            .emit(onNext: { _ in
                let vc = MainTabBarScreenBuilder().build(())
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
    }
}

private extension SignInViewController {
    
    struct UI {
        let backView: UIView
        let logoLabel: UILabel
        let usernameInput: UITextField
        let passwordInput: UITextField
        let submitButton: UIButton
        let backViewSubmitButton: UIView
        let containerStackView: UIStackView
    }
    
    func configureUI() -> UI {
        
        let backView = UIView().setup {
            $0.backgroundColor = .clear
            view.addSubview($0)
        }
        
        let logoLabel = UILabel().setup {
            $0.text = R.string.localizable.sign_in_view_title()
            $0.font = .systemMedium150
            $0.textColor = .white
            backView.addSubview($0)
        }
        
        let usernameInput = UITextField().setup {
            $0.backgroundColor = .white
            $0.layer.cornerRadius = 20.0
            $0.placeholder = R.string.localizable.sign_in_login_placeholder()
            $0.font = .systemRegular15
            $0.leftView = UIView(frame: .init(
                x: 0,
                y: 0,
                width: Constants.spaceWidth,
                height: Constants.height
            ))
            $0.leftViewMode = .always
            backView.addSubview($0)
        }
        
        let passwordInput = UITextField().setup {
            $0.backgroundColor = .white
            $0.layer.cornerRadius = 20.0
            $0.placeholder = R.string.localizable.sign_in_password_placeholder()
            $0.font = .systemRegular15
            $0.leftView = UIView(frame: .init(
                x: 0,
                y: 0,
                width: Constants.spaceWidth,
                height: Constants.height
            ))
            $0.leftViewMode = .always
            backView.addSubview($0)
        }
        
        let faceBookButton = UIButton().setup {
            $0.setImage(R.image.facebook(), for: .normal)
            backView.addSubview($0)
        }

        let googleButton = UIButton().setup {
            $0.setImage(R.image.google(), for: .normal)
            backView.addSubview($0)
        }

        let telegramButton = UIButton().setup {
            $0.setImage(R.image.telegramm(), for: .normal)
            backView.addSubview($0)
        }

        let instagramButton = UIButton().setup {
            $0.setImage(R.image.instagramm(), for: .normal)
            backView.addSubview($0)
        }
        
        let containerStackView = UIStackView(
            arrangedSubviews: [
                faceBookButton,
                googleButton,
                telegramButton,
                instagramButton
            ]
        ).setup {
            $0.axis = .horizontal
            $0.alignment = .center
            $0.distribution = .fillEqually
            $0.spacing = 4.0

            backView.addSubview($0)
        }
        
        let backViewSubmitButton = UIView().setup {
            backView.addSubview($0)
        }
        
        let submitButton = UIButton().setup {
            $0.setTitle(
                R.string.localizable.sign_in_button_title(),
                for: .normal
            )
            backViewSubmitButton.addSubview($0)
        }
        
        return UI(
            backView: backView,
            logoLabel: logoLabel,
            usernameInput: usernameInput,
            passwordInput: passwordInput,
            submitButton: submitButton,
            backViewSubmitButton: backViewSubmitButton,
            containerStackView: containerStackView
        )
    }
}

private extension SignInViewController {
    
    func setGradientBackground(view: UIView) {
        let gradientLayer = CAGradientLayer().configMainBackground(view: view)
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func setButtonGradientBackground(view: UIView) {
        let gradientLayer = CAGradientLayer().configMainBackground(view: view)
        gradientLayer.frame = view.bounds
        gradientLayer.cornerRadius = 20.0
        gradientLayer.shadowOpacity = 0.3
        gradientLayer.shadowRadius = 20.0
        gradientLayer.shadowColor = UIColor.black.cgColor
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
}

private extension SignInViewController {
    enum Constants {
        static let widthMargin: CGFloat = 40
        static let marginTop: CGFloat = 20
        static let extraMarginTop: CGFloat = 32
        static let height: CGFloat = 50
        static let spaceWidth: CGFloat = 20
    }
}
