//
//  ProductListCell.swift
//  sello
//
//  Created by user on 05.02.2022.
//


import PinLayout
import RxCocoa

final class ProductListCell: UICollectionViewCell {
    
    struct Input {
        let image: UIImage?
        let title: String
        let subTitle: String
        let description: String?
        let rightImage: UIImage?
    }
    
    private lazy var ui = configureUI()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        ui.title.pin.height(0)
        ui.title.text = nil
        ui.subTitle.text = nil
        ui.description.text = nil
    }
    
    // MARK: - Configure
    func configure(_ configuration: Input) {
        
        ui.imageView.image = configuration.image
        ui.title.text = configuration.title
        ui.subTitle.text = configuration.subTitle
        ui.description.text = configuration.description
        ui.rightImage.image = configuration.rightImage
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        ui.imageView.pin
            .top()
            .horizontally()
            .size(
                CGSize(
                    width: Constants.imageWidth,
                    height: self.contentView.frame.height
                ))
        
        ui.rightImage.pin
            .top(Constants.spaceMargin)
            .right(Constants.margin)
            .size(Constants.iconSize)
        
        ui.title.pin
            .horizontallyBetween(
                ui.imageView,
                and: ui.rightImage,
                aligned: .top
            )
            .marginLeft(Constants.margin)
            .marginRight(Constants.margin)
            .sizeToFit(.width)
        
        ui.subTitle.pin
            .below(of: ui.title, aligned: .left)
            .marginTop(Constants.margin)
            .left(of: ui.rightImage)
            .marginRight(Constants.margin)
            .sizeToFit(.width)
        
        ui.description.pin
            .below(of: ui.subTitle, aligned: .left)
            .marginTop(Constants.margin)
            .left(of: ui.rightImage)
            .marginRight(Constants.margin)
            .sizeToFit(.width)
        
        ui.imageView.layer.cornerRadius = 10
        
    }
}

private extension ProductListCell {
    
    struct UI {
        let imageView: UIImageView
        let title: UILabel
        let subTitle: UILabel
        let description: UILabel
        let rightImage: UIImageView
    }
    
    private func configureUI() -> UI {
        
        let imageView = UIImageView().setup {
            $0.contentMode = .scaleAspectFill
            contentView.addSubview($0)
        }
        
        let title = UILabel().setup {
            $0.textColor = .black
            $0.font = .systemRegular17
            $0.numberOfLines = 2
            contentView.addSubview($0)
        }
        
        let subTitle = UILabel().setup {
            $0.textColor = .black
            $0.font = .systemBold15
            contentView.addSubview($0)
        }
        
        let description = UILabel().setup {
            $0.textColor = .black
            $0.font = .systemLight(of: 10)
            contentView.addSubview($0)
        }
        
        let rightImage = UIImageView().setup {
            contentView.addSubview($0)
        }
        
        return UI(
            imageView: imageView,
            title: title,
            subTitle: subTitle,
            description: description,
            rightImage: rightImage
        )
    }
}

private extension ProductListCell {
    private enum Constants {
        static let iconSize: CGFloat = 24
        static let imageWidth: CGFloat = 200
        static let margin: CGFloat = 10
        static let spaceMargin: CGFloat = 20
    }
}
