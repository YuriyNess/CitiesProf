//
//  ImageLoadingRequestsProtocol.swift
//  UnsplashViewer
//
//  Created by YuriyFpc on 9/14/19.
//  Copyright © 2019 YuriyFpc. All rights reserved.
//

import Foundation

protocol ImageLoadingRequests {
    func performLoadImage(url: String, resFactory: ImageRresourceFactory, complition: @escaping (Data?)-> Void, errorComplition: @escaping (Error?) -> Void)
}
