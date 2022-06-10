//
//  UIView+PinnedSubview.swift
//  Today
//
//  Created by waheedCodes on 10/06/2022.
//

import UIKit

extension UIView {

    // MARK: - Pin Subview

    func addPinnedSubview(_ subview: UIView,
                          height: CGFloat? = nil,
                          insets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    ) {
        addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subview.topAnchor.constraint(equalTo: topAnchor, constant: insets.top),
            subview.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -1.0 * insets.right),
            subview.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -1.0 * insets.bottom),
            subview.leadingAnchor.constraint(equalTo: leadingAnchor, constant: insets.left)
        ])

        if let height = height {
            subview.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}
