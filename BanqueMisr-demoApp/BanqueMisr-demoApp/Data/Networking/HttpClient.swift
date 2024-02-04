//
//  HttpClient.swift
//  BanqueMisr-demoApp
//
//  Created by Vladimir Stasenko on 04.02.2024.
//

import Foundation

class HTTPClient {
    
//    typealias Result = (Decodable?, ErrorAPIModel?)
//    typealias ResponseResult = Result<Decodable, ErrorAPIModel>
    
    func get<Response: Decodable>(with url: URL,
                                  type: Response.Type,
                                  handler: @escaping (Response) -> ()) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
//                decoder.dateDecodingStrategy = .formatted(.yyyyMMdd)
                
                if let result = try? decoder.decode(type, from: data) {
                    handler(result)
                } else if let result = try? decoder.decode(ErrorAPIModel.self, from: data) {
                    print("Error = \(result)")
                } else {
                    print("Invalid Response")
                }
            } else if let error = error {
                print("HTTP Request Failed \(error)")
            }
        }
        
        task.resume()
    }
}
