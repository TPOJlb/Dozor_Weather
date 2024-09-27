//
//  ProgressHelperView.swift
//  Dozor_Weather
//
//  Created by Muraviov Kyrylo on 27.09.2024.
//

import UIKit

class ProgressHelperView: UIView {
    
    var activityIndicator: ActivityIndicator = {
        let obj = ActivityIndicator()
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        backgroundColor = .clear
        
        addSubview(activityIndicator)
        
        activityIndicator.snp.makeConstraints { (make) in
            make.size.equalTo(64.sizeW)
            make.center.equalToSuperview()
        }
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        activityIndicator.startAnimating()
    }
    
    override func removeFromSuperview() {
        super.removeFromSuperview()
        activityIndicator.stopAnimating()
    }
}

