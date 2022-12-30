//
//  CursorShooterApp.swift
//  CursorShooter
//
//  Created by maki on 2022/12/29.
//

import AppKit
import SwiftUI

@main
struct CursorShooterApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        MenuBarExtra("CursorShooter.app", systemImage: "cursorarrow.click") {
            VStack {
                Button("Settings...") {
                    NSApp.sendAction(Selector(("showSettingsWindow:")), to: nil, from: nil)
                    NSApp.activate(ignoringOtherApps: true)

                }
                .keyboardShortcut(",")
                Divider()
                Button("Quit CursorShooter") {
                    NSApplication.shared.terminate(nil)
                }
                .keyboardShortcut("q")
            }
        }

        Settings {
            SettingsView()
        }
    }
}
