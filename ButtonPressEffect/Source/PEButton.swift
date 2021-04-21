//
//  PEButton.swift
//  ButtonPressEffect
//
//  Created by Gökhan Mandaci on 20.04.2021.
//

import UIKit

class PEButton: UIButton {
    /// Options for press effect. Default values are set.
    var options = PEOptions()
    /// Options for press animation. Default values are set.
    var animationOptions = PEAnimationOptions()
    /// Assign a UIView to animate
    private var animatingView: UIView? = nil
    /// Adds and removes targets when set.
    private var touchAnimation: Bool = false {
        didSet {
            if touchAnimation {
                self.addTarget(self, action: #selector(setTouch),
                               for: .touchDown)
                self.addTarget(self, action: #selector(setTouchDragOutside),
                               for: .touchDragOutside)
            } else {
                self.removeTarget(self, action: #selector(setTouch),
                                  for: .touchDown)
                self.removeTarget(self, action: #selector(setTouchDragOutside),
                                  for: .touchDragOutside)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    ///s Touch down animation
    @objc private func setTouch() {
        if let aView = animatingView {
            UIView.animate(withDuration: options.touchDownDuration,
                           delay: animationOptions.touchDownDelay,
                           usingSpringWithDamping: animationOptions.touchDownUsingSpringWithDamping,
                           initialSpringVelocity: animationOptions.touchDownInitialSpringVelocity,
                           options: animationOptions.touchDownOptions) { [self] in
                aView.transform = CGAffineTransform(scaleX: options.touchDownScaleX,
                                                    y: options.touchDownScaleY)
                aView.alpha = options.touchDownAlpha
            }
            
        }
    }
    
    /// Touch drag outside animation. Works also on press
    @objc private func setTouchDragOutside() {
        if let aView = animatingView {
            UIView.animate(withDuration: options.touchUpDuration,
                           delay: animationOptions.touchUpDelay,
                           usingSpringWithDamping: animationOptions.touchUpUsingSpringWithDamping,
                           initialSpringVelocity: animationOptions.touchUpInitialSpringVelocity,
                           options: animationOptions.touchUpOptions) { [self] in
                if let scaleX = options.touchUpScaleX,
                   let scaleY = options.touchUpScaleY {
                    aView.transform = CGAffineTransform(scaleX: scaleX,
                                                        y: scaleY)
                    aView.alpha = options.touchUpAlpha
                } else {
                    aView.transform = .identity
                    aView.alpha = options.touchUpAlpha
                }
            }
        }
    }
    
    /// A helper function to make delay simpler.
    private func delay(_ seconds: Double, completionHandler: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + DispatchTimeInterval.milliseconds(Int(seconds * 1000.0)),
            execute: completionHandler)
    }
}

// MARK: - Public Methods
extension PEButton {
    /// Call this function to create press effect on the PEButton or given UIView
    /// - Parameter completionHandler: Callback after press effect animations finished.
    func pressEffect(_ completionHandler: @escaping () -> Void) {
        setTouch()
        delay(options.touchDownDuration) { [self] in
            setTouchDragOutside()
            delay(options.touchUpDuration) {
                completionHandler()
            }
        }
    }
    
    /// Activates the press effect on a PEButton or given UIView
    /// - Parameter view: The object which will be animated. Default nil activates self
    func activate(on view: UIView? = nil) {
        animatingView = view ?? self
        touchAnimation = true
    }
    
    /// Deactivates the press effect on a PEButton or given UIView
    func deactivate() {
        animatingView = nil
        touchAnimation = false
    }
}
