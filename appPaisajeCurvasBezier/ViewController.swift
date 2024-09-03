//
//  ViewController.swift
//  appPaisajeCurvasBezier
//
//  Created by braulio on 07/06/24.
//  Copyright © 2024 braulio. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    
    @IBOutlet weak var skyView: SkyView!
    
    
    @IBOutlet weak var containerScrollView: ContainerScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let viewWidth = view.frame.size.width
        let scrollView = UIScrollView(frame: CGRect(x: viewWidth/4, y: 0, width: viewWidth/2, height: 300))
        scrollView.contentSize = CGSize(width: viewWidth * 2.5, height: 200)
        scrollView.isPagingEnabled = true
        scrollView.clipsToBounds = false
        scrollView.delegate = self;

        _ = scrollView.frame.size.width

       

        containerScrollView.setScrollView(scrollView)
      }

      func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNum = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
        if let rageLevel = RageLevel(rawValue: pageNum) {
          skyView.setRageLevel(rageLevel)
        }
      }



    }

