//
//  AppNotificationPreferences.swift
//  FocusPlsNoBadges
//
//  Created by Ayden Panhuyzen on 2022-03-13.
//

import Foundation

struct AppNotificationPreferences {
    private static let defaults = UserDefaults(suiteName: "com.apple.ncprefs")!, defaultsKey = "apps"
    private static let bundleIDKey = "bundle-id", flagsKey = "flags"
    // lol not using codable for this
    private(set) var content: [[String: Any]]

    mutating func turnOffAllBadges() -> [String] {
        var turnedOffBundles = [String]()
        
        for (index, var app) in content.enumerated() {
            guard let bundleID = app[Self.bundleIDKey] as? String,
                  let flagsInt = app[Self.flagsKey] as? Int else { continue }
            var flags = AppNotificationFlags(integer: flagsInt)

            if flags.areBadgesEnabled {
                turnedOffBundles.append(bundleID)
                flags.areBadgesEnabled = false
                app[Self.flagsKey] = flags.integer
            }

            content[index] = app
        }

        return turnedOffBundles
    }

    mutating func turnOnBadges(bundleIDs: [String]) {
        for (index, var app) in content.enumerated() {
            guard let bundleID = app[Self.bundleIDKey] as? String,
                  bundleIDs.contains(bundleID),
                  let flagsInt = app[Self.flagsKey] as? Int else { continue }

            var flags = AppNotificationFlags(integer: flagsInt)
            flags.areBadgesEnabled = true
            app[Self.flagsKey] = flags.integer

            content[index] = app
        }
    }

    func saveAsCurrent() {
        Self.defaults.set(content, forKey: Self.defaultsKey)
        Self.defaults.synchronize()
    }

    static var current: AppNotificationPreferences {
        let content = defaults.array(forKey: defaultsKey) as! [[String: Any]]
        return .init(content: content)
    }
}
