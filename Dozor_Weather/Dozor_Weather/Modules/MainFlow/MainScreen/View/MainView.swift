//
//  MainView.swift
//  Dozor_Weather
//
//  Created by Muraviov Kyrylo on 27.09.2024.
//

import UIKit
import SnapKit

class MainView: UIView {
    
    let scrollView: UIScrollView = {
        let obj = UIScrollView()
        obj.showsVerticalScrollIndicator = false
        obj.showsHorizontalScrollIndicator = false
        obj.bounces = true
        obj.contentInsetAdjustmentBehavior = .never
        return obj
    }()
    
    let contentView: MainContentView = {
        let obj = MainContentView()
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
        
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
        }
        
        contentView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.width.equalToSuperview()
        }
    }
}
