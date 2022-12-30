//
//  RippleView.swift
//  CursorShooter
//
//  Created by maki on 2022/12/30.
//

import AppKit

class RippleView: NSView {
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)

        let origin = CGPoint(x: frame.origin.x - frame.width / 2, y: frame.origin.y - frame.height / 2)
        self.frame = .init(origin: origin, size: frame.size)
        wantsLayer = true

        let layer = CAShapeLayer()
        layer.frame = bounds
        layer.fillColor = NSColor.clear.cgColor
        layer.strokeColor = NSColor.white.cgColor
        layer.lineWidth = 5

        layer.shadowColor = NSColor.shadowColor.cgColor
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.9

        let path = NSBezierPath()
        path.appendOval(in: bounds)
        layer.path = path.cgPath

        self.layer?.addSublayer(layer)
        setAnimattion(to: layer)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setAnimattion(to layer: CALayer) {
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.fromValue = 0
        scaleAnimation.toValue = 0.8
        scaleAnimation.timingFunction = .init(name: .easeIn)

        let opacityAnimaiton = CABasicAnimation(keyPath: "opacity")
        opacityAnimaiton.fromValue = 1
        opacityAnimaiton.toValue = 0
        opacityAnimaiton.duration = 0.05
        opacityAnimaiton.beginTime = 0.15
        opacityAnimaiton.timingFunction = .init(name: .easeIn)

        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [scaleAnimation, opacityAnimaiton]
        animationGroup.duration = 0.2
        animationGroup.isRemovedOnCompletion = false
        animationGroup.fillMode = .forwards
        animationGroup.delegate = self
        layer.add(animationGroup, forKey: nil)
    }
}

extension RippleView: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        guard flag else {
            return
        }

        removeFromSuperview()
    }
}

extension NSBezierPath {

    /// A `CGPath` object representing the current `NSBezierPath`.
    var cgPath: CGPath {
        let path = CGMutablePath()
        let points = UnsafeMutablePointer<NSPoint>.allocate(capacity: 3)

        if elementCount > 0 {
            var didClosePath = true

            for index in 0..<elementCount {
                let pathType = element(at: index, associatedPoints: points)

                switch pathType {
                    case .moveTo:
                        path.move(to: points[0])
                    case .lineTo:
                        path.addLine(to: points[0])
                        didClosePath = false
                    case .curveTo:
                        path.addCurve(to: points[2], control1: points[0], control2: points[1])
                        didClosePath = false
                    case .closePath:
                        path.closeSubpath()
                        didClosePath = true
                    @unknown default:
                        break
                }
            }

            if !didClosePath { path.closeSubpath() }
        }

        points.deallocate()
        return path
    }
}
