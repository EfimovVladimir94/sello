//
//  HomeProductListViewController.swift
//  sello
//
//

import RxSwift
import RxCocoa
import UIKit
import PinLayout

final class HomeProductListViewScreenBuilder: ScreenBuilder {
    typealias VC = HomeProductListViewController
    
    var dependencies: VC.ViewModel.Dependencies {
        VC.ViewModel.Dependencies(
        )
    }
}

final class HomeProductListViewController: UIViewController {
    
    lazy private var ui = configureUI()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ui.category.pin
            .top()
            .horizontally()
            .sizeToFit(.width)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setToolbarHidden(false, animated: true)
    }
    
}

extension HomeProductListViewController: ViewType {
    typealias ViewModel = HomeProductListViewModel
    
    var bindings: ViewModel.Bindings {
        .init(
        )
    }
    
    func bind(to viewModel: ViewModel) {
    }
}

private extension HomeProductListViewController {
    
    struct UI {
        let category: UIView
    }
    
    func configureUI() -> UI {
        view.backgroundColor = .white
        
        let category = HomeCategoryScreenBuilder().build(())
        addChild(category)
        view.addSubview(category.view)
        return UI(category: category.view)
    }
}
