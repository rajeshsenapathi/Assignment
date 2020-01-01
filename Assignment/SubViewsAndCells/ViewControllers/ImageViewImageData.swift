//
//  ImageLoader.swift
//  Assignment
//
//  Created by Senapathi Rajesh on 31/12/19.
//  Copyright © 2019 Senapathi Rajesh. All rights reserved.
//

import Foundation
import UIKit

class ImageLoader: UIImageView {

    var imageURL: URL?
    var imageCache = NSCache<AnyObject, AnyObject>()
    let activityIndicator = UIActivityIndicatorView()

    func loadImageWithUrl(_ url: URL) {
        activityIndicator.color = .darkGray
        addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imageURL = url
        image = nil
        activityIndicator.startAnimating()
        if let imageFromCache = imageCache.object(forKey: url as AnyObject) as? UIImage {

            self.image = imageFromCache
            activityIndicator.stopAnimating()
            return
        }
        URLSession.shared.dataTask(with: url, completionHandler: { (data, _, error) in
            if error != nil {
                print(error as Any)
                DispatchQueue.main.async(execute: {
                    self.activityIndicator.stopAnimating()
                })
                return
            }
            DispatchQueue.main.async(execute: {
                if self.image == nil {
                    self.image = UIImage(named: Constants.ImageConstatnts.PlaceholderImageName)
                }
                if let unwrappedData = data, let imageToCache = UIImage(data: unwrappedData) {
                    if self.imageURL == url {
                        self.image = imageToCache
                    }
                    self.imageCache.setObject(imageToCache, forKey: url as AnyObject)
                }
                self.activityIndicator.stopAnimating()
            })
        }).resume()
    }
}
