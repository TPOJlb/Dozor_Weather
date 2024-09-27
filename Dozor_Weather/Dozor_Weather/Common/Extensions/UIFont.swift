//
//  UIFont.swift
//  Dozor_Weather
//
//  Created by Muraviov Kyrylo on 27.09.2024.
//

import UIKit.UIFont

extension UIFont {
    static func theme(_ fontType: UIFont.Weight, _ fontSize: CGFloat) -> UIFont {
        return systemFont(ofSize: fontSize.sizeH, weight: fontType)
    }
}
