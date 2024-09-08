//
//  MiniAppsStorage.swift
//  BaseApp
//
//  Created by Denis on 07.09.2024.
//

import UIKit
import MiniWeather
import CurrentCity

protocol IMiniAppInterface {
	static var icon: UIImage? { get }
	static var appName: String { get }
	static func assembly() -> UIViewController
}

extension CurrentCity: IMiniAppInterface { }
extension MiniWeather: IMiniAppInterface { }

protocol IMiniAppsStorage {
	func getApp(by index: Int) -> IMiniAppInterface.Type
	func getAppViewController(by index: Int) -> UIViewController
}

final class MiniAppsStorage {
	static let shared: MiniAppsStorage = .init()
	private let baseApps = [
		CurrentCity.self, 
		MiniWeather.self
	] as [IMiniAppInterface.Type]
	private var apps: [IMiniAppInterface.Type]
	private var viewControllers: [UIViewController]
	
	private init() { 
		apps = baseApps
		viewControllers = apps.map { $0.assembly() }
	}
	
	private func generateRandomMiniApp() -> IMiniAppInterface.Type {
		guard let randomMiniApp = baseApps.randomElement() else {
			preconditionFailure("Error during getting randomMiniApp")
		}
		apps.append(randomMiniApp)
		viewControllers.append(randomMiniApp.assembly())
		return randomMiniApp
	}
}

extension MiniAppsStorage: IMiniAppsStorage {
	func getAppViewController(by index: Int) -> UIViewController {
		guard let viewController = viewControllers[safe: index] else {
			preconditionFailure("Error during getting AppViewController for index - \(index)")
		}
		return viewController
	}
	
	func getApp(by index: Int) -> IMiniAppInterface.Type {
		if let app = apps[safe: index] {
			return app
		} else {
			let app = generateRandomMiniApp()
			return app
		}
	}
}
