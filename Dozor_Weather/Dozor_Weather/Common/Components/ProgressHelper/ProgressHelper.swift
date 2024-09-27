//
//  ProgressHelper.swift
//  Dozor_Weather
//
//  Created by Muraviov Kyrylo on 27.09.2024.
//

import UIKit

class ProgressHelper: NSObject {
    static var progressView: ProgressHelperView?
    
    static func show() {
        DispatchQueue.main.async {
            if progressView?.superview == nil {
                progressView = ProgressHelperView()
                if let keyWindow = UIApplication.shared.keyWindow,
                   let progressView = self.progressView {
                    keyWindow.addSubview(progressView)
                    progressView.activityIndicator.startAnimating()
                    
                    progressView.snp.makeConstraints { (make) in
                        make.edges.equalToSuperview()
                    }
                }
            }
        }
    }
    
    static func hide() {
        DispatchQueue.main.async {
            self.progressView?.activityIndicator.stopAnimating()
            self.progressView?.removeFromSuperview()
        }
    }
}

