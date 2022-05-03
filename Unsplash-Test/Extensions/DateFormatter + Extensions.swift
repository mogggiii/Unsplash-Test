//
//  DateFormatter + Extensions.swift
//  Unsplash-Test
//
//  Created by mogggiii on 02.05.2022.
//

import Foundation

extension DateFormatter {
	func format() -> DateFormatter {
		let formatter = DateFormatter()
		formatter.dateFormat = "dd.MM.yyyy"
		return formatter
	}
}
