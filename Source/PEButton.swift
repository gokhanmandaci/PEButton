//
//  PEButton.swift
//  ButtonPressEffect
//
//  Created by Gökhan Mandaci on 20.04.2021.
//

import UIKit

class PEButton: UIButton {
    var options = PEOptions()
    var animationOptions = PEAnimationOptions()
    private var animatingView: UIView? = nil
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
    
    private func delay(_ seconds: Double, completionHandler: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + DispatchTimeInterval.milliseconds(Int(seconds * 1000.0)),
            execute: completionHandler)
    }
}

// MARK: - Public Methods
extension PEButton {
    func pressEffect(_ completionHandler: @escaping () -> Void) {
        setTouch()
        delay(options.touchDownDuration) { [self] in
            setTouchDragOutside()
            delay(options.touchUpDuration) {
                completionHandler()
            }
        }
    }
    
    func activate(on view: UIView? = nil) {
        animatingView = view ?? self
        touchAnimation = true
    }
    
    func deactivate() {
        animatingView = nil
        touchAnimation = true
    }
}
