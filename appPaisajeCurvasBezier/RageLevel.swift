//
//  RageLevel.swift
//  appPaisajeCurvasBezier
//
//  Created by braulio on 07/06/24.
//  Copyright © 2024 braulio. All rights reserved.
//

import UIKit

enum RageLevel: Int, CaseIterable {
  case lobo, caperucita

  var image: String {
    switch self {
    case .lobo: return ""
    case .caperucita: return ""
    }
  }

  var tweet: String {
    switch self {
    case .lobo: return "RRRRRRGHHHHHHHH"
    case .caperucita: return "Ahhhhh el lobo feroz"
    }
  }
}
