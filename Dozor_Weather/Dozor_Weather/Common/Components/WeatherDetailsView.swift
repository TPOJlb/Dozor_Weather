//
//  WeatherDetailsView.swift
//  Dozor_Weather
//
//  Created by Muraviov Kyrylo on 28.09.2024.
//

import UIKit

class WeatherDetailsView: UIView {
    
    var model: WeatherDetailsModel? {
        didSet {
            handleUI()
        }
    }
    
    let helperView: UIView = {
        let obj = UIView()
        return obj
    }()
    
    let imageView: UIImageView = {
        let obj = UIImageView()
        return obj
    }()
    
    let titleLabel: UILabel = {
        let obj = UILabel()
        obj.textAlignment = .center
        obj.textColor = .colorText
        obj.font = .theme(.regular, 12)
        return obj
    }()
    
    let descriptionLabel: UILabel = {
        let obj = UILabel()
        obj.textAlignment = .center
        obj.textColor = .color7DA0CA
        obj.font = .theme(.semibold, 10)
        return obj
    }()
    
    let stackView: UIStackView = {
        let obj = UIStackView()
        obj.axis = .vertical
        obj.spacing = 1
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
        backgroundColor = .clear
        
        addSubview(stackView)
        stackView.addArrangedSubview(helperView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)
        helperView.addSubview(imageView)
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { make in
            make.size.equalTo(24.sizeH)
            make.top.bottom.equalToSuperview()
            make.leading.trailing.greaterThanOrEqualToSuperview().priority(1)
            make.centerX.equalToSuperview()
        }
    }
}

//MARK: HandleUI
extension WeatherDetailsView {
    private func handleUI() {
        guard let model else { return }
        
        imageView.image = model.type.image
        titleLabel.text = model.title
        descriptionLabel.text = model.type.title    }
}
