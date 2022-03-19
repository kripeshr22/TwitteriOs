//
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by Kripesh Ranabhat on 3/11/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    
    var favorited: Bool = false
    var retweeted: Bool = false
    var tweetId: Int = -1
    
    func setFavorite(_ isFavorited: Bool) {
        favorited = isFavorited
        if (favorited) {
            likeButton.setImage(UIImage(named:"favor-icon-red"), for: UIControl.State.normal)
        } else {
            likeButton.setImage(UIImage(named:"favor-icon"), for: UIControl.State.normal)
        }
    }
    
    func setRetweeted(_ isRetweeted: Bool) {
        if (isRetweeted) {
            retweetButton.setImage(UIImage(named:"retweet-icon-green"), for: UIControl.State.normal)
            retweetButton.isEnabled = false
        } else {
            retweetButton.setImage(UIImage(named:"retweet-icon"), for: UIControl.State.normal)
            retweetButton.isEnabled = true
        }
    }
    
    @IBAction func favoriteTweet(_ sender: Any) {
        let toBeFavorited = !favorited
        if (toBeFavorited) {
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(true)
            }, failure: { Error in
                print("Favorite did not succeed: \(Error)")
            })
        } else {
            TwitterAPICaller.client?.unFavoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(false)
            }, failure: { Error in
                print("UnFavorite did not suceed \(Error)")
            })
        }
    }
    
    @IBAction func retweetTweet(_ sender: Any) {
        TwitterAPICaller.client?.retweet(tweetId: tweetId, success: {
            self.setRetweeted(true)
        }, failure: { Error in
            print("Retweet did not succeed: \(Error)")
        })
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
