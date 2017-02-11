//
//  ManagePageViewController.swift
//  PhotoScroll
//
//  Created by HaYoung on 2017. 2. 8..
//  Copyright © 2017년 raywenderlich. All rights reserved.
//

import UIKit

class ManagePageViewController: UIPageViewController {
  
  var photos:[String] = []
  var currentIndex: Int = 0
  
 
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    dataSource = self
    
    if let viewController = viewPhotoCommentController(index: currentIndex) {
      let viewControllers = [viewController]
      
      setViewControllers(
        viewControllers,
        direction: .forward,
        animated: false,
        completion: nil
      )
    }
  }
  
  func viewPhotoCommentController(index: Int) -> PhotoCommentViewController? {
    if let storyboard = storyboard,
      let page = storyboard.instantiateViewController(withIdentifier: "PhotoCommentViewController")
        as? PhotoCommentViewController {
      page.photoName = photos[index]
      page.photoIndex = index
      return page
    }
    
    return nil
  }
}

extension ManagePageViewController: UIPageViewControllerDataSource {
  // 1
  func pageViewController(_ pageViewController: UIPageViewController,
                          viewControllerBefore viewController: UIViewController) -> UIViewController? {
    
    if let viewController = viewController as? PhotoCommentViewController {
      guard let index = viewController.photoIndex, index - 1 >= 0 else {
        return nil
      }
      return viewPhotoCommentController(index: index - 1)
    }
    return nil
  }
  
  
  // 2
  func pageViewController(_ pageViewController: UIPageViewController,
                          viewControllerAfter viewController: UIViewController) -> UIViewController? {
    
    if let viewController = viewController as? PhotoCommentViewController {
      guard let index = viewController.photoIndex, index + 1 < photos.count else {
        return nil
      }
      
      return viewPhotoCommentController(index: index + 1)
    }
    return nil
  }
}
