//
//  ApiHandler.swift
//  iOSProficiencyExercise
//
//  Created by Senapathi Rajesh on 26/12/19.
//  Copyright © 2019 Senapathi Rajesh. All rights reserved.
//
enum HttpMethod: String {
    case  GET
    case  POST
    case  DELETE
    case  PUT
}

import Foundation
import UIKit
class ApiHandler: NSObject {
    var jsonRows: [Rows]?
    var request: URLRequest?
    var session: URLSession?
    static func instance() -> ApiHandler {
        return ApiHandler()
       }
func makeAPICall(url: String, method: HttpMethod, success:@escaping ( Data?, HTTPURLResponse?, NSError?) -> Void, failure: @escaping ( Data?, HTTPURLResponse?, NSError?) -> Void) {
           request = URLRequest(url: URL(string: url)!)
           request?.httpMethod = method.rawValue
           let configuration = URLSessionConfiguration.default
           session = URLSession(configuration: configuration)
           session?.dataTask(with: request! as URLRequest) { (data, response, error) -> Void in
               if let data = data {
                   if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                       success(data, response, error as NSError?) } else {
                       failure(data, response as? HTTPURLResponse, error as NSError?)
                   }
               } else { failure(data, response as? HTTPURLResponse, error as NSError?)
               }
               }.resume()
       }
}

