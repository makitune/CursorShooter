//
//  InvisibleViewController.swift
//  CursorShooter
//
//  Created by maki on 2022/12/29.
//

import AppKit

final class InvisibleViewController: NSViewController {
    override func loadView() {
        guard let mainScreenFrame = NSScreen.main?.frame else {
            assertionFailure()
            return
        }

        view = NSView(frame: mainScreenFrame)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        NSEvent.addLocalMonitorForEvents(matching: .flagsChanged) { [weak self] event in
            guard event.modifierFlags.contains(.option) else {
                return nil
            }

            self?.drawRipple()
            return nil
        }

        NSEvent.addGlobalMonitorForEvents(matching: .flagsChanged) { [weak self] event in
            guard event.modifierFlags.contains(.option) else {
                return
            }

            self?.drawRipple()
        }
    }

    override func viewDidLayout() {
        super.viewDidLayout()
    }

    func drawRipple() {
        let mousePoint = NSEvent.mouseLocation

        let rippleView = RippleView(frame: .init(origin: mousePoint, size: .init(width: 100, height: 100)))
        view.addSubview(rippleView)
    }
}
