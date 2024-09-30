//
//  CAGradientLayer.swift
//  Dozor_Weather
//
//  Created by Muraviov Kyrylo on 28.09.2024.
//

import UIKit

extension CAGradientLayer {
    static func gradientLayer(for style: GradientStylesModel?) -> Self {
        guard let style = style else { return Self() }
        let layer = Self()
        layer.colors = style.colors
        layer.type = .axial
        layer.locations = style.locations
        layer.cornerRadius = style.cornerRadius
        layer.masksToBounds = true
        layer.maskedCorners = style.maskedCorners
        return layer
        }
}
