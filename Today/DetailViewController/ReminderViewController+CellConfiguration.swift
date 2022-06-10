//
//  ReminderViewController+CellConfiguration.swift
//  Today
//
//  Created by waheedCodes on 10/06/2022.
//

import UIKit

extension ReminderViewController {

    // MARK: - Default Configurations

    func defaultConfiguration(for cell: UICollectionViewListCell,
                              at row: Row) -> UIListContentConfiguration {
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = text(for: row)
        contentConfiguration.textProperties.font = UIFont.preferredFont(forTextStyle: row.textStyle)
        contentConfiguration.image = row.image
        return contentConfiguration
    }

    func headerConfiguration(for cell: UICollectionViewListCell,
                             with title: String) -> UIListContentConfiguration {
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = title
        return contentConfiguration
    }

    func titleConfiguration(for cell: UICollectionViewListCell, with title: String?) -> TextFieldContentView.Configuration {
        var contentConfiguration = cell.textFieldConfiguration()
        contentConfiguration.text = title
        return contentConfiguration
    }

    func dateConfiguration(for cell: UICollectionViewListCell, with date: Date) -> DatePickerContentView.Configuration {
        var contentConfiguration = cell.dateViewConfiguration()
        contentConfiguration.date = date
        return contentConfiguration
    }

    func notesConfiguration(for cell: UICollectionViewListCell, with notes: String?) -> TextViewContentView.Configuration {
        var contentConfiguration = cell.textViewConfiguration()
        contentConfiguration.text = notes
        return contentConfiguration
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
}
