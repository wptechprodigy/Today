//
//  TextViewContentView.swift
//  Today
//
//  Created by waheedCodes on 10/06/2022.
//

import UIKit

class TextViewContentView: UIView, UIContentView {

    // MARK: - Self Config

    struct Configuration: UIContentConfiguration {
        var text: String? = ""

        func makeContentView() -> UIView & UIContentView {
            return TextViewContentView(self)
        }
    }

    // MARK: - Properties

    let textView = UITextView()
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
        addPinnedSubview(textView,
                         height: 200)
        textView.backgroundColor = nil
        textView.font = UIFont.preferredFont(forTextStyle: .body)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configure Content View

    func configure(configuration: UIContentConfiguration) {
        guard let configuration = configuration as? TextViewContentView.Configuration else { return }
        textView.text = configuration.text
    }
}

extension UICollectionViewListCell {
    func textViewConfiguration() -> TextViewContentView.Configuration {
        TextViewContentView.Configuration()
    }
}
