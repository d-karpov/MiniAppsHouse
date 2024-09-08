//
//  AppsCollectionViewController.swift
//  BaseApp
//
//  Created by Denis on 05.09.2024.
//

import UIKit

protocol IAppsCollectionView: AnyObject {
	func render(with viewModel: AppsCollectionViewModel)
}

final class AppsCollectionViewController: UICollectionViewController {
	var presenter: IAppsCollectionPresenter?
	private var viewModel: AppsCollectionViewModel?
	
	//MARK: - LifeCycle Methods
	override func viewDidLoad() {
		super.viewDidLoad()
		presenter?.viewIsReady()
		collectionView.register(
			AppsCollectionViewCell.self,
			forCellWithReuseIdentifier: AppsCollectionViewCell.identifier
		)
		navigationItem.rightBarButtonItem = UIBarButtonItem(
			image: viewModel?.layoutIcon,
			style: .plain,
			target: self,
			action: #selector(switchLayout)
		)
		navigationController?.navigationBar.tintColor = .black
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		collectionView.reloadData()
	}
	
	override func viewWillTransition(to size: CGSize, with coordinator: any UIViewControllerTransitionCoordinator) {
		super.viewWillTransition(to: size, with: coordinator)
		presenter?.setUpLayout(with: size)
	}
	
	//MARK: - CollectionView Methods
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		viewModel?.appsCount ?? 0
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		if
			let cell = collectionView.dequeueReusableCell(
				withReuseIdentifier: AppsCollectionViewCell.identifier,
				for: indexPath
			) as? AppsCollectionViewCell,
			let presenter
		{
			presenter.prepareCell(cell: cell, for: indexPath)
			return cell
		}
		return UICollectionViewCell()
	}
	
	override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		presenter?.fullScreen(for: indexPath)
	}
	
	@objc private func switchLayout() {
		presenter?.changeLayout()
		presenter?.setUpLayout(with: view.frame.size)
	}
}

//MARK: - IAppsCollectionView Implementation
extension AppsCollectionViewController: IAppsCollectionView {
	func render(with viewModel: AppsCollectionViewModel) {
		self.viewModel = viewModel
		collectionView.reloadData()
		collectionView.setCollectionViewLayout(viewModel.layout, animated: true)
		UIView.animate(withDuration: 0.3) {
			self.navigationItem.rightBarButtonItem?.image = viewModel.layoutIcon
		}
	}
}


#Preview {
	let view = AppsCollectionViewController(collectionViewLayout: .init())
	let presenter = AppsCollectionPresenter(
		appsStorage: MiniAppsStorage.shared,
		view: view
	)
	view.presenter = presenter
	return UINavigationController(rootViewController: view)
}
