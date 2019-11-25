//
//  WebSer.swift
//  Statistic
//
//  Created by YuriyFpc on 7/27/19.
//  Copyright © 2019 YuriyFpc. All rights reserved.
//

import Foundation
import UIKit

final class ResourceBuilder<A> {
    
    enum ResponseType {
        case Data, JSON
    }
    
    private var url: URL?
    private var params: ([String: Any])?
    private var headers: ([String: String])?
    private var parse: ((Any) -> A?)?
    
    func with(url: URL) -> ResourceBuilder {
        self.url = url
        return self
    }
    
    func with(params: [String: Any]) -> ResourceBuilder {
        self.params = params
        return self
    }
    
    func with(headers: [String: String]) -> ResourceBuilder {
        self.headers = headers
        return self
    }
    
    func with(parse: @escaping (Any) -> A?) -> ResourceBuilder {
        self.parse = parse
        return self
    }
    
    func build(_ response: ResponseType) throws -> Resource<A> {
        switch response {
        case .Data:
            return try createDataResource()
        case .JSON:
            return try createJSONResource()
        }
    }
    
    private func createDataResource() throws -> Resource<A> {
        guard let url = self.url, let parse = self.parse else { fatalError("Not available ResourceBuilder params") }
        return  Resource<A>(url: url, params: params, headers: headers, parse: parse)
    }
    
    private func createJSONResource() throws -> Resource<A> {
        guard let url = self.url, let parse = self.parse else { fatalError("Not available ResourceBuilder params") }
        return  Resource<A>(url: url, params: params, headers: headers, parseJSON: parse)
    }
    
}
