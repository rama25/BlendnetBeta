//
//  BlendnetView.swift
//  BlendnetHub
//
//  Created by Faisal M. Lalani on 2/1/19.
//  Copyright © 2019 MSR India. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import Photos

open class BlendnetView: UIView {
    
    var controller = UIViewController()
    
    lazy var videosTableView: UITableView = {
        
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        
        return tableView
    }()
    
    
    var videos = ["Xbox", "Surface Pro", "Hololens", "Bahubali", "Tab"]
    var videoCellIdentifier = "videoCell"
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(videosTableView)
        videosTableView.register(UITableViewCell.self, forCellReuseIdentifier: videoCellIdentifier)
        videosTableView.sectionHeaderHeight = 70
        videosTableView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, centerX: nil, centerY: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, paddingCenterX: 0, paddingCenterY: 0, width: 0, height: 0)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func createURL(i: String) -> String {
        
        let url = "http://192.168.137.1:5000/\(i)"
        
        return url
    }
    
    public func playVideo(i: String) {
        
        let videoURL = URL(string: createURL(i: i))
        let player = AVPlayer(url: videoURL!)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        controller.present(playerViewController, animated: true) {
            playerViewController.player!.play()
        }
    }
    
}

extension BlendnetView: UITableViewDelegate, UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return "Blendnet Hub"
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 70.0
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 70.0
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return videos.count
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: videoCellIdentifier, for: indexPath)
        
        let video = videos[indexPath.row]
        cell.textLabel?.text = video
        cell.textLabel?.textAlignment = .center
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Grab the relevant page.
        let video = videos[indexPath.row]
        
        switch(video) {
            
        case("Xbox"):
            playVideo(i: "184")
        case("Surface Pro"):
            playVideo(i: "183")
        case("Hololens"):
            playVideo(i: "182")
        case("Bahubali"):
            playVideo(i: "189")
        case("Tab"):
            playVideo(i: "195")
        default:
            print("Default")
        }
    }
    
    public func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let downloadTitle = NSLocalizedString("Download", comment: "Download Action")
        let downloadAction = UITableViewRowAction(style: .normal,
                                                  title: downloadTitle) { (action, indexPath) in
                                                    
                                                    let video = self.videos[indexPath.row]
                                                    var urlString = ""
                                                    
                                                    switch(video) {
                                                        
                                                    case("Xbox"):
                                                        urlString = self.createURL(i: "184")
                                                    case("Surface Pro"):
                                                        urlString = self.createURL(i: "183")
                                                    case("Hololens"):
                                                        urlString = self.createURL(i: "182")
                                                    case("Bahubali"):
                                                        urlString = self.createURL(i: "189")
                                                    case("Tab"):
                                                        urlString = self.createURL(i: "195")
                                                    default:
                                                        print("Default")
                                                    }
                                                    
                                                    DispatchQueue.global(qos: .background).async {
                                                        if let url = URL(string: urlString),
                                                            let urlData = NSData(contentsOf: url) {
                                                            let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0];
                                                            let filePath="\(documentsPath)/tempFile.mp4"
                                                            DispatchQueue.main.async {
                                                                urlData.write(toFile: filePath, atomically: true)
                                                                PHPhotoLibrary.shared().performChanges({
                                                                    PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: URL(fileURLWithPath: filePath))
                                                                }) { completed, error in
                                                                    if completed {
                                                                        print("Video is saved!")
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    }
        }
        downloadAction.backgroundColor = .cyan
        return [downloadAction]
    }
}

