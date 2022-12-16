//
//  GameDetailViewModel.swift
//  vitarApp
//
//  Created by Kerem Safa Dirican on 14.12.2022.
//

import Foundation

protocol GameDetailSceneViewModelProtocol {
    var delegate: GameDetailSceneViewModelDelegate? { get set }
    func fetchGameDetail(_ id:Int)
    func getGameImageUrl(_ size:Int) -> URL?
    func getGamePublisher() -> String?
    func getGameTitle() -> String?
    func getGameInfo() -> String?
    func getGameRating() -> String?
    func getGameDate() -> String?
    func getGameScore() -> String?
    func getGameDetail() -> String?
    func getGamePlatforms() -> [ParentPlatform]?
    
    func handleFavorite() -> Bool?
    func isFavoriteGame(_ id:Int) -> Bool?
}

protocol GameDetailSceneViewModelDelegate: AnyObject {
    func gameLoaded()
}


final class GameDetailSceneViewModel: GameDetailSceneViewModelProtocol {
    weak var delegate: GameDetailSceneViewModelDelegate?
    private var game: RawgDetailModel?
    
    func fetchGameDetail(_ id:Int){
        RawgClient.getGameDetail(gameId: id) { [weak self] game, error in
            guard let self = self else { return }
            self.game = game
            self.delegate?.gameLoaded()
        }
    }
    
    func getGameImageUrl(_ size:Int) -> URL? {
        return URL(string: game?.imageWide?.replacingOccurrences(of: "media/g", with: "media/resize/\(size)/-/g") ?? "")
    }
    
    func getGamePublisher() -> String? {
        var leadStudio = ""
        var mainPublisher = ""
        if let studios = game?.developers{
            if studios.count > 0{
                leadStudio = studios[0].name ?? ""
            }
        }
        
        if let publishers = game?.publishers{
            if publishers.count > 0{
                mainPublisher = publishers[0].name ?? ""
            }
        }
        
        return "\(leadStudio), \(mainPublisher)"
    }
    
    func getGameTitle() -> String? {
        return game?.name ?? ""
    }
    
    func getGameInfo() -> String? {
        let dateString = (game?.tba ?? false) ? "TBA" : (game?.released?.prefix(4) ?? "TBA")
        var genreString = ""
        if let genres = game?.genres, ((game?.genres?.count ?? 0) != 0){
            for i in genres{
                genreString += i.name ?? ""
                genreString += ", "
            }
            genreString.removeLast(2)
        }
        return "\(dateString) | \(genreString) "
    }
    
    func getGameRating() -> String? {
        Globals.sharedInstance.Esrb(id: game?.rating?.id)
    }
    
    func getGameDate() -> String? {
        if game?.tba ?? false{
            return nil
        }
        
        if let date = game?.released{
            return Globals.sharedInstance.formatDate(date: date)
        }
        
        return nil
    }
    
    func getGameScore() -> String? {
        if let score:Int = game?.metacritic{
            return String(score)
        }
        return nil
    }
    
    func getGameDetail() -> String? {
        return game?.description ?? ""
    }
    
    func getGamePlatforms() -> [ParentPlatform]? {
        return game?.parentPlatforms
    }
    
    
    func handleFavorite() -> Bool?{
        if let gameId = game?.id{
            if let isFavorite = isFavoriteGame(gameId){
                if isFavorite{  return unlikeGame() }
                return likeGame()
            }
            return nil
        }
        return nil
    }
    
    func isFavoriteGame(_ id: Int) -> Bool? {
        CoreDataManager.shared.isFavorite(id)
    }
    
    private func likeGame() -> Bool {
        if let gameId = game?.id, let imageId = URL(string: game?.imageWide ?? "")?.lastPathComponent{
            guard CoreDataManager.shared.saveFavorite(gameId: gameId, imageId: imageId) != nil else {return !true}
            Globals.sharedInstance.isFavoriteChanged = true
            return true
        }
        return !true
    }
    
    private func unlikeGame() -> Bool {
        if let gameId = game?.id{
            guard CoreDataManager.shared.deleteFavoriteWithId(id: gameId) != nil else {return !false}
            Globals.sharedInstance.isFavoriteChanged = true
            return false
        }
        return !false
    }
}

