//
//  HomeSceneViewModel.swift
//  vitarApp
//
//  Created by Kerem Safa Dirican on 13.12.2022.
//

import Foundation

protocol HomeSceneViewModelProtocol {
    var delegate: HomeSceneViewModelDelegate? { get set }
    func fetchPopularGames()
    func searchGames(_ keyword: String)
    func getGameCount() -> Int
    func getGame(at index: Int) -> RawgModel?
    func getGameId(at index: Int) -> Int?
}

protocol HomeSceneViewModelDelegate: AnyObject {
    func gamesLoaded()
}


final class HomeSceneViewModel: HomeSceneViewModelProtocol {
    weak var delegate: HomeSceneViewModelDelegate?
    private var games: [RawgModel]?
    
    func fetchPopularGames() {
        RawgClient.getPopularGames { [weak self] games, error in
            guard let self = self else { return }
            self.games = games
            self.delegate?.gamesLoaded()
        }
    }
    
    func searchGames(_ keyword: String) {
        RawgClient.searchGames(gameName: keyword) { [weak self] games, error in
            guard let self = self else { return }
            self.games = games
            self.delegate?.gamesLoaded()
        }
    }
    
    
    func getGameCount() -> Int {
        games?.count ?? 0
    }
    
    func getGame(at index: Int) -> RawgModel? {
        games?[index]
    }
    
    func getGameId(at index: Int) -> Int? {
        games?[index].id
    }
    
}
