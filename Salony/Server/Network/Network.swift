//
//  Network.swift
//  Salony
//
//  Created by Vahagn Gevorgyan on 12/14/17.
//  Copyright © 2017 Vahagn Gevorgyan. All rights reserved.
//

import Foundation

class Network {
    
    /// completion handler for requests
    typealias CompletionBlock = (_ success: Bool, _ result: Data?, _ response: URLResponse? ) -> Void
    let parameterBuilder = RequestParameterBuilder()
    
    /// HTTP methods
    enum HTTPMethod: String {
        case Post = "POST"
        case Get = "GET"
        case Put = "PUT"
        case Delete = "DELETE"
        
        fileprivate func getMethod() -> String {
            return self.rawValue
        }
    }
    
    /// Http request
    ///
    /// - Parameters:
    ///   - methodName: endpoint name, find in APIEndpoints
    ///   - path: add path to request
    ///   - method: HTTPMethod
    ///   - parameters: request parameters
    ///   - body: request body
    ///   - completion: executed after the request complete
    func request(_ methodName: String, path: String? = nil, method: HTTPMethod, parameters: [String: Any]? = nil, body: [String: Any]? = nil, completion: @escaping CompletionBlock) {
        
        let url = Constants.APIEntryPoint + methodName
        guard var urlComponents = URLComponents(string: url) else { return }
        
        if let path = path {
            urlComponents.path.append(contentsOf: "/\(path)")
        }
        
        /// Adding url components to request link
        urlComponents.queryItems = []
        if let parameters = parameters {
            for (key, value) in parameters {
                
                let item = URLQueryItem(name: key, value: String(describing: value))
                print("Parameter value is: ", String(describing: value))
                urlComponents.queryItems?.append(item as URLQueryItem)
                
            }
        }
        
        var request = URLRequest(url: urlComponents.url!)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        
        /// Adding body to request
        if let body = body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        }
        
        request.httpMethod = method.getMethod()
        
        /*
         URLSession is native class for making requests,
         this can be replaced with Alamofire or any other lib if needed.
         */
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            /*
             Continue only if error is nil
             and data is not nil
             */
            guard error == nil || data != nil else {
                print("error: \(#file, #function, #line)")
                DispatchQueue.main.async {
                    completion(false, nil, response)
                }
                return
            }
            if let data = data {
                /*
                 Fetching data in background thread,
                 completion is executed in main thread.
                 */
                DispatchQueue.main.async {
                    completion(true, data, response)
                }
            }
            }.resume()
    }
}
