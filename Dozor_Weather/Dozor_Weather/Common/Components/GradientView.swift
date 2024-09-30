//
//  GradientView.swift
//  Dozor_Weather
//
//  Created by Muraviov Kyrylo on 28.09.2024.
//

import UIKit

class GradientView: UIView {
    
    var gradient: CAGradientLayer? {
        didSet {
            removeGradientLayer()
            setup()
            self.layoutSubviews()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradient?.frame = self.bounds
    }
    
    private func setup() {
        guard let gradient else { return }
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    private func removeGradientLayer() {
        if let layers = layer.sublayers {
            for aLayer in layers {
                if aLayer is CAGradientLayer {
                    aLayer.removeFromSuperlayer()
                    break
                }
            }
        }
    }
}
