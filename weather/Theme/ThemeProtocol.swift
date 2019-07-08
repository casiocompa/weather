//
//  ThemeProtocol.swift
//  weather
//
//  Created by Ruslan Kasian on 7/6/19.
//  Copyright © 2019 Ruslan Kasian. All rights reserved.
//

import UIKit

protocol ThemeProtocol {
    
    var tint: UIColor { get }
    var secondaryTint: UIColor { get }
    
    // button
    var buttonBackgroundColor: UIColor { get }
    var buttonShadowColor: UIColor { get }
    var lableButtonColor: UIColor { get }
  
    
    // form
    var formBackgroundColor: UIColor { get }
    
    
    //table
    var separatorColor: UIColor { get }
    var selectionColor: UIColor { get }
    
    //lable
    var labelColor: UIColor { get }
    var secondaryLabelColor: UIColor { get }
    var subtleLabelColor: UIColor { get }
    
    var barStyle: UIBarStyle { get }
    
    
}
