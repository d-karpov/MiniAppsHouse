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
	private lazy var imageView: UIImageView = .init()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
	}
	
	override func prepareForReuse() {
		clearCellContent()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func configure(with text: String, icon: UIImage?) {
		if let icon {
			setUpIcon(with: icon)
		}
		setUpLabel(with: text)
		
	}
	
	func configure(with viewController: UIViewController) {
		clearCellContent()
		viewController.view.frame = contentView.bounds
		contentView.addSubview(viewController.view)
	}
	
	//MARK: - Private UI Methods
	private func setUpIcon(with icon: UIImage) {
		contentView.addSubview(imageView)
		imageView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate(
			[
				imageView.heightAnchor.constraint(equalToConstant: 50),
				imageView.widthAnchor.constraint(equalToConstant: 50),
				imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
				imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
			]
		)
		imageView.tintColor = .black
		imageView.image = icon
	}
	
	private func setUpLabel(with text: String) {
		contentView.addSubview(label)
		label.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate(
			[
				label.topAnchor.constraint(equalTo: contentView.topAnchor),
				label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
				label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
				label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
			]
		)
		label.text = text
	}
	
	private func clearCellContent() {
		contentView.subviews.forEach { subView in
			subView.removeFromSuperview()
		}
	}
}
