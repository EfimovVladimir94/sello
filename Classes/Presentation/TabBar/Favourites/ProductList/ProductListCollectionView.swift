//
//  ProductListCollectionView.swift
//  sello
//
//  Created by user on 05.02.2022.
//

import RxSwift
import RxCocoa

final class ProductListCollectionView: UICollectionView {
    fileprivate var _items: [ProductListCell.Input] = []
    private let didSelectItem = PublishRelay<IndexPath>()
    
    enum Constants {
        static let cellHeight: CGFloat = 150
    }
    
    struct Output {
        let didSelectItem: Signal<IndexPath>
    }
    
    struct Input {
        let items: [ProductListCell.Input]
    }
    
    func bind(_ configuration: Input) -> Output {
        delegate = self
        dataSource = self
        _items = configuration.items
        return Output(didSelectItem: didSelectItem.asSignal())
    }
}

extension ProductListCollectionView: UICollectionViewDataSource,
                                     UICollectionViewDelegate,
                                     UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        _items.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        
        let item = _items[indexPath.row]
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ProductListCell.self.id,
            for: indexPath
        ) as? ProductListCell
        
        guard let cell = cell else {
            return UICollectionViewCell()
        }
        
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
        CGSize(
            width: UIScreen.main.bounds.size.width,
            height: Constants.cellHeight
        )
    }
}
