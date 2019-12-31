//
//  Constants.swift
//  iOSProficiencyExercise
//
//  Created by Senapathi Rajesh on 26/12/19.
//  Copyright © 2019 Senapathi Rajesh. All rights reserved.
//

import Foundation
struct  Constants {
    struct  API {
          static let BASEURL  = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
          static let  PLACEHOLDERURL = "https://via.placeholder.com/300"
    }
    struct  SubViewCellConstants {
        static let CustomTableCellesuseIdentiFier = "CustomTableViewCell"
    }
    struct ImageConstatnts {
        static let PlaceholderImageName = "placeholder"
    }
    struct AlertConstatnts {
        static let CANCELMSG = "Cancel"
         static let RETRYMSG = "Retry"
        static let TITLE  = "ConnectionError"
        static let TitleMsg = "Internet Not Working Click Retry to Refresh"
        static let ActivityTitle  = "Please Wait.."
        static let REFRESHCONTROLTitle = "Pull down To Refresh"
    }
   struct Error {
        static let ERRORMSG = "error"
    }
    struct  InternetConnectivity {
        static let NETWORKSUCCESSMSG = "Internet Connection Available!"
         static let NETWORKFailureMSG = "Internet Connection not Available!"
    }
}
