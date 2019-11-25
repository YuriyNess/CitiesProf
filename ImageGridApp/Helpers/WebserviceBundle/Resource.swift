//
//  Resource.swift
//  Statistic
//
//  Created by YuriyFpc on 7/28/19.
//  Copyright © 2019 YuriyFpc. All rights reserved.
//

import Foundation
import UIKit

struct Resource<A> {
    let url: URL
    let parse: (Data) -> A?
    let params: [String: Any]?
    let headers: [String: String]?
    
    init(url: URL, params: [String: Any]?, headers: [String: String]?, parse: @escaping (Data) -> A?) {
        self.url = url
        self.parse = parse
        self.params = params
        self.headers = headers
    }
    
    init(url: URL, params: [String: Any]?, headers: [String: String]?, parseJSON: @escaping (Any) -> A?) {
        self.url = url
        self.params = params
        self.headers = headers
        self.parse = { data in
            let json = try? JSONSerialization.jsonObject(with: data as Data, options: [])
            return json.flatMap(parseJSON)
        }
    }
}
