//
//  ViewController.swift
//  iOSProficiencyExercise
//
//  Created by Senapathi Rajesh on 26/12/19.
//  Copyright © 2019 Senapathi Rajesh. All rights reserved.
//

import UIKit

class ItemsViewController: UIViewController {
    var jsonRowsArray: [Rows]?
    var handler =  ApiHandler()
    var itemsData =  ItemsViewData()
    private let refreshControl = UIRefreshControl()
    let  canadaTableView: UITableView = {
        let tableView = UITableView()
       tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
        self.view?.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5), title: Constants.AlertConstatnts.ActivityTitle,
                                           center: self.view!.center )
              }
        loadTableView()
        if Reachability.isConnectedToNetwork() {
            print(Constants.InternetConnectivity.NETWORKSUCCESSMSG)
            self.refreshTabeleViewWithItems()
        } else {
            print(Constants.InternetConnectivity.NETWORKFailureMSG)
            self.presentNetowrkAlertWithTwoButton(withTitle: Constants.AlertConstatnts.TITLE, message: Constants.AlertConstatnts.TitleMsg) { (uiAlertActionIn) in
                DispatchQueue.main.async {
                    self.view.activityStopAnimating()
                }
                self.refreshTabeleViewWithItems()
            }
            return
        }
    }
 @objc private func refreshdata(_ sender: Any) {
        self.refreshTabeleViewWithItems()
        self.refreshControl.endRefreshing()
    }
    func loadTableView() {
        self.view.addSubview(canadaTableView)
        canadaTableView.register(CustomTableViewCell.self, forCellReuseIdentifier: Constants.SubViewCellConstants.CustomTableCellesuseIdentiFier)
        canadaTableView.delegate = self
        canadaTableView.dataSource = self
        self.view.addSubview(canadaTableView)
        canadaTableView.translatesAutoresizingMaskIntoConstraints = false
        canadaTableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        canadaTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -10).isActive = true
        canadaTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        canadaTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        canadaTableView.tableFooterView = UIView()
        refreshControl.tintColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
          let attributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 0.25, green: 0.72, blue: 0.85, alpha: 1.0)]
         let attributedTitle = NSAttributedString(string: Constants.AlertConstatnts.REFRESHCONTROLTitle, attributes: attributes)
        refreshControl.attributedTitle = attributedTitle
        refreshControl.addTarget(self, action: #selector(refreshdata(_:)), for: .valueChanged)
        if #available(iOS 10.0, *) {
            canadaTableView.refreshControl = refreshControl
        } else {
            canadaTableView.addSubview(refreshControl)
        }
    }
    func refreshTabeleViewWithItems() {
        itemsData.getItemsList { (rows, title) in
            self.jsonRowsArray = rows
            DispatchQueue.main.async {
                self.title = title
                self.canadaTableView.reloadData()
                self.view.activityStopAnimating()
            }
           }
            }
        }
extension ItemsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let jsonCount = self.jsonRowsArray?.count {
            return jsonCount
        } else {
            return 0
        }
    }
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     populateDataToCell(tableView, indexPath: indexPath)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        self.navigationController?.pushViewController(detailVC, animated: true)
        let selectedRow = indexPath.row
        if selectedRow  == indexPath.row {
        detailVC.detailLabel.text  = self.jsonRowsArray?[indexPath.row].description
        detailVC.imageUrl =   self.jsonRowsArray?[indexPath.row].imageHref
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func presentNetowrkAlertWithTwoButton(withTitle title: String, message: String, actionHandler: ((UIAlertAction) -> Void)?) {
        let alertController = UIAlertController(title: title, message: "", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: Constants.AlertConstatnts.CANCELMSG, style: .cancel, handler: actionHandler)
        let retryAction = UIAlertAction(title: Constants.AlertConstatnts.RETRYMSG, style: .default, handler: actionHandler)
        alertController.addAction(cancelAction)
        alertController.addAction(retryAction)
        alertController.preferredAction = retryAction
        self.present(alertController, animated: true, completion: nil)
    }
    func populateDataToCell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.SubViewCellConstants.CustomTableCellesuseIdentiFier, for: indexPath) as? CustomTableViewCell
        cell?.nameLabel.text =  self.jsonRowsArray?[indexPath.row].title
        cell?.profileImageView.loadImageWithUrl(URL(string: self.jsonRowsArray?[indexPath.row].imageHref ?? Constants.API.PLACEHOLDERURL)!)
        cell?.jobTitleDetailedLabel.text = self.jsonRowsArray?[indexPath.row].description
        self.canadaTableView.separatorStyle = .none
        cell?.selectionStyle = .none
        return cell!
    }
}
