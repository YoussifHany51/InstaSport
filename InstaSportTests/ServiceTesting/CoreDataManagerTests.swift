import XCTest
import CoreData
@testable import InstaSport

final class CoreDataManagerTests: XCTestCase {
    var coreDataManager: CoreDataManager!
    var mockPersistentContainer: NSPersistentContainer!

    override func setUp() {
        super.setUp()

        // Create an in-memory persistent container
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType

        let container = NSPersistentContainer(name: "InstaSport")
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Failed to load in-memory store: \(error)")
            }
        }
        mockPersistentContainer = container

        // Inject the in-memory context into the CoreDataManager
        coreDataManager = CoreDataManager(context: mockPersistentContainer.viewContext)
    }

    func testSaveLeague() {
        let league = LeagueModel(leagueKey: 305, leagueName: "Premier League", leagueLogo: "logo.png", leagueUrl: "")
        
        coreDataManager.saveLeague(league, sport: .football)
        
        let savedLeagues = coreDataManager.fetchSavedLeagues()
        XCTAssertEqual(savedLeagues.count, 1)
        XCTAssertEqual(savedLeagues.first?.leagueName, "Premier League")
    }
    
    func testFetchSavedLeagues() {
        let league = LeagueModel(leagueKey: 305, leagueName: "Premier League", leagueLogo: "logo.png", leagueUrl: "")
        coreDataManager.saveLeague(league, sport: .football)
        
        let leagues = coreDataManager.fetchSavedLeagues()
        XCTAssertEqual(leagues.count, 1)
        XCTAssertEqual(leagues.first?.leagueName, "Premier League")
    }
    
    func testRemoveLeague() {
        let league = LeagueModel(leagueKey: 305, leagueName: "Premier League", leagueLogo: "logo.png", leagueUrl: "")
        coreDataManager.saveLeague(league, sport: .football)
        
        coreDataManager.removeLeague(leagueKey: 305)
        
        let leagues = coreDataManager.fetchSavedLeagues()
        XCTAssertEqual(leagues.count, 0)
    }
    
    func testIsFavorite() {
        let league = LeagueModel(leagueKey: 305, leagueName: "Premier League", leagueLogo: "logo.png", leagueUrl: "")
        coreDataManager.saveLeague(league, sport: .football)
        
        let leagues = coreDataManager.fetchSavedLeagues()
        let isFavorite = coreDataManager.isFavorite(league: league, arrayOfLeagues: leagues)
        XCTAssertTrue(isFavorite)
    }
}
