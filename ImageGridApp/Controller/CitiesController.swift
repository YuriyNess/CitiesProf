//
//  ViewController.swift
//  ImageGridApp
//
//  Created by YuriyFpc on 11/25/19.
//  Copyright © 2019 YuriyFpc. All rights reserved.
//

import UIKit

final class CitiesController: UIViewController, Storyboarded {
    
    struct Constants {
        static let cellId = "ItemCell"
        static let placeholderImageName = "picture"
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var selectedImageView: UIImageView!
    @IBOutlet weak var imageTitle: UILabel!
    @IBOutlet weak var imageDescr: UILabel!
    @IBOutlet var landscapeConstraints: [NSLayoutConstraint]!
    @IBOutlet var portraitConstraits: [NSLayoutConstraint]!
    
    var model: CitiesModel!
    var selectedImageUrl: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectedImageView.isUserInteractionEnabled = true
        selectedImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectedImageTap)))
    }
    
    @objc
    private func handleSelectedImageTap() {
        guard let url = selectedImageUrl else { return }
        let vc = WebViewController()
        vc.image = selectedImageView.image
        vc.imageTitle = imageTitle.text ?? ""
        vc.url = url
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        model.load()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if self.view.frame.width < self.view.frame.height {
            NSLayoutConstraint.deactivate(self.landscapeConstraints)
            NSLayoutConstraint.activate(self.portraitConstraits)
        } else {
            NSLayoutConstraint.deactivate(self.portraitConstraits)
            NSLayoutConstraint.activate(self.landscapeConstraints)
        }
    }
}

extension CitiesController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellId, for: indexPath) as! ItemCell
        model.loadImage(indexPath: indexPath) { (data) in
            if let data = data, let image = UIImage(data: data) {
                cell.cityImageView.image = image
            } else {
                cell.cityImageView.image = UIImage(named: Constants.placeholderImageName)
            }
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            model.cancelImageLoading(indexPath: indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? ItemCell else { return }
        selectedImageView.image = cell.cityImageView.image
        let item = model.items[indexPath.row]
        imageTitle.text = item.imageName
        imageDescr.text = "Lat: \(item.lat)   Long:\(item.long)"
        selectedImageUrl = item.url
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return  CGSize(width: collectionView.frame.width / 3, height: (collectionView.frame.height / 2) - 20)
    }
}


extension CitiesController: CitiesModelDelegate {
    func updateOnDataLoad() {
        collectionView.reloadData()
    }
}

