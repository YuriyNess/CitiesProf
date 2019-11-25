//
//  CitiesModel.swift
//  ImageGridApp
//
//  Created by YuriyFpc on 11/25/19.
//  Copyright © 2019 YuriyFpc. All rights reserved.
//

import Foundation

protocol CitiesModelDelegate: AnyObject {
    func updateOnDataLoad()
}

final class CitiesModel {
    var items = [City]()
    var operationsOperator: ImageLoadOperations?
    weak var delegate: CitiesModelDelegate?
    
    func load() {
        items.removeAll()
        DispatchQueue(label: "jsonLoading", qos: .background).async { [weak self] in
            if let path = Bundle.main.path(forResource: "imageData", ofType: "json") {
                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                    let decoder = JSONDecoder()
                    self?.items = try decoder.decode([City].self, from: data)
                    DispatchQueue.main.async {
                        self?.delegate?.updateOnDataLoad()
                    }
                } catch {
                    print(error)
                }
            }
        }
    }
    
    func loadImage(indexPath: IndexPath, complition: ((Data?)->Void)? = nil ) {
        let url = items[indexPath.row].url
        operationsOperator?.startImageLoadOperation(url: url, indexPath: indexPath, complition: complition)
    }
    
    func cancelImageLoading(indexPath: IndexPath) {
        operationsOperator?.purgeOperation(indexPath: indexPath)
    }
}
