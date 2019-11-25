//
//  OperationsFactory.swift
//  FilmsOverviewApp
//
//  Created by YuriyFpc on 9/7/19.
//  Copyright © 2019 YuriyFpc. All rights reserved.
//

import Foundation

final class OperationsFactory {
    func createImageLoadOperation(url: String, service: ImageLoadingRequests, resourceFactory: ImageRresourceFactory) -> ImageDownloader {
        let operation = ImageDownloader(service: service, resourceFactory: resourceFactory, url: url)
        return operation
    }
}
