//
//  TextFieldContentView.swift
//  Today
//
//  Created by waheedCodes on 10/06/2022.
//

import UIKit

class TextFieldContentView: UIView, UIContentView {

    // MARK: - Self Config

    struct Configuration: UIContentConfiguration {
        var text: String? = ""

        func makeContentView() -> UIView & UIContentView {
            return TextFieldContentView(self)
        }
    }

    // MARK: - Properties

    let textField = UITextField()
    var configuration: UIContentConfiguration {
        didSet {
            configure(configuration: configuration)
        }
    }

    // MARK: - Customize Intrinsic Size

    override var intrinsicContentSize: CGSize {
        CGSize(width: 0, height: 44)
    }

    // MARK: - Initializer

    init(_ configuration: UIContentConfiguration) {
        self.configuration = configuration
        super.init(frame: .zero)
        addPinnedSubview(textField,
                         insets: UIEdgeInsets(
                            top: 0,
                            left: 16,
                            bottom: 0,
                            right: 16))
        textField.clearButtonMode = .whileEditing
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configure Content View

    func configure(configuration: UIContentConfiguration) {
        guard let configuration = configuration as? TextFieldContentView.Configuration else { return }
        textField.text = configuration.text
    }
}

extension UICollectionViewListCell {
    func textFieldConfiguration() -> TextFieldContentView.Configuration {
        TextFieldContentView.Configuration()
    }
}
