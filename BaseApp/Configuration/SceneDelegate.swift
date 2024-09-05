//
//  SceneDelegate.swift
//  BaseApp
//
//  Created by Denis on 05.09.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let scene = (scene as? UIWindowScene) else { return }
		let window = UIWindow(windowScene: scene)
		window.rootViewController = UINavigationController(rootViewController: AppsCollectionViewController(collectionViewLayout: .init()))
		window.makeKeyAndVisible()
		self.window = window
	}
}

