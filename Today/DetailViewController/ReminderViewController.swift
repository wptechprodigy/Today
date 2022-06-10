//
//  ReminderViewController.swift
//  Today
//
//  Created by waheedCodes on 03/06/2022.
//

import UIKit

class ReminderViewController: UICollectionViewController {

    // MARK: - Type Definition

    private typealias DataSource = UICollectionViewDiffableDataSource<Section, Row>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Row>

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
        navigationItem.rightBarButtonItem = editButtonItem

        updateSnapshotForViewing()
    }

    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        switch editing {
            case true:
                updateSnapshotForEditing()
            case false:
                updateSnapshotForViewing()
        }
    }

    // MARK: - Text Selector

    func text(for row: Row) -> String? {
        switch row {
            case .viewDate: return reminder.dueDate.daytext
            case .viewNotes: return reminder.notes
            case .viewTime: return reminder.dueDate.formatted(date: .omitted, time: .shortened)
            case .viewTitle: return reminder.title
            default: return nil
        }
    }

    // MARK: - Cell Registeration

    func cellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, row: Row) {
        let section = section(for: indexPath)
        switch (section, row) {
            case (_, .header(let title)):
                var contentConfiguration = cell.defaultContentConfiguration()
                contentConfiguration.text = title
                cell.contentConfiguration = contentConfiguration
            case (.view, _):
                var contentConfiguration = cell.defaultContentConfiguration()
                contentConfiguration.text = text(for: row)
                contentConfiguration.textProperties.font = UIFont.preferredFont(forTextStyle: row.textStyle)
                contentConfiguration.image = row.image

                cell.contentConfiguration = contentConfiguration
            default:
                fatalError("Unexpected combination of section and row")
        }

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

    private func updateSnapshotForEditing() {
        var snapshot = Snapshot()
        snapshot.appendSections([.title, .date, .notes])
        snapshot.appendItems([.header(Section.title.name)], toSection: .title)
        snapshot.appendItems([.header(Section.date.name)], toSection: .date)
        snapshot.appendItems([.header(Section.notes.name)], toSection: .notes)
        dataSource.apply(snapshot)
    }

    private func updateSnapshotForViewing() {
        var snapshot = Snapshot()
        snapshot.appendSections([.view])
        snapshot.appendItems([
            .header(""),
            .viewTitle,
            .viewDate,
            .viewTime,
            .viewNotes
        ], toSection: .view)

        dataSource.apply(snapshot)
    }

    private func section(for indexPath: IndexPath) -> Section {
        let sectionNmuber = isEditing ? indexPath.section + 1 : indexPath.section
        guard let section = Section(rawValue: sectionNmuber) else {
            fatalError("Unable to find matching section")
        }
        return section
    }
}
