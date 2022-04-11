//
//  UIViewController+.swift
//  JournalByCloudKit
//
//  Created by James Hager on 4/11/22.
//

import UIKit

extension UIViewController {
    
    func presentErrorAlert(for error: Error) {
        let alertController = UIAlertController(title: "ERROR", message: error.localizedDescription, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .cancel)
        alertController.addAction(ok)
        present(alertController, animated: true)
    }
}
