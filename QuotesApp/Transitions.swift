//
//  Transitions.swift
//  QuotesIOSApp
//
// Resourced used: https://stackoverflow.com/questions/3073520/animate-text-change-in-uilabel

import Foundation
import UIKit

extension UIView {
    func moveInTransition(_ duration:CFTimeInterval) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
                                                            CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.moveIn
        animation.duration = duration
        layer.add(animation, forKey: CATransitionType.moveIn.rawValue)
    }
    
    func revealTransition(_ duration:CFTimeInterval) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
                                                            CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.reveal
        animation.duration = duration
        layer.add(animation, forKey: CATransitionType.reveal.rawValue)
    }
}


