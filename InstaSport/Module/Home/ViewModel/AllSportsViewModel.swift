//
//  AllSportsViewModel.swift
//  InstaSport
//
//  Created by Youssif Hany on 13/08/2024.
//

import Foundation
import UIKit

class AllSportsViewModel{
    
    var arryOfSports:[Sport] = []
    
    init(){
        arryOfSports.append(Sport(image: UIImage(named: "Football")!, title: "Football",sportEnum: .football))
        arryOfSports.append(Sport(image: UIImage(named: "Basketball")!, title: "Basketball",sportEnum: .basketball))
        arryOfSports.append(Sport(image: UIImage(named: "Tennis")!, title: "Tennis",sportEnum: .tennis))
        arryOfSports.append(Sport(image: UIImage(named: "Cricket")!, title: "Cricket",sportEnum: .cricket))
//        arryOfSports.append(Sport(image: UIImage(named: "Hockey")!, title: "Hockey"))
//        arryOfSports.append(Sport(image: UIImage(named: "Baseball")!, title: "Baseball"))
//        arryOfSports.append(Sport(image: UIImage(named: "AmericanFootball")!, title: "American Football"))
    }
}
