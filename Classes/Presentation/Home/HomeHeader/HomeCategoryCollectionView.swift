//
//  CategoryCollectionView.swift
//  sello
//
//

import RxSwift
import RxCocoa

final class HomeCategoryCollectionView: UICollectionView {
    fileprivate var _items: [HomeCategoryCell.Input] = []
    private let didSelectItem = PublishRelay<IndexPath>()
    
    struct Output {
        let didSelectItem: Signal<IndexPath>
    }
    
    struct Input {
        let items: [HomeCategoryCell.Input]
    }
    
    enum Constants {
        static let cellWidth = 80
        static let cellHeight = 120
    }
    
    func bind(_ configuration: Input) -> Output {
        delegate = self
        dataSource = self
        _items = configuration.items
        return Output(didSelectItem: didSelectItem.asSignal())
    }
}

extension HomeCategoryCollectionView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return _items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = _items[indexPath.row]
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: HomeCategoryCell.self.id,
            for: indexPath
        ) as! HomeCategoryCell
        
        cell.configure(
            .init(
                nameLabel: item.nameLabel,
                iconImage: item.iconImage
            )
        )
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectItem.accept(indexPath)
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout
                        , sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: Constants.cellWidth, height: Constants.cellHeight)
    }
}
