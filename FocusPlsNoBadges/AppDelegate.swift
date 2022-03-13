//
//  AppDelegate.swift
//  FocusPlsNoBadges
//
//  Created by Ayden Panhuyzen on 2022-03-13.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    let badgeController = BadgeEnablementController()
    private(set) var timer: Timer!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Create a repeating timer to check focus mode every second and apply badges accordingly
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(tick), userInfo: nil, repeats: true)
    }

    func applicationWillTerminate(_ notification: Notification) {
        // stop tick timer
        timer.invalidate()
        // bring dock badges back
        badgeController.restoreBadges()
    }

    @objc func tick() {
        if shouldHideApplicationBadges {
            badgeController.turnOffAllBadges()
        } else {
            badgeController.restoreBadges()
        }
    }

    var shouldHideApplicationBadges: Bool {
        guard let activeModeIdentifier = AssertionsFile.current.activeModeIdentifier,
              let activeMode = ModeConfigurationsFile.current.modeConfigurations.first(where: { $0.mode.modeIdentifier == activeModeIdentifier }) else {
            return false
        }
        return activeMode.configuration.shouldHideApplicationBadges
    }

}
