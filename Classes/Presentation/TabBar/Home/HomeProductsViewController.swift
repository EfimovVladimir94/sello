//
//  HomeProductsViewController.swift
//  sello
//
//

import RxSwift
import RxCocoa
import UIKit
import PinLayout

final class HomeProductsScreenBuilder: ScreenBuilder {
    typealias VC = HomeProductsViewController
    
    var dependencies: VC.ViewModel.Dependencies {
        VC.ViewModel.Dependencies(
        )
    }
}

final class HomeProductsViewController: UIViewController {
    
    lazy private var ui = configureUI()
    private let disposeBag = DisposeBag()
    let didSelectItem = PublishRelay<IndexPath>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ui.category.pin
            .top()
            .horizontally()
            .height(Constants.height)
        
        ui.collectionView.pin
            .below(of: ui.category)
            .marginTop(Constants.marginTop)
            .horizontally()
            .bottom()
        
        ui.collectionView.contentInset = .make(bottom: Constants.contentInset)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
}

extension HomeProductsViewController: ViewType {
    typealias ViewModel = HomeProductsViewModel
    
    var bindings: ViewModel.Bindings {
        .init()
    }
    
    func bind(to viewModel: ViewModel) {
        
        let collectionViewConfig = ui.collectionView
            .bind(.init(items: [
                
                .init(
                    image: R.image.demo(),
                    title: "Щенок немецкой овчарки",
                    subTitle: "3000₾",
                    description: "Тбилиси, Ваке. 10 ноября, 14:21",
                    rightImage: R.image.favourite()
                ),
                .init(
                    image: R.image.demo1(),
                    title: "Клетка для грызунов",
                    subTitle: "3000₾",
                    description: "Тбилиси, Ваке. 10 ноября, 14:21",
                    rightImage: R.image.favourite()
                ),
                .init(
                    image: R.image.demo2(),
                    title: "Костюм чумного доктора",
                    subTitle: "3000₾",
                    description: "Тбилиси, Ваке. 10 ноября, 14:21",
                    rightImage: R.image.favourite()
                ),
                .init(
                    image: R.image.demo3(),
                    title: "Черепаха с аквариумом",
                    subTitle: "3000₾",
                    description: "Тбилиси, Ваке. 10 ноября, 14:21",
                    rightImage: R.image.favourite()
                ),
                .init(
                    image: R.image.demo(),
                    title: "Щенок немецкой овчарки",
                    subTitle: "3000₾",
                    description: "Тбилиси, Ваке. 10 ноября, 14:21",
                    rightImage: R.image.favourite()
                ),
                .init(
                    image: R.image.demo1(),
                    title: "Клетка для грызунов",
                    subTitle: "3000₾",
                    description: "Тбилиси, Ваке. 10 ноября, 14:21",
                    rightImage: R.image.favourite()
                ),
                .init(
                    image: R.image.demo2(),
                    title: "Костюм чумного доктора",
                    subTitle: "3000₾",
                    description: "Тбилиси, Ваке. 10 ноября, 14:21",
                    rightImage: R.image.favourite()
                )
            ]))
        
        collectionViewConfig.didSelectItem
            .emit(to: didSelectItem)
            .disposed(by: disposeBag)
    }
}

private extension HomeProductsViewController {
    
    private enum Constants {
        static let contentInset: CGFloat = 110
        static let marginTop: CGFloat = 10
        static let height: CGFloat = 250
    }
    
    struct UI {
        let category: UIView
        let collectionView: HomeProductListCollectionView
    }
    
    func configureUI() -> UI {
        view.backgroundColor = .white
        view.clipsToBounds = true
        tabBarItem.title = R.string.localizable.tabbar_home()
        tabBarItem.image = R.image.home()
        tabBarItem.image?.withTintColor(.lightGray)
        
        let category = HomeCategoryScreenBuilder().build(())
        addChild(category)
        view.addSubview(category.view)
        
        let layout = UICollectionViewFlowLayout().setup {
            $0.scrollDirection = .vertical
            $0.minimumLineSpacing = 0
            $0.minimumInteritemSpacing = 0
        }
        
        let collectionView = HomeProductListCollectionView(
            frame: .init(),
            collectionViewLayout: layout
        ).setup {
            $0.backgroundColor = .clear
            $0.showsVerticalScrollIndicator = false
            $0.register(
                HomeProductListCell.self,
                forCellWithReuseIdentifier: HomeProductListCell.self.id
            )
            view.addSubview($0)
        }
        
        return UI(
            category: category.view,
            collectionView: collectionView
        )
    }
}
