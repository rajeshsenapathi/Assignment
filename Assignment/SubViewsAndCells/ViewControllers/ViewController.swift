//
//  ViewController.swift
//  iOSProficiencyExercise
//
//  Created by Senapathi Rajesh on 26/12/19.
//  Copyright © 2019 Senapathi Rajesh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var jsonRowsArray: [Rows]?
    var handler =  ApiHandler()
    private let refreshControl = UIRefreshControl()
    let  canadaTableView: UITableView = {
        let t = UITableView()
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5), title: Constants.AlertConstatnts.Activity_Title, center: self.view.center )
        }
        self.view.addSubview(canadaTableView)
        canadaTableView.register(CustomTableViewCell.self, forCellReuseIdentifier: Constants.SubViewCellConstants.Custom_TableCell_resuseIdentiFier)
        canadaTableView.delegate = self
        canadaTableView.dataSource = self
        self.view.addSubview(canadaTableView)
        canadaTableView.translatesAutoresizingMaskIntoConstraints = false
        canadaTableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        canadaTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -10).isActive = true
        canadaTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        canadaTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        canadaTableView.tableFooterView = UIView()
        refreshControl.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 0.25, green: 0.72, blue: 0.85, alpha: 1.0)]
        let attributedTitle = NSAttributedString(string: Constants.AlertConstatnts.REFRESH_CONTROL_Title, attributes: attributes)
        refreshControl.attributedTitle = attributedTitle
        refreshControl.addTarget(self, action: #selector(refreshdata(_:)), for: .valueChanged)
        if #available(iOS 10.0, *) {
            canadaTableView.refreshControl = refreshControl
        } else {
            canadaTableView.addSubview(refreshControl)
        }
        
        if Reachability.isConnectedToNetwork(){
            print(Constants.InternetConnectivity.NETWORK_SUCCESS_MSG)
            self.getItemsList()
        }else{
            print(Constants.InternetConnectivity.NETWORK_Failure_MSG)
            self.presentNetowrkAlertWithTwoButton(withTitle: Constants.AlertConstatnts.TITLE, message: Constants.AlertConstatnts.Title_Msg) { (UiAlertActionIn) in
                DispatchQueue.main.async {
                    self.view.activityStopAnimating()
                }
                self.getItemsList()
            }
            return;
        }
    }
    
    @objc private func refreshdata(_ sender: Any) {
        self.getItemsList()
        self.refreshControl.endRefreshing()
    }
    
    func getItemsList(){

        handler.makeAPICall(url: Constants.API.BASEURL, method: .GET, success: { (data, response, error) in
            guard let data = data else{return}
            let responseStrInISOLatin = String(data: data, encoding: String.Encoding.isoLatin1)
            guard let modifiedDataInUTF8Format = responseStrInISOLatin?.data(using: String.Encoding.utf8) else {
                return
            }
            do {
                let decoder = JSONDecoder()
                let jsonObj = try decoder.decode(ModelJsonObject.self, from: modifiedDataInUTF8Format)
                self.jsonRowsArray = jsonObj.rows!
                DispatchQueue.main.async {
                    self.canadaTableView.reloadData()
                    self.title = jsonObj.title
                    self.view.activityStopAnimating()
                }
            } catch {
                print(error.localizedDescription)
            }
        },
                            failure: { (data, response, error) in
                                print(error?.localizedDescription ?? Constants.Error.ERROR_MSG)
        })
    }
    
}


