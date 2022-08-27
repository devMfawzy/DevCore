//
//  Networking.swift
//  DevCore
//
//  Created by Mohamed Fawzy on 27/08/2022.
//

import Foundation

extension DevCore {
    public class Networking {
        
        /// Responsible for handling all network calls
        /// - Warning: must create before using any public API
        public class Manager {
            public init() {}
            
            private let session = URLSession.shared
            
            public func loadData(from url: URL, completion: @escaping (NetworkResult<Data>) -> Void) {
                let task = session.dataTask(with: url) { data, _, error in
                    let result = data.map(NetworkResult<Data>.success) ?? .failure(error)
                    completion(result)
                }
                task.resume()
            }
        }
        
        public enum NetworkResult<Value> {
            case success(Value)
            case failure(Error?)
        }
    }
}
