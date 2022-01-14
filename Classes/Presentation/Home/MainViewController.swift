//
//  MainViewController.swift
//  sello
//
//

import RxSwift
import RxCocoa
import UIKit
import PinLayout

final class MainViewScreenBuilder: ScreenBuilder {
    typealias VC = MainViewController
    
    var dependencies: VC.ViewModel.Dependencies {
        VC.ViewModel.Dependencies(
        )
    }
}

final class MainViewController: UIViewController {
    
    lazy private var ui = configureUI()
    private let disposeBag = DisposeBag()
    let didSelectItem = PublishRelay<IndexPath>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ui.category.pin
            .top()
            .horizontally()
            .height(HomeCategoryViewModel.Constants.height)
        
        ui.collectionView.pin
            .below(of: ui.category)
            .marginTop(30)
            .horizontally()
            .height(view.bounds.height)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setToolbarHidden(false, animated: true)
    }
}

extension MainViewController: ViewType {
    typealias ViewModel = MainHomeViewModel
    
    var bindings: ViewModel.Bindings {
        .init(
        )
    }
    
    func bind(to viewModel: ViewModel) {
        
        let collectionViewConfig = ui.collectionView
            .bind(.init(items: [
                
                .init(
                    image: R.image.demo() ?? UIImage(),
                    title: "Щенок немецкой овчарки",
                    subTitle: "3000₾",
                    description: "Тбилиси, Ваке. 10 ноября, 14:21",
                    rightImage: R.image.favourite() ?? UIImage()
                ),
                .init(
                    image: R.image.demo1() ?? UIImage(),
                    title: "Клетка для грызунов",
                    subTitle: "3000₾",
                    description: "Тбилиси, Ваке. 10 ноября, 14:21",
                    rightImage: R.image.favourite() ?? UIImage()
                ),
                .init(
                    image: R.image.demo2() ?? UIImage(),
                    title: "Костюм чумного доктора",
                    subTitle: "3000₾",
                    description: "Тбилиси, Ваке. 10 ноября, 14:21",
                    rightImage: R.image.favourite() ?? UIImage()
                ),
                .init(
                    image: R.image.demo3() ?? UIImage(),
                    title: "Черепаха с аквариумом",
                    subTitle: "3000₾",
                    description: "Тбилиси, Ваке. 10 ноября, 14:21",
                    rightImage: R.image.favourite() ?? UIImage()
                ),
                .init(
                    image: R.image.demo() ?? UIImage(),
                    title: "Щенок немецкой овчарки",
                    subTitle: "3000₾",
                    description: "Тбилиси, Ваке. 10 ноября, 14:21",
                    rightImage: R.image.favourite() ?? UIImage()
                ),
                .init(
                    image: R.image.demo1() ?? UIImage(),
                    title: "Клетка для грызунов",
                    subTitle: "3000₾",
                    description: "Тбилиси, Ваке. 10 ноября, 14:21",
                    rightImage: R.image.favourite() ?? UIImage()
                ),
                .init(
                    image: R.image.demo2() ?? UIImage(),
                    title: "Костюм чумного доктора",
                    subTitle: "3000₾",
                    description: "Тбилиси, Ваке. 10 ноября, 14:21",
                    rightImage: R.image.favourite() ?? UIImage()
                )
            ]))
        
        collectionViewConfig.didSelectItem
            .emit(to: didSelectItem)
            .disposed(by: disposeBag)
    }
}

private extension MainViewController {
    
    struct UI {
        let category: UIView
        let collectionView: HomeProductListCollectionView
    }
    
    func configureUI() -> UI {
        view.backgroundColor = .white
        
        let category = HomeCategoryScreenBuilder().build(())
        addChild(category)
        view.addSubview(category.view)
        
        let layout = UICollectionViewFlowLayout().setup {
            $0.scrollDirection = .vertical
            $0.minimumLineSpacing = 0
            $0.minimumInteritemSpacing = 0
            $0.minimumLineSpacing = 0
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
