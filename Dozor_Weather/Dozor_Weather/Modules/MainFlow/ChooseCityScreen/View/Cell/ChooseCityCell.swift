//
//  ChooseCityCell.swift
//  Dozor_Weather
//
//  Created by Muraviov Kyrylo on 30.09.2024.
//

import Foundation
import UIKit

class ChooseCityCell: UITableViewCell,Reusable {
    
    var cityModel: CityModel? {
        didSet {
            handleUI()
        }
    }
    
    let titleLabel: UILabel = {
        let obj = UILabel()
        obj.font = .theme(.bold, 24)
        obj.adjustsFontSizeToFitWidth = true
        obj.textAlignment = .left
        return obj
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        selectionStyle = .gray
        backgroundColor = .clear
        
        contentView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24.sizeW)
            make.top.bottom.equalToSuperview().inset(6.sizeH)
        }
    }
}

//MARK: - HandleUI
extension ChooseCityCell {
    private func handleUI() {
        titleLabel.text = cityModel?.name
    }
}
