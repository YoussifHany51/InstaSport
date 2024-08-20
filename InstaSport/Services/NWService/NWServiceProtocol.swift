//
//  NWServiceProtocol.swift
//  InstaSport
//
//  Created by Youssif Hany on 20/08/2024.
//

import Foundation
protocol NWServiceProtocol {
    func fetchLeaguesAPIData(leagueID: String, completion: @escaping (Data) -> Void)
    func fetchTeamDetails(teamId: String, completion: @escaping (Data) -> Void)
}
