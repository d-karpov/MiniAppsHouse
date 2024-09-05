//
//  AppsCollectionViewController.swift
//  BaseApp
//
//  Created by Denis on 05.09.2024.
//

import UIKit

final class AppsCollectionViewController: UICollectionViewController {
	private var isSmallLayout = true
	
	override func viewDidLoad() {
		super.viewDidLoad()
		collectionView.register(
			AppsCollectionViewCell.self,
			forCellWithReuseIdentifier: AppsCollectionViewCell.identifier
		)
		collectionView.collectionViewLayout = makeCollectionBaseLayout(with: collectionView.frame.size)
		navigationItem.rightBarButtonItem = UIBarButtonItem(
			image: UIImage(systemName: "rectangle.grid.1x2"),
			style: .plain,
			target: self,
			action: #selector(switchLayout)
		)
	}
	
	override func viewWillTransition(to size: CGSize, with coordinator: any UIViewControllerTransitionCoordinator) {
		super.viewWillTransition(to: size, with: coordinator)
		collectionView.collectionViewLayout = makeCollectionBaseLayout(with: size)
	}
	
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		10
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		if let cell = collectionView.dequeueReusableCell(
			withReuseIdentifier: AppsCollectionViewCell.identifier,
			for: indexPath
		) as? AppsCollectionViewCell {
			cell.backgroundColor = .cyan
			cell.configure(with: indexPath.row.description)
			return cell
		}
		return UICollectionViewCell()
	}
	
	override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		if isSmallLayout {
			navigationController?.pushViewController(UIViewController(), animated: true)
		}
	}
	
	
	@objc func switchLayout() {
		isSmallLayout.toggle()
		collectionView.setCollectionViewLayout(makeCollectionBaseLayout(with: collectionView.frame.size), animated: true)
		UIView.animate(withDuration: 0.3) {
			self.navigationItem.rightBarButtonItem?.image = UIImage(
				systemName: self.isSmallLayout ? "rectangle.grid.1x2" : "rectangle"
			)
		}
	}
}

private extension AppsCollectionViewController {
	func makeCollectionBaseLayout(with size: CGSize) -> UICollectionViewLayout {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .vertical
		layout.minimumLineSpacing = 6
		layout.itemSize = .init(
			width: size.width,
			height: isSmallLayout ? size.height/8 : size.height/2
		)
		return layout
	}
}

#Preview {
	UINavigationController(rootViewController: AppsCollectionViewController(collectionViewLayout: .init()))
}
