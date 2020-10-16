//
//  Configurator.swift
//  FilmsAppSUI
//
//  Created by Виталий Баник on 10.10.2020.
//  Copyright © 2020 Виталий Баник. All rights reserved.
//

import SwiftUI
import UIKit

// MARK: - Configurator
open protocol Configurator {
    open associatedtype Content: Contentable
    
    open static func createScreen(configureBlock: ((Content?) -> ())?) -> UIViewController
}
