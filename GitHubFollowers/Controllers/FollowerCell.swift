//
//  FollowerCell.swift
//  GitHubFollowers
//
//  Created by GGTECH LLC on 11/18/21.
//

import UIKit

class FollowerCell: UICollectionViewCell {
    
    static let reuseID = "followerCell"
    
    let avatarImageView = GFAvatarImageView(frame: .zero)
    let followersLabel = GFTitleLabel(textAlignment: .center, fontSize: 16)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(followers: Follower) {
        followersLabel.text = followers.login
        avatarImageView.downloadImage(from: followers.avatar_url)

    }
    
    private func configure(){
        
        addSubview(avatarImageView)
        addSubview(followersLabel)
        
        let padding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            avatarImageView.trailingAnchor.constraint(equalTo:trailingAnchor, constant: -padding),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            
            followersLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
            followersLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            followersLabel.trailingAnchor.constraint(equalTo:trailingAnchor, constant: -padding),
            followersLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
