//
//  Presenter.swift
//  FilmsAppSUI
//
//  Created by Виталий Баник on 10.10.2020.
//  Copyright © 2020 Виталий Баник. All rights reserved.
//

import SwiftUI

// MARK: - Presenter
open protocol Presenter: ObservableObject {
    
    open var container: Container? { get set }
    
    open func onClickError()
}

open extension Presenter {
    
    open func onClickError() {}
}
