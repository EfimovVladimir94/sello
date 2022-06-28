//
//  ChatMainCell.swift
//  sello
//
//

import PinLayout
import Differentiator

struct ChatMainCellModel {
    let identity: String
    let avatarImage: UIImage
    let name: String
    let description: String
    let timeAgo: String
}

final class ChatMainCell: UITableViewCell {

    private lazy var ui = createUI()

    override func prepareForReuse() {
        super.prepareForReuse()
        ui.nameLabel.text = nil
    }

    override func layoutSubviews() {

        ui.backView.pin
            .top(Constants.margin)
            .left(Constants.leftMargin)
            .right(Constants.rightMargin)
            .bottom(Constants.margin)

        ui.avatarImageView.pin
            .left(Constants.margin)
            .top(Constants.margin)
            .bottom(Constants.margin)
            .size(Constants.avatarSize)

        ui.nameLabel.pin
            .top(Constants.marginTop)
            .right(of: ui.avatarImageView)
            .marginHorizontal(Constants.margin)
            .sizeToFit(.widthFlexible)

        ui.lastMessage.pin
            .below(of: ui.nameLabel)
            .right(of: ui.avatarImageView)
            .marginLeft(Constants.margin)
            .marginTop(Constants.margin)
            .maxWidth(50%)
            .sizeToFit()

        ui.timeAgo.pin
            .right(Constants.margin)
            .bottom(Constants.margin)
            .sizeToFit()
    }
}

// MARK: - Setup
extension ChatMainCell {

    typealias CellModel = TableSection.Item

    func bind(to model: CellModel) {
        ui.nameLabel.text = model.name
        ui.avatarImageView.image = model.avatarImage
        ui.lastMessage.text = model.description
        ui.timeAgo.text = "\(model.timeAgo)"
    }

    static func height() -> CGFloat {
        Constants.height + Constants.margin * 2
    }
}

private extension ChatMainCell {

    enum Constants {
        static let margin: CGFloat = 10
        static let marginTop: CGFloat = 18
        static let height: CGFloat = 80
        static let leftMargin: CGFloat = 40
        static let rightMargin: CGFloat = 30
        static let avatarSize: CGSize = .init(width: 60, height: 60)
    }

    struct UI {
        let backView: UIView
        let nameLabel: UILabel
        let avatarImageView: UIImageView
        let lastMessage: UILabel
        let timeAgo: UILabel
    }

    func createUI() -> UI {

        let backView = UIView().setup {
            $0.backgroundColor = CustomColor.lightGray
            $0.layer.cornerRadius = 10
            contentView.addSubview($0)
        }

        let nameLabel = UILabel().setup {
            $0.font = .systemMedium15
            backView.addSubview($0)
        }

        let lastMessage = UILabel().setup {
            $0.font = .systemRegular14
            backView.addSubview($0)
        }

        let timeAgo = UILabel().setup {
            $0.font = .systemRegular8
            $0.textColor = .gray
            backView.addSubview($0)
        }

        let avatarImageView = UIImageView().setup {
            $0.contentMode = .scaleAspectFit
            $0.layer.cornerRadius = 10
            backView.addSubview($0)
        }

        return .init(
            backView: backView,
            nameLabel: nameLabel,
            avatarImageView: avatarImageView,
            lastMessage: lastMessage,
            timeAgo: timeAgo
        )
    }
}

extension ChatMainCellModel: IdentifiableType, Equatable {}
