//
//  HomeCategoryViewController.swift
//  sello
//
//

import RxSwift
import RxCocoa
import UIKit
import PinLayout

final class HomeCategoryScreenBuilder: ScreenBuilder {
    typealias VC = HomeCategoryViewController
    
    var dependencies: VC.ViewModel.Dependencies {
        VC.ViewModel.Dependencies(
            authService: AuthService()
        )
    }
}

final class HomeCategoryViewController: UIViewController {
    
    typealias Constants = HomeCategoryViewModel.Constants
    lazy private var ui = configureUI()
    private let disposeBag = DisposeBag()
    private let didSelectItem = PublishRelay<IndexPath>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ui.backView.pin
            .top()
            .horizontally()
            .height(Constants.height)
        
        ui.findInput.pin
            .left(Constants.margin)
            .top(Constants.marginTop)
            .width(80%)
            .height(Constants.inputHeight)
        
        ui.filterButton.pin
            .right(of: ui.findInput, aligned: .center)
            .marginLeft(Constants.margin)
            .size(CGSize(
                width: Constants.imageSize,
                height: Constants.imageSize
            ))
        
        ui.collectionView.pin
            .below(of: ui.findInput)
            .marginTop(Constants.margin)
            .left(Constants.marginLeft)
            .width(view.bounds.width)
            .height(Constants.collectionViewHeight)
        
        setGradientBackground(view: ui.backView)
    }
}

extension HomeCategoryViewController: ViewType {
    typealias ViewModel = HomeCategoryViewModel
    
    var bindings: ViewModel.Bindings {
        .init(
            didTapSubmitButton: .empty()
        )
    }
    
    func bind(to viewModel: ViewModel) {
        //TODO: переделать на запрос, когда сделаю бекенд
        let collectionViewConfig = ui.collectionView
            .bind(.init(items: [
                .init(
                    nameLabel: "Все категории",
                    iconImage: R.image.group() ?? UIImage()
                ),
                .init(
                    nameLabel: "Транспорт",
                    iconImage: R.image.car() ?? UIImage()
                ),
                .init(
                    nameLabel: "Работа",
                    iconImage: R.image.portfolio() ?? UIImage()
                ),
                .init(
                    nameLabel: "Недвижимость",
                    iconImage: R.image.home() ?? UIImage()
                    
                ),
                .init(
                    nameLabel: "Животные",
                    iconImage: R.image.pet() ?? UIImage()
                ),
                .init(
                    nameLabel: "Все категории",
                    iconImage: R.image.group() ?? UIImage()
                )
            ]))
        
        collectionViewConfig.didSelectItem
            .emit(to: didSelectItem)
            .disposed(by: disposeBag)  
    }
}

private extension HomeCategoryViewController {
    
    struct UI {
        let backView: UIView
        let findInput: UITextField
        let filterButton: UIButton
        let collectionView: HomeCategoryCollectionView
    }
    
    func configureUI() -> UI {
        
        let backView = UIView().setup {
            view.addSubview($0)
        }
        
        let findInput = UITextField().setup {
            $0.backgroundColor = #colorLiteral(red: 0.1305944026, green: 0.4178622067, blue: 0.897249043, alpha: 1)
            $0.layer.cornerRadius = 20.0
            $0.attributedPlaceholder = NSAttributedString(
                string: R.string.localizable.category_find_input_placeholder(),
                attributes: [
                    .foregroundColor : UIColor(ciColor: .white)
                ])
            $0.font = .systemRegular13
            $0.leftView = UIView(frame: .init(
                x: 0,
                y: 0,
                width: 20,
                height: 50
            ))
            $0.leftViewMode = .always
            backView.addSubview($0)
        }
        
        let filterButton = UIButton().setup {
            $0.setImage(R.image.burger(), for: .normal)
            backView.addSubview($0)
        }
        
        let layout = UICollectionViewFlowLayout().setup {
            $0.scrollDirection = .horizontal
        }
        
        let collectionView = HomeCategoryCollectionView(
            frame: .init(),
            collectionViewLayout: layout
        ).setup {
            $0.backgroundColor = .clear
            $0.showsVerticalScrollIndicator = false
            $0.register(
                HomeCategoryCell.self,
                forCellWithReuseIdentifier: HomeCategoryCell.self.id
            )
            backView.addSubview($0)
        }
        
        return UI(
            backView: backView,
            findInput: findInput,
            filterButton: filterButton,
            collectionView: collectionView
        )
    }
}

private extension HomeCategoryViewController {
    
    func setGradientBackground(view: UIView) {
        let gradientLayer = CAGradientLayer().configMainBackground(view: view)
        gradientLayer.frame = view.bounds
        view.clipsToBounds = true
        view.layer.cornerRadius = 30.0
        view.layer.maskedCorners = [.layerMaxXMaxYCorner]
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
}
