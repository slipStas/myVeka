//
//  FriendsPhotosViewController.swift
//  VeKa
//
//  Created by Stanislav Slipchenko on 05.10.2019.
//  Copyright © 2019 Stanislav Slipchenko. All rights reserved.
//

import UIKit

class FriendsPhotosViewController: UIViewController {
    
    let countImagesInLine: CGFloat = 3
    var minimumLineSpacing: CGFloat = 1
    let viewNew = UIImageView()
    let blackBackgroundView = UIView()
    var imageView: UIImageView?
    let nawBar = UIView()
    let tabBar = UIView()
    let zoomScroll = UIScrollView()
    
    var flag = true
    let image = UIImageView()
    let backView = UIView()
    
    var photoArray: [UIImage] = []
    
    @IBOutlet weak var friendsPhotosCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        friendsPhotosCollectionView.dataSource = self
        
        let backgroundColor = #colorLiteral(red: 0.5787474513, green: 0.3215198815, blue: 0, alpha: 0.5)
        let width = (view.bounds.width - (minimumLineSpacing * countImagesInLine)) / countImagesInLine
        let layout = friendsPhotosCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width)
        layout.minimumLineSpacing = minimumLineSpacing
        layout.minimumInteritemSpacing = minimumLineSpacing
        friendsPhotosCollectionView.backgroundColor = backgroundColor
    }
    
    func animateImageView(imageView: UIImageView) {
        
        self.imageView = imageView
        if let startingFrame = imageView.superview?.convert(imageView.frame, to: nil) {
            
            blackBackgroundView.frame = self.view.frame
            blackBackgroundView.backgroundColor = .black
            blackBackgroundView.alpha = 0
            
            view.addSubview(blackBackgroundView)
            
            nawBar.frame = CGRect(x: 0, y: 0, width: 1000, height: 88)
            nawBar.backgroundColor = .black
            nawBar.alpha = 0
            
            if let keyWindow = UIApplication.shared.windows.last {
                tabBar.frame = CGRect(x: 0, y: keyWindow.frame.height - 83, width: 1000, height: 83)
                tabBar.backgroundColor = .black
                tabBar.alpha = 0
                
                keyWindow.addSubview(nawBar)
                keyWindow.addSubview(tabBar)
            }
            
            imageView.alpha = 0
            
            viewNew.isUserInteractionEnabled = true
            viewNew.image = imageView.image
            viewNew.frame = startingFrame
            viewNew.contentMode = .scaleAspectFit
            viewNew.clipsToBounds = true
            view.addSubview(viewNew)
            
            let swipeGR = UISwipeGestureRecognizer(target: self, action: #selector(zoomOutSwipe))
            swipeGR.direction = .down
            
            viewNew.addGestureRecognizer(swipeGR)
            
            let doubleTapGR = UITapGestureRecognizer(target: self, action: #selector(zoomScrollView))
            doubleTapGR.numberOfTapsRequired = 2
            
            viewNew.addGestureRecognizer(doubleTapGR)
            
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                
                let height = (self.view.frame.width / startingFrame.width) * startingFrame.height
                let y = self.view.frame.height / 2 - height / 2
                self.viewNew.frame = CGRect(x: 0, y: y, width: self.view.frame.width, height: height)
                self.blackBackgroundView.alpha = 1
                self.nawBar.alpha = 1
                self.tabBar.alpha = 1
            })
            
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                
                let height = (self.view.frame.width / startingFrame.width) * startingFrame.height
                let y = self.view.frame.height / 2 - height / 2
                self.viewNew.frame = CGRect(x: 0, y: y, width: self.view.frame.width, height: height)
                self.blackBackgroundView.alpha = 1
                self.nawBar.alpha = 1
                self.tabBar.alpha = 1
            })
        }
    }
    
    @objc func zoomOutSwipe() {
        UIView.animate(withDuration: 0.175) {
                    self.viewNew.transform = CGAffineTransform(translationX: 0, y: 150)
        }

        if let startingFrame = imageView!.superview?.convert(imageView!.frame, to: nil) {
            UIView.animate(withDuration: 0.5, animations: {
                self.viewNew.frame = startingFrame
                self.blackBackgroundView.alpha = 0
                self.nawBar.alpha = 0
                self.tabBar.alpha = 0
            }) { (didComplete) in
                self.viewNew.removeFromSuperview()
                self.blackBackgroundView.removeFromSuperview()
                self.nawBar.removeFromSuperview()
                self.tabBar.removeFromSuperview()
                self.viewNew.transform = CGAffineTransform(translationX: 0, y: -100)

                self.imageView?.alpha = 1
            }
        }
    }
    
    @objc func zoomScrollView() {
        
        let width = viewNew.frame.width
        let height = viewNew.frame.height
        
        let contentInsets = UIEdgeInsets(top: width / 2, left: height / 2, bottom: width / 2, right: height / 2)

        zoomScroll.contentInset = contentInsets
        zoomScroll.contentSize = CGSize(width: width, height: height)
        zoomScroll.frame = view.frame
        
        image.frame = CGRect(x:0, y: 0, width: width, height: height)
        image.image = viewNew.image
        image.isUserInteractionEnabled = true
        
        backView.frame = image.frame
        backView.backgroundColor = .black
        
        zoomScroll.addSubview(backView)
        zoomScroll.addSubview(image)
        view.addSubview(zoomScroll)
        
        switch flag {
        case true:
            UIView.animate(withDuration: 0.3) {
                
                self.image.frame = CGRect(x: -width / 2, y: -height / 2, width: width * 2, height: height * 2)
                self.viewNew.alpha = 0
                self.flag = false
            }
        case false:
            return
        }
        
        let doubleTapGR = UITapGestureRecognizer(target: self, action: #selector(zoomOutScrollView))
        doubleTapGR.numberOfTapsRequired = 2
        
        zoomScroll.addGestureRecognizer(doubleTapGR)
        
    }
    @objc func zoomOutScrollView() {
        
        let width = viewNew.frame.width
        let height = viewNew.frame.height
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            self.image.frame = CGRect(x:0, y: 0, width: width, height: height)
            self.image.center = self.view.center
            self.zoomScroll.contentInset = .zero
            self.flag = true
               }) { isEnded in
                self.viewNew.alpha = 1
                self.zoomScroll.removeFromSuperview()
               }
    }
    
}

extension FriendsPhotosViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = friendsPhotosCollectionView.dequeueReusableCell(withReuseIdentifier: "friendsPhotosIdentifier", for: indexPath) as! FriendsPhotosCollectionViewCell
        
        cell.friendsPhotos.image = photoArray[indexPath.row]
        cell.friendsPhotoViewController = self
        
        return cell
    }
}

