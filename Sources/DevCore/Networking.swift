//
//  Networking.swift
//  DevCore
//
//  Created by Mohamed Fawzy on 27/08/2022.
//

import Foundation

protocol NetworkSession {
    func get(from url: URL, completion: @escaping ((Data?, Error?) -> Void))
    func post(with request: URLRequest, completion: @escaping ((Data?, Error?) -> Void))
}

extension URLSession: NetworkSession {
    func get(from url: URL, completion: @escaping ((Data?, Error?) -> Void)) {
        let task = dataTask(with: url) { data, _, error in
            completion(data, error)
        }
        task.resume()
    }
    
    func post(with request: URLRequest, completion: @escaping ((Data?, Error?) -> Void)) {
        let task = dataTask(with: request) { data, _, error in
            completion(data, error)
        }
        task.resume()
    }
}
                                                  
extension DevCore {
    public class Networking {
        
        /// Responsible for handling all network calls
        /// - Warning: must create before using any public API
        public class Manager {
            public init() {}
        
            internal var session: NetworkSession = URLSession.shared
            
            /// Call the live internet to retrieve data from specific location
            /// - Parameters:
            ///   - url: the location to fetch fata from
            ///   - completion: the block of result called on completion either with data or error
            public func loadData(from url: URL, completion: @escaping (NetworkResult<Data>) -> Void) {
                session.get(from: url) { data, error in
                    let result = data.map(NetworkResult<Data>.success) ?? .failure(error)
                    completion(result)
                }
            }
            
            
            /// call the live internet to send data to a specific location
            /// - Parameters:
            ///   - url: the location to fetch fata from
            ///   - body: an object that confirms to emcodable protocol
            ///   - completion: e block of result called on completion either with data or error 
            public func sendData<I:Encodable>(to url: URL, body: I, completion: @escaping (NetworkResult<Data>) -> Void) {
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                request.httpBody = try? JSONEncoder().encode(body)
                session.post(with: request) { data, error in
                    let result = data.map(NetworkResult<Data>.success) ?? .failure(error)
                    completion(result)
                }
            }
        }
        
        public enum NetworkResult<Value> {
            case success(Value)
            case failure(Error?)
        }
    }
}
