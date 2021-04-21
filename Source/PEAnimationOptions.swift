//
//  PEAnimationOptions.swift
//  ButtonPressEffect
//
//  Created by Gökhan Mandaci on 21.04.2021.
//

import UIKit

struct PEAnimationOptions {
    /// Delays down animation if necessary. Default 0
    var touchDownDelay: TimeInterval = 0
    /// Down spring with damping value. Default 1.0
    var touchDownUsingSpringWithDamping: CGFloat = 1.0
    /// Down initial spring velocity value. Default 1.0
    var touchDownInitialSpringVelocity: CGFloat = 1.0
    /// Down animation option. Default .curveEaseInOut
    var touchDownOptions: UIView.AnimationOptions = .curveEaseInOut
    /// Delays up animation if necessary. Default 0
    var touchUpDelay: TimeInterval = 0
    /// Up spring with damping value. Default 1.0
    var touchUpUsingSpringWithDamping: CGFloat = 1.0
    /// Up initial spring velocity value. Default 1.0
    var touchUpInitialSpringVelocity: CGFloat = 1.0
    /// Up animation option. Default .curveEaseInOut
    var touchUpOptions: UIView.AnimationOptions = .curveEaseInOut
}
