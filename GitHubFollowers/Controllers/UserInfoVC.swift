//
//  UserInfoVC.swift
//  GitHubFollowers
//
//  Created by GGTECH LLC on 11/18/21.
//

import UIKit

class UserInfoVC: UIViewController {

    var username: String!
    let headerView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutUI()
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        
        navigationItem.rightBarButtonItem = doneButton
        
        NetworkManager.shared.getuserInfo(for: username) { [weak self] result  in
            guard let self = self else {return}
            switch result{
            case .success(let user):
                DispatchQueue.main.async {
                    self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)

                }
                print(user)
                
            case .failure(let error):
                break
                
            }
        }
    }
    
    @objc func dismissVC(){
        dismiss(animated: true)
    }

    func add(childVC: UIViewController, to containerView: UIView){
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
        
    }
    
    func layoutUI(){
        view.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180)
        
        ])
        
    }

}
