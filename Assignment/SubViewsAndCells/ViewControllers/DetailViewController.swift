//
//  DetailViewController.swift
//  Assignment
//
//  Created by Senapathi Rajesh on 30/12/19.
//  Copyright © 2019 Senapathi Rajesh. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var imageView  = ImageLoader()
    var imageUrl: String?
    var detailLabel: UILabel = {
        let label = UILabel()
        label.font =  UIFont.systemFont(ofSize: 14)
        label.textColor =  #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        label.backgroundColor = UIColor.white
         label.clipsToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.sizeToFit()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
       setupImageViewandLabel()
    }

func setupImageViewandLabel() {
    self.title = "DetailViewController"
    self.view.backgroundColor = .white
     view?.addSubview(imageView)
     self.view.addSubview(detailLabel)
    let guide = view.safeAreaLayoutGuide
    loadImageViewWithJsonImage()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.topAnchor.constraint(equalTo: guide.topAnchor, constant: 10).isActive = true
    imageView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 10).isActive = true
    imageView.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -10).isActive = true
    imageView.heightAnchor.constraint(equalToConstant: 250).isActive = true
    imageView.contentMode = .scaleToFill
    imageView.layer.cornerRadius = 5
    imageView.layer.masksToBounds = true
    detailLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20).isActive  = true
    detailLabel.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 10).isActive = true
    detailLabel.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -10).isActive = true
}
    func loadImageViewWithJsonImage() {
        imageView.image = UIImage(named: Constants.ImageConstatnts.PlaceholderImageName)
        imageView.loadImageWithUrl(URL(string: imageUrl ?? Constants.API.PLACEHOLDERURL)!)
    }
}
