//
//  SearchVC+URLSessionDelegates.swift
//  HalfTunes
//
//  Created by Kevin Largo on 12/16/17.
//  Copyright © 2017 Ray Wenderlich. All rights reserved.
//

import Foundation

extension SearchViewController: URLSessionDownloadDelegate {
  func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
    print("Finished downloading to \(location)");
  }
}
