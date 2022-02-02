//
//  HomeProductListCollectionView.swift
//  sello
//
//

import RxSwift
import RxCocoa

final class HomeProductListCollectionView: UICollectionView {
    fileprivate var _items: [HomeProductListCell.Input] = []
    private let didSelectItem = PublishRelay<IndexPath>()
    
    enum Constants {
        static let cellWidth = 200
        static let cellHeight = 250
    }
    
    struct Output {
        let didSelectItem: Signal<IndexPath>
    }
    
    struct Input {
        let items: [HomeProductListCell.Input]
    }
    
    func bind(_ configuration: Input) -> Output {
        delegate = self
        dataSource = self
        _items = configuration.items
        return Output(didSelectItem: didSelectItem.asSignal())
    }
}

extension HomeProductListCollectionView: UICollectionViewDataSource,
                                      UICollectionViewDelegate,
                                      UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        
        return _items.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        
        let item = _items[indexPath.row]
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: HomeProductListCell.self.id,
            for: indexPath
        ) as! HomeProductListCell
        
        cell.configure(
            .init(
                image: item.image,
                title: item.title,
                subTitle: item.subTitle,
                description: item.description,
                rightImage: item.rightImage
            )
        )
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        didSelectItem.accept(indexPath)
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(
            width: Constants.cellWidth,
            height: Constants.cellHeight
        )
    }
}
