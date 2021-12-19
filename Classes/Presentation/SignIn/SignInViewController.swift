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

final class SignInViewController: SEViewController {
    lazy private var ui = configureUI()
    private let disposeBag = DisposeBag()
    
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
            .width(ui.logoLabel.bounds.width - 40)
            .height(50)
        
        ui.passwordInput.pin
            .below(of: ui.usernameInput, aligned: .left)
            .marginTop(20)
            .width(ui.logoLabel.bounds.width - 40)
            .height(ui.usernameInput.bounds.height)
        
        ui.backViewSubmitButton.pin
            .below(of: ui.passwordInput, aligned: .left)
            .marginTop(20)
            .width(ui.logoLabel.bounds.width - 40)
            .height(ui.usernameInput.bounds.height)
        
        ui.submitButton.pin
            .width(ui.logoLabel.bounds.width - 40)
            .height(ui.usernameInput.bounds.height)
        
        ui.containerStackView.pin
            .hCenter()
            .below(of: ui.submitButton)
            .marginTop(32)
            .width(50%)
            .height(40)
        
        setGradientBackground(view: ui.backView)
        setButtonGradientBackground(view: ui.backViewSubmitButton)
    }
}

extension SignInViewController: ViewType {
    typealias ViewModel = SignInViewModel
    
    var bindings: ViewModel.Bindings {
        return .init(didTapSubmitButton: ui.submitButton.rx.tap.asSignal().map { _ in
            SignInViewModel.Inputs.init(login: .just(.empty), password: .just(.empty))
        })
    }
    
    func bind(to viewModel: ViewModel) {
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
            $0.text = R.string.localizable.sign_inView_title()
            $0.font = .systemMedium150
            $0.textColor = .white
            backView.addSubview($0)
        }
        
        let usernameInput = UITextField().setup {
            $0.backgroundColor = .white
            $0.layer.cornerRadius = 20.0
            $0.placeholder = R.string.localizable.sign_in_login_placeholder()
            $0.font = .systemRegular15
            $0.leftView = UIView(frame: .init(x: 0, y: 0, width: 10, height: 50))
            $0.leftViewMode = .always
            backView.addSubview($0)
        }
        
        let passwordInput = UITextField().setup {
            $0.backgroundColor = .white
            $0.layer.cornerRadius = 20.0
            $0.placeholder = R.string.localizable.sign_in_password_placeholder()
            $0.font = .systemRegular15
            $0.leftView = UIView(frame: .init(x: 0, y: 0, width: 10, height: 50))
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
