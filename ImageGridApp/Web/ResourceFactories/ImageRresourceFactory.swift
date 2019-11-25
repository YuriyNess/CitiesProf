//
//  ImageRresourceFactory.swift
//  UnsplashViewer
//
//  Created by YuriyFpc on 9/14/19.
//  Copyright © 2019 YuriyFpc. All rights reserved.
//

import Foundation

final class ImageRresourceFactory {
    func resource(url: String) -> Resource<Data>? {
        guard let url = URL(string: url) else { return nil }
        return try! ResourceBuilder<Data>().with(url: url)
            .with(parse: { (data) -> Data? in
                return data as? Data
            }).build(.Data)
    }
}
