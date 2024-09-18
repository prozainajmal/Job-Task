//
//  NoDataView.swift
//  JT
//
//  Created by Developer on 18/09/2024.
//
 import Foundation
import UIKit
class NoDataView: UIView {
    private let label: UILabel = {
        let label = UILabel()
        label.text = "No Data Found"
        label.textColor = .gray
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
