//
//  FollowersListVC.swift
//  GitHubFollowers
//
//  Created by GGTECH LLC on 11/16/21.
//

import UIKit


class FollowersListVC: UIViewController {
    
    enum Section {
        case Main
    }
    
    var username: String!
    var collectionView: UICollectionView!
    var followers = [Follower]()
    var page = 1
    var hasMoreFollowers = true

    
    
    var dataSource: UICollectionViewDiffableDataSource<Section,Follower>!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewConfigure()
        configureViewController()
        getFollowersCall(username: username, page: page)
        configureDataSource()
        
    }
    
    func getFollowersCall(username: String, page: Int){
        NetworkManager.shared.getFollowers(for: username, page: page) {[weak self]result in
            
            guard let self = self else {return}
            switch result {
                
            case .success(let followers):
                if followers.count < 100 {self.hasMoreFollowers = false}
                self.followers.append(contentsOf: followers)
                if self.followers.isEmpty {
                    DispatchQueue.main.async {
                        self.showEmptyStateView(with: "No Followers", in: self.view)
                    }
                    return
                }
                
                self.updateData()
                print(followers)
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Bad Stuff Happend", message: error.rawValue, buttonTitle: "Ok")
            }
            
            
        }
        
    }
    
    func configureDataSource(){
        
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            cell.set(followers: follower)
            return cell
            
        })
        
    }
    
    func updateData() {
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        
        snapshot.appendSections([.Main])
        snapshot.appendItems(followers)
        dataSource.apply(snapshot, animatingDifferences: true)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
    
    func configureViewController(){
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func createThreeColumnFlowLayout()-> UICollectionViewFlowLayout {
        let width                       = view.bounds.width
        let padding: CGFloat            = 12
        let minimumItemSpacing: CGFloat = 10
        let availableWidth              = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth                   = availableWidth / 3
        
        let flowLayout                  = UICollectionViewFlowLayout()
        flowLayout.sectionInset         = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize             = CGSize(width: itemWidth, height: itemWidth + 40)
        
        return flowLayout
    }
    
    func collectionViewConfigure(){
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createThreeColumnFlowLayout())
     //for pagination uncomment
        collectionView.delegate = self
        view.addSubview(collectionView)
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let follower = followers[indexPath.item]
        let destVC = UserInfoVC()
        destVC.username = follower.login
        let navController = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
    }
    
}


extension FollowersListVC: UICollectionViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY         = scrollView.contentOffset.y
        let contentHeight   = scrollView.contentSize.height
        let height          = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            guard hasMoreFollowers else { return }
            page += 1
            getFollowersCall(username: username, page: page)
        }
    }
}


