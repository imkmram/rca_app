//
//  NetworkClient.swift
//  MVVM_Delegate_Pattern_Ex
//
//  Created by Ashok Gupta on 07/12/18.
//  Copyright © 2018 Ashok Gupta. All rights reserved.
//

import Foundation

protocol Printable {
    var description:String {get}
}

enum APIError:Printable {
    case NoNetwork
    case HTTPError(err:Error)
    case ServerError
    
    var description: String {
        switch  self {
        case .NoNetwork:
            return "No Network"
        case .HTTPError(let error):
            return "Response Error: \(error.localizedDescription)"
        default:
            return ""
        }
    }
}

enum CustomError:Error {
    
    case BadRequest
    case NoNetwork //1009
    case ParsingError
    case TimeOut // 2102
    
    var errorDescription:String {
        
        switch self {
        case .NoNetwork:
            return "No Network"
        default:
            return "Un-Identified Error"
        }
    }
}

enum ResponseResult<T> {
    case success(T)
    case failure(Error)
   // case Customfailure(CustomError)
}

class NetworkClient {
    
    // Method using URLSession
    static func get<K:Codable>(url:URL, method:String, parameter:String?, completion:@escaping (ResponseResult<K>)->Void) {
        var request:URLRequest = URLRequest(url: url)
        request.httpMethod = method
        
        if let param = parameter {
            request.httpBody = param.data(using: .utf8)
        }
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            if let error = responseError {
                completion(.failure(error))
                // completion(.Customfailure(CustomError.BadRequest))
            }
            else if let jsonData = responseData {
                do {
                    let decoder = JSONDecoder()
                    let object = try decoder.decode(K.self, from: jsonData)
                    print(String(data: jsonData, encoding: .utf8))
                    let result: ResponseResult<K> = ResponseResult.success(object)
                    completion(result)
                }
                catch {
                    completion(.failure(error))
                    // completion(.Customfailure(CustomError.ParsingError))
                }
            }
        }
        task.resume()
    }
}
