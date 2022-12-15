//
//  GameDetailViewController.swift
//  vitarApp
//
//  Created by Kerem Safa Dirican on 14.12.2022.
//

import UIKit

class GameDetailSceneViewController: UIViewController {

    @IBOutlet private weak var gameImageView: UIImageView!
    @IBOutlet private weak var publisherLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var infoLabel: UILabel!
    @IBOutlet private weak var ratingOutlet: UIButton!
    @IBOutlet private weak var dateOutlet: UIButton!
    @IBOutlet private weak var scoreOutlet: UIButton!
    @IBOutlet private weak var detailText: UITextView!
    @IBOutlet private weak var platformPC: UIButton!
    @IBOutlet private weak var platformXbox: UIButton!
    @IBOutlet private weak var platformSony: UIButton!
    @IBOutlet private weak var platformNintendo: UIButton!
    
    var gameId: Int?
    private var viewModel: GameDetailSceneViewModelProtocol = GameDetailSceneViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameImageView.layer.cornerRadius = 7.5
        
        ratingOutlet.titleLabel?.text = ""
        dateOutlet.titleLabel?.text = ""
        scoreOutlet.titleLabel?.text = ""
        
        guard let id = gameId else { return }
        viewModel.delegate = self
        viewModel.fetchGameDetail(id)
    }
    
    
    private func enablePlatform(id:Int){
        switch id {
        case -1:
            platformPC.isHidden = true
            platformXbox.isHidden = true
            platformSony.isHidden = true
            platformNintendo.isHidden = true
        case 1:
            platformPC.isHidden = false
        case 2:
            platformSony.isHidden = false
        case 3:
            platformXbox.isHidden = false
        case 7:
            platformNintendo.isHidden = false
        default:
            break
        }
    }
    

}


extension GameDetailSceneViewController: GameDetailSceneViewModelDelegate{
    func gameLoaded() {
        DispatchQueue.main.async {
            self.publisherLabel.text = self.viewModel.getGamePublisher()
            self.titleLabel.text = self.viewModel.getGameTitle()
            self.infoLabel.text = self.viewModel.getGameInfo()
            self.ratingOutlet.setTitle(self.viewModel.getGameRating(), for: .normal)
            if let date = self.viewModel.getGameDate(){
                self.dateOutlet.titleLabel?.text = date
            }else{
                self.dateOutlet.setTitle(NSLocalizedString("TBA_DATE", comment: "Release Date"), for: .normal)
            }
            
            if let score = self.viewModel.getGameScore(){
                self.scoreOutlet.setTitle(score, for: .normal)
            }else{
                self.scoreOutlet.setTitle("", for: .normal)
                self.scoreOutlet.setImage(UIImage(systemName: "star.slash"), for: .normal)
            }
            self.detailText.text = self.viewModel.getGameDetail()
            self.gameImageView.kf.setImage(with: self.viewModel.getGameImageUrl(420), placeholder: UIImage(named: "no-poster"))
            
            if let platforms = self.viewModel.getGamePlatforms(){
                for i in platforms{
                    self.enablePlatform(id: i.platform?.id ?? 0)
                }
            }
            
        }
    }
    
    
}
