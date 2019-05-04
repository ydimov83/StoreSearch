//
//  UIImageView+DownloadImage.swift
//  StoreSearch
//
//  Created by Yavor Dimov on 5/4/19.
//  Copyright © 2019 Yavor Dimov. All rights reserved.
//

import UIKit

extension UIImageView {
    func loadImage(url: URL) -> URLSessionDownloadTask {
        let session = URLSession.shared
        let downloadTask = session.downloadTask(with: url, completionHandler:
        { [weak self] url, response, error in
            if error == nil,
                let url = url,
                let data = try? Data(contentsOf: url),
                let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    if let weakSelf = self { //self here refers to the UIImageView, it's possible that by the time we download hte image the ImageView is no longer loaded (e.g. user navigated away), this check makes sure we still have the ImageView object around before setting it's image property
                        weakSelf.image = image
                    }
                }
            }
        })
        downloadTask.resume()
        return downloadTask
    }
}
