//
//  MainView.swift
//  Dozor_Weather
//
//  Created by Muraviov Kyrylo on 27.09.2024.
//

import UIKit
import SnapKit

class MainView: UIView {
    
    var location: LocationModel? {
        didSet {
            cityLabel.text = location?.city
        }
    }
    
    let cityLabel: UILabel = {
        let obj = UILabel()
        obj.textColor = .colorText
        obj.textAlignment = .center
        obj.font = .theme(.medium, 24)
        return obj
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setup() {
        backgroundColor = .colorBackground
        
        addSubview(cityLabel)
        
        cityLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(10.sizeH)
            make.leading.trailing.equalToSuperview().inset(40.sizeW)
        }
    }
}
