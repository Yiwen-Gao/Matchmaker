//
//  MatchmakerThemeChooserViewController.swift
//  Concentration
//
//  Created by Yiwen Gao on 4/1/18.
//  Copyright © 2018 Yiwen Gao. All rights reserved.
//

import UIKit

class MatchmakerThemeChooserViewController: UIViewController {
    
    let themes = [
        "HEARTS": "❣️💕💞💓💗💖💘💝",
        "GIRLS": "👩‍🏫👩‍⚕️👩🏻‍🏭🕵🏻‍♀️👩🏼‍💻👩🏾‍✈️👩🏾‍🎓👩🏿‍🔧",
        "GUYS": "👨‍🏫👨‍⚕️👨🏻‍🏭🕵🏻‍♂️👨🏼‍💻👨🏽‍✈️👨🏾‍🎓👨🏿‍🔧"
    ]

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose Theme" {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                if let matchmaker = segue.destination as? MatchmakerController {
                    matchmaker.theme = theme
                }
            }
        }
    }
}

