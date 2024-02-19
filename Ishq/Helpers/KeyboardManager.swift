//
//  KeyboardManager.swift
//  Ishq
//
//  Created by Sishir Mohan on 2/18/24.
//

import Foundation
import UIKit

extension UIView {
    func hideKeyboard() {
        self.endEditing(true)
    }
}

extension UIApplication {
    func hideKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
