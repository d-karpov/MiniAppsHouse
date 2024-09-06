//
//  AppsCollectionViewCell.swift
//  BaseApp
//
//  Created by Denis on 05.09.2024.
//

import UIKit


final class AppsCollectionViewCell: UICollectionViewCell {
	
	static let identifier: String = "AppsCollectionViewCell"
	private let label: UILabel = .init()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubview(label)
		label.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate(
			[
				label.topAnchor.constraint(equalTo: topAnchor),
				label.bottomAnchor.constraint(equalTo: bottomAnchor),
				label.centerXAnchor.constraint(equalTo: centerXAnchor),
				label.centerYAnchor.constraint(equalTo: centerYAnchor),
			]
		)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func configure(with text: String) {
		label.text = text
	}
	
}
