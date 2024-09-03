//
//  ContainerScrollView.swift
//  appPaisajeCurvasBezier
//
//  Created by braulio on 07/06/24.
//  Copyright © 2024 braulio. All rights reserved.
//

import UIKit

class ContainerScrollView: UIScrollView {
    var scrollView: UIScrollView?

    func setScrollView(_ scrollView: UIScrollView) {
      self.scrollView = scrollView
      addSubview(scrollView)
    }
}
