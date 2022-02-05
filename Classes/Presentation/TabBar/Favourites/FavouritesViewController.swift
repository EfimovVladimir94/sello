//
//  FavouritesViewController.swift
//  sello
//
//

import RxSwift
import RxCocoa
import UIKit
import PinLayout

final class FavouritesScreenBuilder: ScreenBuilder {
    typealias VC = FavouritesViewController
    
    var dependencies: VC.ViewModel.Dependencies {
        VC.ViewModel.Dependencies()
    }
}

final class FavouritesViewController: UIViewController {
    
    lazy private var ui = configureUI()
    private let disposeBag = DisposeBag()
    let didSelectItem = PublishRelay<IndexPath>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ui.collectionView.pin.all()
        
        ui.collectionView.contentInset = .make(bottom: Constants.contentInset)
        
    }
}

extension FavouritesViewController: ViewType {
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
                    rightImage: R.image.favourite_selected()
                ),
                .init(
                    image: R.image.demo1(),
                    title: "Клетка для грызунов",
                    subTitle: "3000₾",
                    description: "Тбилиси, Ваке. 10 ноября, 14:21",
                    rightImage: R.image.favourite_selected()
                ),
                .init(
                    image: R.image.demo2(),
                    title: "Костюм чумного доктора",
                    subTitle: "3000₾",
                    description: "Тбилиси, Ваке. 10 ноября, 14:21",
                    rightImage: R.image.favourite_selected()
                ),
                .init(
                    image: R.image.demo3(),
                    title: "Черепаха с аквариумом",
                    subTitle: "3000₾",
                    description: "Тбилиси, Ваке. 10 ноября, 14:21",
                    rightImage: R.image.favourite_selected()
                ),
                .init(
                    image: R.image.demo(),
                    title: "Щенок немецкой овчарки",
                    subTitle: "3000₾",
                    description: "Тбилиси, Ваке. 10 ноября, 14:21",
                    rightImage: R.image.favourite_selected()
                ),
                .init(
                    image: R.image.demo1(),
                    title: "Клетка для грызунов",
                    subTitle: "3000₾",
                    description: "Тбилиси, Ваке. 10 ноября, 14:21",
                    rightImage: R.image.favourite_selected()
                ),
                .init(
                    image: R.image.demo2(),
                    title: "Костюм чумного доктора",
                    subTitle: "3000₾",
                    description: "Тбилиси, Ваке. 10 ноября, 14:21",
                    rightImage: R.image.favourite_selected()
                )
            ]))
        
        collectionViewConfig.didSelectItem
            .emit(to: didSelectItem)
            .disposed(by: disposeBag)
    }
}

private extension FavouritesViewController {
    
    private enum Constants {
        static let contentInset: CGFloat = 200
        static let marginTop: CGFloat = 10
    }
    
    struct UI {
        let collectionView: ProductListCollectionView
    }
    
    func configureUI() -> UI {
        view.backgroundColor = .clear
        view.clipsToBounds = true
        
        title = R.string.localizable.tabbar_favourite()
        tabBarItem.title = R.string.localizable.tabbar_favourite()
        tabBarItem.image = R.image.love()
        tabBarItem.image?.withTintColor(.lightGray)
        
        let layout = UICollectionViewFlowLayout().setup {
            $0.scrollDirection = .vertical
            $0.minimumLineSpacing = 0
            $0.minimumInteritemSpacing = 0
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
        
        return UI(
            collectionView: collectionView
        )
    }
}
