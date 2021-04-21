//
//  PEAnimationOptions.swift
//  ButtonPressEffect
//
//  Created by Gökhan Mandaci on 21.04.2021.
//

import UIKit

struct PEAnimationOptions {
    var touchDownDelay: TimeInterval = 0
    var touchDownUsingSpringWithDamping: CGFloat = 1.0
    var touchDownInitialSpringVelocity: CGFloat = 1.0
    var touchDownOptions: UIView.AnimationOptions = .curveLinear
    var touchUpDelay: TimeInterval = 0
    var touchUpUsingSpringWithDamping: CGFloat = 1.0
    var touchUpInitialSpringVelocity: CGFloat = 1.0
    var touchUpOptions: UIView.AnimationOptions = .curveLinear
}
