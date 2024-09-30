//
//  MainCollectionCell.swift
//  Dozor_Weather
//
//  Created by Muraviov Kyrylo on 28.09.2024.
//

import UIKit

class MainCollectionCell: UICollectionViewCell, Reusable {
    
    var model: List? {
        didSet {
            handleUI()
        }
    }
    
    let conteinerView: UIView = {
        let obj = UIView()
        obj.backgroundColor = .clear
        obj.clipsToBounds = true
        obj.layer.cornerRadius = 15.sizeH
        obj.layer.borderWidth = 1
        obj.layer.borderColor = .theme(.color5483B3)
        return obj
    }()
    
    let temperatureLabel: UILabel = {
        let obj = UILabel()
        obj.font = .theme(.bold, 16)
        obj.textAlignment = .center
        obj.textColor = .color7DA0CA
        return obj
    }()
    
    let imageView: UIImageView = {
        let obj = UIImageView()
        return obj
    }()
    
    let timeLabel: UILabel = {
        let obj = UILabel()
        obj.font = .theme(.bold, 16)
        obj.textAlignment = .center
        obj.textColor = .color7DA0CA
        return obj
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    override var isSelected: Bool {
        get {
            return super.isSelected
        }
        set {
            conteinerView.backgroundColor = newValue ? .colorC1E8FF : .clear
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setup() {
        self.backgroundColor = .clear
        
        contentView.addSubview(conteinerView)
        conteinerView.addSubview(temperatureLabel)
        conteinerView.addSubview(imageView)
        conteinerView.addSubview(timeLabel)
        
        conteinerView.snp.makeConstraints { make in
            make.height.equalTo(84.sizeH)
            make.width.equalTo(56.sizeH)
        }
        
        temperatureLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4.sizeH)
            make.leading.trailing.equalToSuperview().inset(5.sizeW)
        }
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(temperatureLabel.snp.bottom)
            make.centerX.equalToSuperview()
            make.size.equalTo(40.sizeH)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(5.sizeW)
            make.bottom.equalToSuperview().offset(-4.sizeH)
        }
    }
}

//MARK: - HandleUI
extension MainCollectionCell {
    private func handleUI() {
        guard let model else { return }
        
        let temperature = model.main!.temp!.description.components(separatedBy: ".").first
        temperatureLabel.text = temperature! + "°"
        imageView.image = model.weather?[0]?.icon?.image
        timeLabel.text = model.dt_txt?.utcToLocal(dateFormat: "HH:mm")
    }
}
