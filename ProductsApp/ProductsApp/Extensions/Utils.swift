//
//  Array.swift
//  ProductsApp
//
//  Created by Daniel Alejandro Pulido Sepulveda on 27/11/23.
//

import Foundation
import UIKit

extension Collection {
    func at(_ index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

extension UIView {
    class var viewID: String {
        return "\(self)"
    }
}

extension UIImageView {
    func load(url: URL, completion: ((UIImage) -> Void)? = nil, errorClosure: ((Error?) -> Void)? = nil) {
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let data = data,
                  error == nil else {
                DispatchQueue.performUIUpdate {
                    errorClosure?(error)
                }
                return
            }
            DispatchQueue.performUIUpdate {
                if let image = UIImage(data: data) {
                    self?.image = image
                    completion?(image)
                }
            }
        }
        task.resume()
    }
}

extension DispatchQueue {
    static func performUIUpdate(using closure: @escaping () -> Void) {
        if Thread.isMainThread {
            closure()
        } else {
            main.async(execute: closure)
        }
    }
}
