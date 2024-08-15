//
//  FavoriteViewModel.swift
//  InstaSport
//
//  Created by Youssif Hany on 14/08/2024.
//

import Foundation
import CoreData
class FavoriteViewModel{
    
    var favoriteLeague:FavoriteLeagueModel?
    
    func addToFavorites(_ favoriteLeague: FavoriteLeagueModel) {
        var newFavoriteLeague: FavoriteLeagueModel?
        let favoriteItem = FavoriteLeagueModel(context: CoreDataManager.shared.context)
        favoriteItem.leagueTitle = newFavoriteLeague?.leagueTitle
        favoriteItem.leagueImage = newFavoriteLeague?.leagueImage
        favoriteItem.leagueYoutubeUrl = newFavoriteLeague?.leagueYoutubeUrl

            CoreDataManager.shared.saveContext()
        }

        func removeFromFavorites(_ favoriteLeague: FavoriteLeagueModel) {
            let fetchRequest = NSFetchRequest<FavoriteLeagueModel>(entityName: "FavoriteLeagueModel")
            fetchRequest.predicate = NSPredicate(format: "url == %@", favoriteLeague.leagueYoutubeUrl!)

            do {
                let items = try CoreDataManager.shared.context.fetch(fetchRequest)
                for item in items {
                    CoreDataManager.shared.context.delete(item)
                }
                CoreDataManager.shared.saveContext()
            } catch {
                print("Failed to fetch or delete item: \(error)")
            }
        }

        func isFavorite() -> Bool {
            guard let newsItem = favoriteLeague else { return false }

            let fetchRequest = NSFetchRequest<FavoriteLeagueModel>(entityName: "FavoriteLeagueModel")
            fetchRequest.predicate = NSPredicate(format: "url == %@", newsItem.leagueYoutubeUrl!)

            do {
                let count = try CoreDataManager.shared.context.count(for: fetchRequest)
                return count > 0
            } catch {
                print("Failed to check if item is favorite: \(error)")
                return false
            }
        }
    func fetchFavoriteItems() -> [FavoriteLeagueModel] {
        let fetchRequest = NSFetchRequest<FavoriteLeagueModel>(entityName: "FavoriteLeagueModel")

        do {
            let favoriteItems = try CoreDataManager.shared.context.fetch(fetchRequest)
            return favoriteItems
        } catch {
            print("Failed to fetch favorite items: \(error)")
            return []
        }
    }
    
}
