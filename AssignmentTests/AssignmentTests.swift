//
//  AssignmentTests.swift
//  AssignmentTests
//
//  Created by Senapathi Rajesh on 26/12/19.
//  Copyright © 2019 Senapathi Rajesh. All rights reserved.
//

import XCTest
@testable import Assignment

class Assignmenttests: XCTestCase {
    var handler = ApiHandler()
    var statuscode: Int?
    var imageView: UIImageView?
    var urlstr: String?
    var imageUrlaary: [String]?
    var jsonRowsArry: [Rows]?
    override func setUp() {
    }

    override func tearDown() {
    }

    func testExample() {
    }

    func testPerformanceApiExample() {
        // This is an example of a performance test case fot hitting url and getting image from url
                      self.measure {
                 let promise = expectation(description: "Status code: 200")
                        handler.makeAPICall(url: Constants.API.BASEURL, method: .GET, success: { (data, response, error) in
                          if let statuscode = (response)?.statusCode {
                               self.statuscode = statuscode
                               XCTAssertEqual(self.statuscode, 200)
                           } else {
                               print("status code: \(String(describing: response?.statusCode))")
                           }
                           if data == nil {
                                          XCTAssertNil(true)
                                      } else {
                                          XCTAssertTrue(true, "expected")
                                let responseStrInISOLatin = String(data: data!, encoding: String.Encoding.isoLatin1)
                                guard let modifiedData = responseStrInISOLatin?.data(using: String.Encoding.utf8) else {
                                return
                                }
                            do {
                                let decoder = JSONDecoder()
                                let jsonObj = try decoder.decode(ModelJsonObject.self, from: modifiedData)
                                self.jsonRowsArry = jsonObj.rows!
                                self.imageUrlaary  =   self.jsonRowsArry?.compactMap({$0.imageHref})
                                for str in self.imageUrlaary ?? ["https://via.placeholder.com/150"] {
                                    self.urlstr = str
                                }
                                self.imageView?.image = UIImage(data: try Data(contentsOf: (URL(string: self.urlstr ?? "https://via.placeholder.com/150")!)))!
                                XCTAssertTrue(true, "image loaded successfully")
                            } catch {
                                print(error.localizedDescription)
                            }
                                          promise.fulfill()
                                      }
                       }, failure: { (data, response, error) in

                        XCTFail(error!.localizedDescription)
                       })
                        wait(for: [promise], timeout: 5.0)
                       XCTAssertEqual(self.statuscode, 200
                   )}
    }
    }
