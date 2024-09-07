//
//  Array+.swift
//  BaseApp
//
//  Created by Denis on 07.09.2024.
//

import UIKit

extension Array {
	subscript(safe index: Index) -> Element? {
		indices ~= index ? self[index] : nil
	}
	
}
