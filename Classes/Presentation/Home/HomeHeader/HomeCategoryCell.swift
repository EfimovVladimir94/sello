//
//  HomeCategoryCell.swift
//  sello
//
//

import PinLayout
import RxCocoa

final class HomeCategoryCell: UICollectionViewCell {
    
    struct Input {
        let nameLabel: String
        let iconImage: UIImage
    }
    
    private lazy var ui = configureUI()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        ui.nameLabel.pin.height(0)
        ui.nameLabel.text = nil
    }
    
    // MARK: - Configure
    func configure(_ configuration: Input) {
        
        ui.iconImage.image = configuration.iconImage
        ui.nameLabel.text = configuration.nameLabel
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        ui.backView.pin
            .left()
            .top()
            .size(Constants.cellSize)
        
        ui.iconImage.pin
            .center()
            .size(Constants.iconSize)
        
        ui.nameLabel.pin
            .below(of: ui.backView, aligned: .center)
            .marginTop(10)
            .sizeToFit()
        
        ui.backView.layer.cornerRadius = 10
        
    }
}

private extension HomeCategoryCell {
    
    struct UI {
        let backView: UIView
        let nameLabel: UILabel
        let iconImage: UIImageView
    }
    
    private func configureUI() -> UI {
        
        let nameLabel = UILabel().setup {
            $0.textColor = .white
            $0.font = .systemRegular11
            addSubview($0)
        }
        
        let backView = UIView().setup {
            $0.backgroundColor = .white
            addSubview($0)
        }
        
        let iconImage = UIImageView().setup {
            backView.addSubview($0)
        }
        
        return UI(
            backView: backView,
            nameLabel: nameLabel,
            iconImage: iconImage
        )
    }
}

private extension HomeCategoryCell {
    private enum Constants {
        static let iconSize: CGFloat = 30
        static let cellSize: CGFloat = 80
    }
}
