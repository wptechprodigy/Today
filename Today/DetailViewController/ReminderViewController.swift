//
//  ReminderViewController.swift
//  Today
//
//  Created by waheedCodes on 03/06/2022.
//

import UIKit

class ReminderViewController: UICollectionViewController {

    // MARK: - Type Definition

    private typealias DataSource = UICollectionViewDiffableDataSource<Int, Row>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Row>

    // MARK: - Properties

    var reminder: Reminder
    private var dataSource: DataSource!

    // MARK: - Constants

    private let sectionIndex = 0

    // MARK: - Initializer

    init(reminder: Reminder) {
        self.reminder = reminder
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        listConfiguration.showsSeparators = false
        let listLayout = UICollectionViewCompositionalLayout.list(using: listConfiguration)
        super.init(collectionViewLayout: listLayout)
    }

    required init?(coder: NSCoder) {
        fatalError("Always initialize ReminderViewController using init(reminder:)")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configureDataSource()
        navigationItem.title = NSLocalizedString("Reminder", comment: "Reminder view controller")
        updateSnapshot()
    }

    // MARK: - Text Selector

    func text(for row: Row) -> String? {
        switch row {
            case .viewDate: return reminder.dueDate.daytext
            case .viewNotes: return reminder.notes
            case .viewTime: return reminder.dueDate.formatted(date: .omitted, time: .shortened)
            case .viewTitle: return reminder.title
        }
    }

    // MARK: - Cell Registeration

    func cellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, row: Row) {
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = text(for: row)
        contentConfiguration.textProperties.font = UIFont.preferredFont(forTextStyle: row.textStyle)
        contentConfiguration.image = row.image

        cell.contentConfiguration = contentConfiguration
        cell.tintColor = .todayPrimaryTint
    }

    // MARK: - Data Source

    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration(handler: cellRegistrationHandler)
        dataSource = DataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        })
    }

    // MARK: - Snapshot

    private func updateSnapshot() {
        var snapshot = Snapshot()
        snapshot.appendSections([sectionIndex])
        snapshot.appendItems([
            .viewTitle,
            .viewDate,
            .viewTime,
            .viewNotes
        ], toSection: sectionIndex)

        dataSource.apply(snapshot)
    }
}
