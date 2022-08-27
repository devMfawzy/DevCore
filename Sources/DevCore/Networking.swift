//
//  Networking.swift
//  DevCore
//
//  Created by Mohamed Fawzy on 27/08/2022.
//

import Foundation

protocol NetworkSession {
    func get(from url: URL, completion: @escaping ((Data?, Error?) -> Void))
}

extension URLSession: NetworkSession {
    func get(from url: URL, completion: @escaping ((Data?, Error?) -> Void)) {
        let task = dataTask(with: url) { data, _, error in
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
        }
        
        public enum NetworkResult<Value> {
            case success(Value)
            case failure(Error?)
        }
    }
}
