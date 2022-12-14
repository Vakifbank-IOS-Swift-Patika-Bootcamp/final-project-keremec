//
//  ViewController.swift
//  vitarApp
//
//  Created by Kerem Safa Dirican on 9.12.2022.
//

import UIKit

class HomeSceneViewController: UIViewController {
    
    @IBOutlet private weak var gameListTableView: UITableView! {
        didSet{
            gameListTableView.delegate = self
            gameListTableView.dataSource = self
            gameListTableView.register(UINib(nibName: "GameTableViewCell", bundle: nil), forCellReuseIdentifier: "gameCell")
            gameListTableView.rowHeight = 150.0
        }
    }
    
    private var viewModel: HomeSceneViewModelProtocol = HomeSceneViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.fetchPopularGames()
        
    }

}


extension HomeSceneViewController: HomeSceneViewModelDelegate {
    func gamesLoaded() {
        gameListTableView.reloadData()
    }
}


extension HomeSceneViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getGameCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "gameCell", for: indexPath) as? GameTableViewCell,
              let obj = viewModel.getGame(at: indexPath.row) else {return UITableViewCell()}
        DispatchQueue.main.async {
                cell.configureCell(obj)
        }
        return cell
    }
    
}
