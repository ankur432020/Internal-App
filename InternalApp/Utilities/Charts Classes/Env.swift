//
//  Env.swift
//  InternalApp
//
//  Created by AUGURS Technologies on 14/03/20.
//  Copyright © 2020 AUGURS Technologies. All rights reserved.
//

import Foundation
import UIKit
class Env {
    
    static var iPad: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
}
