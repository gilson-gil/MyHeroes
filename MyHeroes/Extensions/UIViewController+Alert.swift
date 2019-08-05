//
//  UIViewController+Alert.swift
//  MyHeroes
//
//  Created by Gilson Gil on 05/08/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import UIKit

extension UIViewController {
    func alert(title: String?,
               message: String?,
               cancelTitle: String = "OK",
               cancelAction: (() -> Void)? = nil,
               okTitle: String? = nil,
               okAction: (() -> Void)? = nil) {
        let alert: UIAlertController = .init(title: title, message: message, preferredStyle: .alert)
        let cancelAlertAction: UIAlertAction = .init(title: cancelTitle, style: .cancel) { _ in
            cancelAction?()
        }
        alert.addAction(cancelAlertAction)
        if let okTitle = okTitle {
            let okAlertAction: UIAlertAction = .init(title: okTitle, style: .default) { _ in
                okAction?()
            }
            alert.addAction(okAlertAction)
        }
        present(alert, animated: true, completion: nil)
    }
}
