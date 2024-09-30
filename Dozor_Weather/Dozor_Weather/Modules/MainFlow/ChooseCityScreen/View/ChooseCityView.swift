//
//  ChooseCityView.swift
//  Dozor_Weather
//
//  Created by Muraviov Kyrylo on 30.09.2024.
//

import UIKit

class ChooseCityView: UIView {
    
    let backButton: UIButton = {
        let obj = UIButton(type: .system)
        obj.setImage(.buttonArrow.withRenderingMode(.alwaysOriginal), for: .normal)
        obj.tintColor = .clear
        return obj
    }()
    
    let textField: UITextField = {
        let obj = UITextField()
        obj.font = .theme(.medium, 24)
        obj.placeholder = .TextField.placeholder
        return obj
    }()
    
    let separateLine: UIView = {
        let obj = UIView()
        obj.backgroundColor = .color7DA0CA
        return obj
    }()
    
    let tableView: UITableView = {
        let obj = UITableView()
        obj.separatorStyle = .singleLine
        obj.backgroundColor = .clear
        obj.showsVerticalScrollIndicator = true
        obj.allowsMultipleSelection = false
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
        
        addSubview(textField)
        addSubview(separateLine)
        addSubview(tableView)
        addSubview(backButton)
        
        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100.sizeH)
            make.leading.equalToSuperview().offset(24.sizeW)
        }
        
        textField.snp.makeConstraints { make in
            make.centerY.equalTo(backButton)
            make.trailing.equalToSuperview().inset(24.sizeW)
            make.leading.equalTo(backButton.snp.trailing).offset(10.sizeW)
            make.height.equalTo(60.sizeH)
        }
        
        separateLine.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(24.sizeW)
            make.height.equalTo(1)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(10.sizeH)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}

