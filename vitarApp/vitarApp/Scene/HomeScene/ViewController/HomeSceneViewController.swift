//
//  ViewController.swift
//  vitarApp
//
//  Created by Kerem Safa Dirican on 9.12.2022.
//

import UIKit

class HomeSceneViewController: UIViewController {
    
    //MARK: - Outlets and Variables
    var orderCase = 0
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var orderButtonOutlet: UIBarButtonItem!
    @IBOutlet private weak var gameListTableView: UITableView! {
        didSet{
            gameListTableView.delegate = self
            gameListTableView.dataSource = self
            gameListTableView.register(UINib(nibName: "GameTableViewCell", bundle: nil), forCellReuseIdentifier: "gameCell")
            gameListTableView.rowHeight = 150.0
        }
    }
    
    private var viewModel: HomeSceneViewModelProtocol = HomeSceneViewModel()
    
    //MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = NSLocalizedString("POPULAR_GAMES", comment: "Popular Games")
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleError),
                                               name: NSNotification.Name("popularGamesErrorMessage"),
                                               object: nil)
        viewModel.delegate = self
        activityIndicator.startAnimating()
        viewModel.fetchPopularGames()
        LocalNotificationManager.shared.missUserNotification(day: 2)
    }
    
    //MARK: - Segue Functions
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "HometoDetail":
            if let gameId = sender as? Int{
                let goalVC = segue.destination as! GameDetailSceneViewController
                goalVC.gameId = gameId
            }
        default:
            print("identifier not found")
        }
    }
    
    //MARK: - Action Functions
    
    @IBAction private func orderListAction(_ sender: Any) {
        orderCase += 1
        switch orderCase {
        case 1:
            viewModel.orderList(opt: orderCase)
            orderButtonOutlet.image = UIImage(systemName: "a.square")
        case 2:
            viewModel.orderList(opt: orderCase)
            orderButtonOutlet.image = UIImage(systemName: "30.square")
        case 3:
            viewModel.orderList(opt: orderCase)
            orderButtonOutlet.image = UIImage(systemName: "star.square")
        default:
            viewModel.orderList(opt: orderCase)
            orderButtonOutlet.image = UIImage(systemName: "line.horizontal.3.decrease")
            orderCase = 0
        }
    }
    
}

//MARK: - Delegate Functions
extension HomeSceneViewController: HomeSceneViewModelDelegate {
    func gamesLoaded() {
        gameListTableView.reloadData()
        activityIndicator.stopAnimating()
    }
}
//MARK: - Tableview Functions
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let gameId = viewModel.getGameId(at: indexPath.row){
            performSegue(withIdentifier: "HometoDetail", sender: gameId)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
//MARK: -
