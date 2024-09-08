//
//  AppsCollectionPresenter.swift
//  BaseApp
//
//  Created by Denis on 07.09.2024.
//

import UIKit

protocol IAppsCollectionPresenter {
	func viewIsReady()
	func prepareCell(cell: AppsCollectionViewCell, for indexPath: IndexPath)
	func fullScreen(for indexPath: IndexPath)
	func setUpLayout(with size: CGSize)
	func changeLayout()
}

final class AppsCollectionPresenter {
	let appsStorage: IMiniAppsStorage
	private var viewModel: AppsCollectionViewModel
	private var viewController: UIViewController? {
		view as? UIViewController
	}
	weak var view: IAppsCollectionView?
	
	init(appsStorage: IMiniAppsStorage, view: IAppsCollectionView?) {
		viewModel = .init(
			layout: .init(),
			appsCount: 10,
			isLayoutSmall: true
		)
		self.appsStorage = appsStorage
		self.view = view
	}
	
	private func makeCollectionLayout(with size: CGSize) -> UICollectionViewLayout {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .vertical
		layout.minimumLineSpacing = 6
		layout.itemSize = .init(
			width: size.width,
			height: viewModel.isLayoutSmall ? size.height/8 : size.height/2
		)
		return layout
	}
}

//MARK: - IAppsCollectionPresenter Implementation
extension AppsCollectionPresenter: IAppsCollectionPresenter {
	func changeLayout() {
		viewModel.isLayoutSmall.toggle()
		viewModel.layoutIcon = UIImage(systemName: viewModel.isLayoutSmall ? "rectangle.grid.1x2" : "rectangle")
	}
	
	func viewIsReady() {
		viewModel.layoutIcon = UIImage(systemName: "rectangle.grid.1x2")
		viewModel.layout = makeCollectionLayout(with: UIScreen.main.bounds.size)
		view?.render(with: viewModel)
	}
	
	func setUpLayout(with size: CGSize) {
		viewModel.layout = makeCollectionLayout(with: size)
		view?.render(with: viewModel)
	}
	
	func prepareCell(cell: AppsCollectionViewCell, for indexPath: IndexPath) {
		cell.backgroundColor = .lightGray
		let app = appsStorage.getApp(by: indexPath.row)
		let viewController = appsStorage.getAppViewController(by: indexPath.row)
		self.viewController?.addChild(viewController)
		if viewModel.isLayoutSmall {
			cell.configure(with: app.appName, icon: app.icon)
		} else {
			cell.configure(with: viewController)
		}
		viewController.didMove(toParent: self.viewController)
	}
	
	func fullScreen(for indexPath: IndexPath) {
		let viewController = appsStorage.getAppViewController(by: indexPath.row)
		self.viewController?.navigationController?.pushViewController(viewController, animated: true)
	}
}
