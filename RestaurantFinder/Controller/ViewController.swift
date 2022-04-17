//
//  ViewController.swift
//  RestaurantFinder
//
//  Created by Nischhal on 17.4.2022.
//

import Foundation
import UIKit

class ViewController : UIViewController{
    let parser = Parser()
    override func viewDidLoad() {
        parser.parse()
    }
}
