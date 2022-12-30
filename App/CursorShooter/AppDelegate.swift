//
//  AppDelegate.swift
//  CursorShooter
//
//  Created by maki on 2022/12/29.
//

import AppKit
import Foundation

class AppDelegate: NSObject, NSApplicationDelegate, ObservableObject {
    private var window: NSWindow!

    func applicationDidFinishLaunching(_ notification: Notification) {
        guard let mainScreenFrame = NSScreen.main?.frame else {
            return
        }

        window = NSWindow(contentRect: mainScreenFrame, styleMask: [], backing: .buffered, defer: false, screen: nil)
        window.backgroundColor = .clear
        window.contentViewController = InvisibleViewController()
        window.makeKeyAndOrderFront(nil)
    }
}
