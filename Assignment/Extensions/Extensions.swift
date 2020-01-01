//
//  Extensions.swift
//  iOSProficiencyExercise
//
//  Created by Senapathi Rajesh on 26/12/19.
//  Copyright © 2019 Senapathi Rajesh. All rights reserved.
//

import Foundation
import UIKit
extension UIView {
    func activityStartAnimating(activityColor: UIColor, backgroundColor: UIColor, title: String, center: CGPoint) {
    let backgroundView = UIView()
    backgroundView.frame = CGRect.init(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
    backgroundView.backgroundColor = backgroundColor
    backgroundView.tag = 475647
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    activityIndicator = UIActivityIndicatorView(frame: CGRect.init(x: 0, y: 0, width: 50, height: 50))
    activityIndicator.center = self.center
    activityIndicator.hidesWhenStopped = true
    activityIndicator.style = UIActivityIndicatorView.Style.large
    let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
    titleLabel.text = title
    titleLabel.textColor = UIColor.black
    activityIndicator.color = activityColor
    activityIndicator.startAnimating()
    self.isUserInteractionEnabled = false
    backgroundView.addSubview(activityIndicator)
    activityIndicator.addSubview(titleLabel)
    self.addSubview(backgroundView)
}

func activityStopAnimating() {
    if let background = viewWithTag(475647) {
        background.removeFromSuperview()
    }
    self.isUserInteractionEnabled = true
}

}
