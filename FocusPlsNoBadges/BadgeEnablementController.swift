//
//  BadgeEnablementController.swift
//  FocusPlsNoBadges
//
//  Created by Ayden Panhuyzen on 2022-03-13.
//

import Foundation

class BadgeEnablementController {
    func turnOffAllBadges() {
        print("Turning off all badges…")
        // Load notif prefs & turn off badges for all, getting array of who were turned off
        var prefs = AppNotificationPreferences.current
        let bundleIDs = prefs.turnOffAllBadges()
        guard !bundleIDs.isEmpty else { return }
        print("Will be turned off:", bundleIDs)

        // Store list of apps we turned off for, save notif prefs
        bundleIdentifiersToGiveBadgesBack.append(contentsOf: bundleIDs)
        prefs.saveAsCurrent()

        // Restart notifs daemon to apply changes!
        restartUserNotificationsDaemon()
    }

    func restoreBadges() {
        print("Restoring badges…")
        // Find any app bundle IDs needing their badges turned back on
        let bundleIDs = bundleIdentifiersToGiveBadgesBack
        guard !bundleIDs.isEmpty else { return }
        print("To be restored:", bundleIDs)

        // Load notif prefs & turn on badges for those
        var prefs = AppNotificationPreferences.current
        prefs.turnOnBadges(bundleIDs: bundleIDs)

        // Save notif prefs, remove list of apps needing badges on
        prefs.saveAsCurrent()
        bundleIdentifiersToGiveBadgesBack.removeAll()

        // Restart notifs daemon to apply changes!
        restartUserNotificationsDaemon()
    }

    private static let bundleIdentifiersToGiveBadgesBackKey = "BundleIdentifiersToGiveBadgesBack"
    private var bundleIdentifiersToGiveBadgesBack: [String] {
        get { UserDefaults.standard.object(forKey: Self.bundleIdentifiersToGiveBadgesBackKey) as? [String] ?? [] }
        set { UserDefaults.standard.set(newValue, forKey: Self.bundleIdentifiersToGiveBadgesBackKey) }
    }

    private func restartUserNotificationsDaemon() {
        print("Restarting usernoted…")
        Process.launchedProcess(launchPath: "/bin/bash", arguments: ["-c", "launchctl kickstart -k gui/$(id -u)/com.apple.usernoted"])
    }
}
