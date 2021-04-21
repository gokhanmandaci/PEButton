//
//  PEConfig.swift
//  ButtonPressEffect
//
//  Created by Gökhan Mandaci on 20.04.2021.
//

import UIKit

struct PEOptions {
    /// Duration of down scale animation. Default value = 0.1
    var touchDownDuration: TimeInterval = 0.1
    /// Duration of up scale animation. Default value = 0.1
    var touchUpDuration: TimeInterval = 0.1
    
    /// Scale factor for X axis. Touch Down
    var touchDownScaleX: CGFloat = 0.9
    /// Scale factor for Y axis. Touch Down
    var touchDownScaleY: CGFloat = 0.9
    /// Scale factor for X axis. Touch Up
    var touchUpScaleX: CGFloat?
    /// Scale factor for Y axis. Touch Up
    var touchUpScaleY: CGFloat?
    
    /// Touch down alpha value. Default 0.8
    var touchDownAlpha: CGFloat = 0.8
    /// Touch down alpha value. Default 1
    var touchUpAlpha: CGFloat = 1
}
