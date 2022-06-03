//
//  ReminderListViewController.swift
//  Today
//
//  Created by waheedCodes on 31/05/2022.
//

import UIKit

class ReminderListViewController: UICollectionViewController {

    // MARK: - Datasource

    var dataSource: Datasource!
    var reminders: [Reminder] = Reminder.sampleData

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupListLayout()
        configureCell()
    }

    // MARK: - Setup List

    private func setupListLayout() {
        let listLayout = listLayout()
        collectionView.collectionViewLayout = listLayout
    }

    // MARK: - List Layout Configuration

    private func listLayout() -> UICollectionViewCompositionalLayout {
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .grouped)
        listConfiguration.showsSeparators = false
        listConfiguration.backgroundColor = .clear

        return UICollectionViewCompositionalLayout.list(using: listConfiguration)
    }

    // MARK: - Cell Configuration

    private func configureCell() {
        let cellRegistration = UICollectionView.CellRegistration(handler: cellRegistrationHandler)
        makeDataSource(with: cellRegistration)
        applySnapshot()

        collectionView.dataSource = dataSource
    }

    // MARK: - Setup Data Source

    private func makeDataSource(with cellRegistration: Cell) {
        dataSource = Datasource(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        }
    }

    // MARK: - Show Reminder

    private func showDetail(for id: Reminder.ID) {
        let reminder = reminder(for: id)
        let detailViewController = ReminderViewController(reminder: reminder)
        navigationController?.pushViewController(detailViewController, animated: true)
    }

    // MARK: - Delegate

    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        let id = reminders[indexPath.item].id
        showDetail(for: id)
        return false
    }
}


