//
//  CarouselPageViewController.swift
//  Skuad
//
//  Created by Ravikumar, Gowtham on 10/22/20.
//  Copyright © 2020 Ravikumar, Gowtham. All rights reserved.
//

import Foundation
import UIKit

class CarouselPageViewController: UIPageViewController {
    fileprivate var items: [UIViewController] = []
    var hits: [Hits]!
    var index: Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        self.view.backgroundColor = .white
        populateItems()
    }
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func populateItems() {
        
        for i in 0...hits.count-1 {
            let controller = createCarouselItemControler(photo: hits[i])
            items.append(controller)
        }
        setViewControllers([items[index]], direction: .forward, animated: true, completion: nil)
    }
    
    fileprivate func createCarouselItemControler(photo: Hits) -> UIViewController {
        let controller = UIViewController()
        controller.view = CarouselItem(photo: photo)
        return controller
    }
}

// MARK: - DataSource

extension CarouselPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = items.firstIndex(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return items.last
        }
        
        guard items.count > previousIndex else {
            return nil
        }
        
        return items[previousIndex]
    }
    
    func pageViewController(_: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = items.firstIndex(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        guard items.count != nextIndex else {
            return items.first
        }
        
        guard items.count > nextIndex else {
            return nil
        }
        
        return items[nextIndex]
    }
    
    func presentationCount(for _: UIPageViewController) -> Int {
        return items.count
    }
    
    func presentationIndex(for _: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first,
            let firstViewControllerIndex = items.firstIndex(of: firstViewController) else {
                return 0
        }
        
        return firstViewControllerIndex
    }
}

