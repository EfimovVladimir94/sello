//
//  MyProductsViewController.swift
//  sello
//
//

import RxSwift
import RxCocoa
import UIKit
import PinLayout

final class MyProductsScreenBuilder: ScreenBuilder {
    typealias VC = MyProductsViewController
    
    var dependencies: VC.ViewModel.Dependencies {
        VC.ViewModel.Dependencies(productsService: ProductsService())
    }
}

final class MyProductsViewController: UIViewController {
    
    lazy private var ui = configureUI()
    private let disposeBag = DisposeBag()
    let didSelectItem = PublishRelay<IndexPath>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ui.segmentControl.pin
            .top(Constants.margin)
            .horizontally(Constants.margin)
            .height(Constants.margin)
        
        ui.collectionView.pin
            .below(of:  ui.segmentControl)
            .marginTop(Constants.margin)
            .horizontally()
            .bottom()
        
        ui.collectionView.contentInset = .make(
            top: Constants.marginTop,
            bottom: Constants.contentInset
        )
        
        ui.submitButton.pin
            .hCenter()
            .bottom(Constants.bottomMargin)
            .width(70%)
            .height(Constants.buttomHeight)
        
        setButtonGradientBackground(view: ui.submitButton)
    }
}

extension MyProductsViewController: ViewType {
    typealias ViewModel = MyProductsViewModel
    
    var bindings: ViewModel.Bindings {
        .init()
    }
    
    func bind(to viewModel: ViewModel) {
        
        let selectedItem = viewModel.items
            .flatMap { [weak self] products -> Signal<IndexPath> in
                self?.ui.collectionView
                    .bind(.init(items: [
                        .init(
                            image: R.image.demo(),
                            title: "Щенок немецкой овчарки",
                            subTitle: "3000₾",
                            description: "Тбилиси, Ваке. 10 ноября, 14:21",
                            rightImage: nil
                        ),
                        .init(
                            image: R.image.demo1(),
                            title: "Клетка для грызунов",
                            subTitle: "3000₾",
                            description: "Тбилиси, Ваке. 10 ноября, 14:21",
                            rightImage: nil
                        ),
                        .init(
                            image: R.image.demo2(),
                            title: "Костюм чумного доктора",
                            subTitle: "3000₾",
                            description: "Тбилиси, Ваке. 10 ноября, 14:21",
                            rightImage: nil
                        ),
                        .init(
                            image: R.image.demo3(),
                            title: "Черепаха с аквариумом",
                            subTitle: "3000₾",
                            description: "Тбилиси, Ваке. 10 ноября, 14:21",
                            rightImage: nil
                        ),
                        .init(
                            image: R.image.demo(),
                            title: "Щенок немецкой овчарки",
                            subTitle: "3000₾",
                            description: "Тбилиси, Ваке. 10 ноября, 14:21",
                            rightImage: nil
                        ),
                        .init(
                            image: R.image.demo1(),
                            title: "Клетка для грызунов",
                            subTitle: "3000₾",
                            description: "Тбилиси, Ваке. 10 ноября, 14:21",
                            rightImage: nil
                        ),
                        .init(
                            image: R.image.demo2(),
                            title: "Костюм чумного доктора",
                            subTitle: "3000₾",
                            description: "Тбилиси, Ваке. 10 ноября, 14:21",
                            rightImage: nil
                        )
                    ])).didSelectItem ?? .just(IndexPath())
            }
        
        selectedItem
            .emit(to: didSelectItem)
            .disposed(by: disposeBag)
        
        ui.segmentControl.rx.selectedSegmentIndex
            .asDriver()
            .debug("selectedSegmentIndex")
            .drive()
            .disposed(by: disposeBag)
    }
}

private extension MyProductsViewController {
    
    private enum Constants {
        static let contentInset: CGFloat = 300
        static let bottomMargin: CGFloat = 200
        static let buttomHeight: CGFloat = 50
        static let marginTop: CGFloat = 10
        static let margin: CGFloat = 20
    }
    
    struct UI {
        let collectionView: ProductListCollectionView
        let submitButton: UIButton
        let segmentControl: UISegmentedControl
    }
    
    func configureUI() -> UI {
        view.backgroundColor = .clear
        view.clipsToBounds = true
        
        title = R.string.localizable.myProducts_title()
        tabBarItem.title = R.string.localizable.tabbar_annonce()
        tabBarItem.image = R.image.plus()
        tabBarItem.image?.withTintColor(.lightGray)
        
        let layout = UICollectionViewFlowLayout().setup {
            $0.scrollDirection = .vertical
            $0.minimumLineSpacing = 20
        }
        
        let collectionView = ProductListCollectionView(
            frame: .init(),
            collectionViewLayout: layout
        ).setup {
            $0.clipsToBounds = true
            $0.backgroundColor = .clear
            $0.showsVerticalScrollIndicator = false
            $0.register(
                ProductListCell.self,
                forCellWithReuseIdentifier: ProductListCell.self.id
            )
            view.addSubview($0)
        }
        
        let submitButton = UIButton().setup {
            $0.setTitle(
                R.string.localizable.myProducts_title_botton(),
                for: .normal
            )
            view.addSubview($0)
        }
        
        let segmentControl = UISegmentedControl(
            items: [
                R.string.localizable.myProducts_segment_active(),
                R.string.localizable.myProducts_segment_archive()
            ]
        ).setup {
            $0.tintColor = UIColor.white
            $0.selectedSegmentIndex = 0
            $0.setTitleTextAttributes(
                [.foregroundColor: UIColor.gray],
                for: .normal
            )
            $0.setTitleTextAttributes(
                [.foregroundColor: UIColor.black],
                for: .selected
            )
            
            view.addSubview($0)
        }
        
        return UI(
            collectionView: collectionView,
            submitButton: submitButton,
            segmentControl: segmentControl
        )
    }
    
}

private extension MyProductsViewController {
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
