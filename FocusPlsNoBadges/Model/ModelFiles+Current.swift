//
//  DoNotDisturbModels.swift
//  FocusPlsNoBadges
//
//  Created by Ayden Panhuyzen on 2022-03-13.
//

import Foundation

private let doNotDisturbDBDirectory = try! FileManager.default.url(for: .libraryDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("DoNotDisturb").appendingPathComponent("DB")

extension AssertionsFile {
    static var current: Self {
        let url = doNotDisturbDBDirectory.appendingPathComponent("Assertions.json")
        let data = try! Data(contentsOf: url)
        return try! JSONDecoder().decode(self, from: data)
    }
}

extension ModeConfigurationsFile {
    static var current: Self {
        let url = doNotDisturbDBDirectory.appendingPathComponent("ModeConfigurations.json")
        let data = try! Data(contentsOf: url)
        return try! JSONDecoder().decode(self, from: data)
    }
}
