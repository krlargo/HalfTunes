//
//  Download.swift
//  HalfTunes
//
//  Created by Kevin Largo on 12/16/17.
//  Copyright © 2017 Ray Wenderlich. All rights reserved.
//

import Foundation

// Used to represent an active download
class Download {
  
  var track: Track
  init(track: Track) {
    self.track = track
  }
  
  // Download service sets these values:
  var task: URLSessionDownloadTask?
  var isDownloading = false
  var resumeData: Data?
  
  // Download delegate sets this value:
  var progress: Float = 0
  
}
