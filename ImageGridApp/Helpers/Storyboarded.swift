//
//  Storyboarded.swift
//  animationTesting
//
//  Created by YuriyFpc on 1/31/19.
//  Copyright © 2019 YuriyFpc. All rights reserved.
//

import Foundation
import UIKit

enum Storyboards: String {
    case TrainingList = "Main"
}

protocol Storyboarded {
    static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiate() -> Self {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: id) as! Self
    }
    
    static func instantiate(storyboard: Storyboards) -> Self {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: storyboard.rawValue, bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: id) as! Self
    }
}
