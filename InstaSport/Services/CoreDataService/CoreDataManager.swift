//
//  CoreDataManager.swift
//  InstaSport
//
//  Created by Youssif Hany on 14/08/2024.
//

import CoreData
import UIKit

class CoreDataManager {
    static let shared = CoreDataManager()
    
    private init() {}
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func saveLeague(_ league: LeagueModel,sport:Sports) {
        let leagueEntity = LeagueCD(context: context)
        leagueEntity.sport=sport.rawValue
        leagueEntity.leagueKey = Int32(league.leagueKey)
        leagueEntity.leagueName = league.leagueName
        leagueEntity.leagueLogo = league.leagueLogo
        leagueEntity.leagueUrl = Converter.convertingImgToStr(img: league.leagueLogo ?? "imgFB")
        
        do {
            try context.save()
            print("League saved successfully.")
        } catch {
            print("Failed to save league: \(error.localizedDescription)")
        }
    }
    
    func fetchSavedLeagues() -> [LeagueCD] {
        let fetchRequest: NSFetchRequest<LeagueCD> = LeagueCD.fetchRequest()
        
        do {
            let leagues = try context.fetch(fetchRequest)
            return leagues
        } catch {
            print("Failed to fetch leagues: \(error.localizedDescription)")
            return []
        }
    }
    func removeLeague(leagueKey: Int) {
        let fetchRequest: NSFetchRequest<LeagueCD> = LeagueCD.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "leagueKey == %d", leagueKey)
        fetchRequest.fetchLimit = 1

        do {
            let leagues = try context.fetch(fetchRequest)
            if let leagueToRemove = leagues.first {
                context.delete(leagueToRemove)
                try context.save()
                print("League removed successfully.")
            } else {
                print("League not found.")
            }
        } catch {
            print("Failed to remove league: \(error.localizedDescription)")
        }
    }
    func isFavorite(league:LeagueModel,arrayOfLeagues:[LeagueCD])->Bool{
        var result = false
        for leagueInArray in arrayOfLeagues {
            if (league.leagueName == leagueInArray.leagueName){
                result = true
            }else{
                result = false
            }
        }
        return result
    }
}
