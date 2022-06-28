//
//  ChatMainViewController.swift
//  sello
//
//

import RxSwift
import RxCocoa
import UIKit
import PinLayout
import RxDataSources

final class ChatMainScreenBuilder: ScreenBuilder {
    typealias VC = ChatMainViewController

    var dependencies: VC.ViewModel.Dependencies {
        VC.ViewModel.Dependencies(productsService: ProductsService())
    }
}

final class ChatMainViewController: UIViewController {

    lazy private var ui = configureUI()
    private let disposeBag = DisposeBag()
    let didSelectItem = PublishRelay<IndexPath>()
    var dataSource: RxTableViewSectionedAnimatedDataSource<TableSection>?

    override func viewDidLoad() {
        super.viewDidLoad()

        ui.tableView.pin
            .all()
    }
}

extension ChatMainViewController: ViewType {
    typealias ViewModel = ChatMainViewModel

    var bindings: ViewModel.Bindings {
        .init()
    }

    func bind(to viewModel: ViewModel) {
        let dataSource = RxTableViewSectionedAnimatedDataSource<TableSection>(
            configureCell: { ds, tv, _, item in
                let cell = ChatMainCell(
                    style: .default,
                    reuseIdentifier: String(describing: ChatMainCell.self)
                )
                cell.bind(to: item)
                tv.rowHeight = ChatMainCell.height()
                return cell
            }
        )

        self.dataSource = dataSource

        let sections = [
            TableSection(
                model: 0,
                items: [
                    .init(
                        identity: "identity",
                        avatarImage: R.image.avatar1() ?? .init(),
                        name: "Юлия Ахмедова",
                        description: "Добрый день, напиши.............................",
                        timeAgo: "4 часа назад"
                    ),
                    .init(
                        identity: "identity",
                        avatarImage: .init(),
                        name: "name",
                        description: "description",
                        timeAgo: "1 день назад"
                    )
                ])
        ]

        Observable.just(sections)
            .bind(to: ui.tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
}

private extension ChatMainViewController {

    private enum Constants {
        static let contentInset: CGFloat = 300
        static let bottomMargin: CGFloat = 200
        static let buttomHeight: CGFloat = 50
        static let marginTop: CGFloat = 10
        static let margin: CGFloat = 20
    }

    struct UI {
        let tableView: UITableView
    }

    func configureUI() -> UI {

        title = R.string.localizable.tabbar_chat()
        tabBarItem.title = R.string.localizable.tabbar_chat()
        tabBarItem.image = R.image.chat()
        tabBarItem.image?.withTintColor(.lightGray)

        let tableView = UITableView().setup {
            $0.separatorStyle = .none
            $0.contentInset = .make(top: 40, bottom: 40)
            $0.delegate = self
            view.addSubview($0)
        }

        return UI(
            tableView: tableView
        )
    }
}

extension ChatMainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
    }
}

struct TableSection {
    let model: Identity
    let items: [Item]
}

extension TableSection: AnimatableSectionModelType {
    var identity: Int {
        model.identity
    }

    typealias Item = ChatMainCellModel
    typealias Identity = Int

    init(original: TableSection, items: [ChatMainCellModel]) {
        self.model = original.model
        self.items = items
    }
}
