//
//  ItemsViewData.swift
//  Assignment
//
//  Created by Senapathi Rajesh on 01/01/20.
//  Copyright © 2020 Senapathi Rajesh. All rights reserved.
//

import Foundation
class ItemsViewData: NSObject {
    let handler = ApiHandler()
    var jsonRowsArray: [Rows]?
    typealias ItemsCompletionHandler = ([Rows], String) -> Void
 static func instance() -> ItemsViewData {
    return ItemsViewData()
}
    func getItemsList(completionHandler: @escaping ItemsCompletionHandler) {
        handler.makeAPICall(url: Constants.API.BASEURL, method: .GET, success: { (data, _, error) in
            guard let data = data else { return }
            let responseStrInISOLatin = String(data: data, encoding: String.Encoding.isoLatin1)
            guard let modifiedDataInUTF8Format = responseStrInISOLatin?.data(using: String.Encoding.utf8) else {
                return
            }
            do {
                let decoder = JSONDecoder()
                let jsonObj = try decoder.decode(ModelJsonObject.self, from: modifiedDataInUTF8Format)
                self.jsonRowsArray = jsonObj.rows
                completionHandler(self.jsonRowsArray!, jsonObj.title!)
            } catch {
                print(error.localizedDescription)
            }
        },
            failure: { (_, _, _) in
                    print("error")
        })
    }
}
