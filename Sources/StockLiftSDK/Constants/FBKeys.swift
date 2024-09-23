//
//  FBFirestore.swift
//  Stocklift
//
//  Created by Christopher Hicks on 7/22/22.
//  Copyright © 2023 StockLift Inc. All rights reserved.
//

import Foundation

public enum FBKeys {
    
    public enum CollectionPath {
        public static let users = "users"
        public static let linkedAccounts = "linked_accounts"
        public static let following = "user-following"
        public static let watchlist = "user-watchlist"
    }
    
    public enum User {
        public static let uid = "uid"
        public static let firstname = "first_name"
        public static let lastname = "last_name"
        public static let email = "email"
        public static let jobTitle = "job_title"
        public static let company = "company"
        public static let city = "city"
        public static let state = "state"
        public static let country = "country"
        public static let accountType = "account_type"
        public static let profileImageUrl = "profile_image_url"
        public static let linkedAccount = "linked_account"
        public static let allowsPush = "allows_push"
        public static let deactivated = "deactivated"
        public static let verified = "verified"
        public static let type = "type"
        public static let username = "username"
        public static let pageName = "page_name"
    }
    
    public enum Account {
        public static let name = "institution_name"
        public static let id = "institution_id"
        public static let token = "plaid_access_token"
        public static let accounts = "accounts"
    }
    
    public enum Post {
        public static let id = "id"
        public static let type = "type"
        public static let subType = "sub_type"
        public static let text = "text"
        public static let title = "title"
        public static let imageUrl = "image_url"
        public static let videoUrl = "video_url"
        public static let category = "category"
        public static let authorUid = "author_uuid"
        public static let repostUserUuid = "repost_user_uuid"
        public static let isRepost = "is_repost"
        public static let timestamp = "timestamp"
        public static let repostTimestamp = "repost_timestamp"
        public static let articleUrl = "article_url"
        public static let commentCount = "comment_count"
        public static let viewCount = "view_count"
    }
}

