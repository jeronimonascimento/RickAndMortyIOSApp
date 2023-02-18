//
//  Extensions.swift
//  RickAndMorty
//
//  Created by Jerônimo Nascimento on 06/02/23.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach({
            addSubview($0)
        })
    }
}
