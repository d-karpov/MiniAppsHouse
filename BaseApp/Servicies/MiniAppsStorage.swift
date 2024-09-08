//
//  MiniAppsStorage.swift
//  BaseApp
//
//  Created by Denis on 07.09.2024.
//

import UIKit
import MiniWeather
import CurrentCity
import JokeGenerator


///Используется для обобщения интерфейса мини приложений.
///Для интеграции необходимо подписать приложение под этот протокол
protocol IMiniAppInterface {
	static var icon: UIImage? { get }
	static var appName: String { get }
	static func assembly() -> UIViewController
}

extension CurrentCity: IMiniAppInterface { }
extension MiniWeather: IMiniAppInterface { }
extension JokeGenerator: IMiniAppInterface { }

protocol IMiniAppsStorage {
	func getApp(by index: Int) -> IMiniAppInterface.Type
	func getAppViewController(by index: Int) -> UIViewController
}
///Используется как хранилище мини-приложений, требуемое количество приложений
///задается в AppsCollectionPresenter. Для добавления в список на генерацию необходимо добавить
///класс мини-приложения в массив baseApps данного синглтона. Далее приложения генерируются в случайном порядке
final class MiniAppsStorage {
	static let shared: MiniAppsStorage = .init()
	private let baseApps = [
		CurrentCity.self, 
		MiniWeather.self,
		JokeGenerator.self
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

//MARK: - IMiniAppsStorage Implenetation
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
