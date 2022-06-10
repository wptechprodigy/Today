//
//  DatePickerContentView.swift
//  Today
//
//  Created by waheedCodes on 10/06/2022.
//

import UIKit

class DatePickerContentView: UIView, UIContentView {

    // MARK: - Self Configuration

    struct Configuration: UIContentConfiguration {

        var date = Date.now

        func makeContentView() -> UIView & UIContentView {
            return DatePickerContentView(self)
        }
    }

    // MARK: - Properties

    let datePicker = UIDatePicker()
    var configuration: UIContentConfiguration {
        didSet {
            configure(configuration: configuration)
        }
    }

    // MARK: - Initializer

    init(_ configuration: UIContentConfiguration) {
        self.configuration = configuration
        super.init(frame: .zero)
        addPinnedSubview(datePicker)
        datePicker.preferredDatePickerStyle = .inline
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configure Content View

    func configure(configuration: UIContentConfiguration) {
        guard let configuration = configuration as? DatePickerContentView.Configuration else { return }
        datePicker.date = configuration.date
    }
}

extension UICollectionViewListCell {
    func dateViewConfiguration() -> DatePickerContentView.Configuration {
        DatePickerContentView.Configuration()
    }
}
