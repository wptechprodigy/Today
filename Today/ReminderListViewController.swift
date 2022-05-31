//
//  ReminderListViewController.swift
//  Today
//
//  Created by waheedCodes on 31/05/2022.
//

import UIKit

class ReminderListViewController: UICollectionViewController {

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupListLayout()
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
}
