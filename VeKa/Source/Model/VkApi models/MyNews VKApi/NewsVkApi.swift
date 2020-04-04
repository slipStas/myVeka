//
//  NewsVkApi.swift
//  VeKa
//
//  Created by Stanislav Slipchenko on 03.04.2020.
//  Copyright © 2020 Stanislav Slipchenko. All rights reserved.
//

import Foundation

// MARK: - NewsVkAPI
class NewsVkAPI: Codable {
    let response: Response

    init(response: Response) {
        self.response = response
    }
    // MARK: - Response
    class Response: Codable {
        let items: [Item]
        let profiles: [Profile]
        let groups: [Group]
        let nextFrom: String

        enum CodingKeys: String, CodingKey {
            case items, profiles, groups
            case nextFrom = "next_from"
        }

        init(items: [Item], profiles: [Profile], groups: [Group], nextFrom: String) {
            self.items = items
            self.profiles = profiles
            self.groups = groups
            self.nextFrom = nextFrom
        }
    }

    // MARK: - Group
    class Group: Codable {
        let id: Int
        let name, screenName: String
        let isClosed: Int
        let type: GroupType
        let isAdmin, isMember, isAdvertiser: Int
        let photo50, photo100, photo200: String

        enum CodingKeys: String, CodingKey {
            case id, name
            case screenName = "screen_name"
            case isClosed = "is_closed"
            case type
            case isAdmin = "is_admin"
            case isMember = "is_member"
            case isAdvertiser = "is_advertiser"
            case photo50 = "photo_50"
            case photo100 = "photo_100"
            case photo200 = "photo_200"
        }

        init(id: Int, name: String, screenName: String, isClosed: Int, type: GroupType, isAdmin: Int, isMember: Int, isAdvertiser: Int, photo50: String, photo100: String, photo200: String) {
            self.id = id
            self.name = name
            self.screenName = screenName
            self.isClosed = isClosed
            self.type = type
            self.isAdmin = isAdmin
            self.isMember = isMember
            self.isAdvertiser = isAdvertiser
            self.photo50 = photo50
            self.photo100 = photo100
            self.photo200 = photo200
        }
    }

    enum GroupType: String, Codable {
        case group = "group"
        case page = "page"
    }

    // MARK: - Item
    class Item: Codable {
        let canDoubtCategory, canSetCategory: Bool?
        let type: PostTypeEnum
        let sourceID, date: Int
        let postType: PostTypeEnum
        let text: String
        let markedAsAds: Int?
        let attachments: [Attachment]?
        let postSource: ItemPostSource
        let comments: Comments
        let likes: Likes
        let reposts: Reposts
        let views: Views
        let isFavorite: Bool
        let postID: Int
        let copyHistory: [CopyHistory]?
        let categoryAction: CategoryAction?
        let topicID: Int?
        let copyright: Copyright?

        enum CodingKeys: String, CodingKey {
            case canDoubtCategory = "can_doubt_category"
            case canSetCategory = "can_set_category"
            case type
            case sourceID = "source_id"
            case date
            case postType = "post_type"
            case text
            case markedAsAds = "marked_as_ads"
            case attachments
            case postSource = "post_source"
            case comments, likes, reposts, views
            case isFavorite = "is_favorite"
            case postID = "post_id"
            case copyHistory = "copy_history"
            case categoryAction = "category_action"
            case topicID = "topic_id"
            case copyright
        }

        init(canDoubtCategory: Bool?, canSetCategory: Bool?, type: PostTypeEnum, sourceID: Int, date: Int, postType: PostTypeEnum, text: String, markedAsAds: Int?, attachments: [Attachment]?, postSource: ItemPostSource, comments: Comments, likes: Likes, reposts: Reposts, views: Views, isFavorite: Bool, postID: Int, copyHistory: [CopyHistory]?, categoryAction: CategoryAction?, topicID: Int?, copyright: Copyright?) {
            self.canDoubtCategory = canDoubtCategory
            self.canSetCategory = canSetCategory
            self.type = type
            self.sourceID = sourceID
            self.date = date
            self.postType = postType
            self.text = text
            self.markedAsAds = markedAsAds
            self.attachments = attachments
            self.postSource = postSource
            self.comments = comments
            self.likes = likes
            self.reposts = reposts
            self.views = views
            self.isFavorite = isFavorite
            self.postID = postID
            self.copyHistory = copyHistory
            self.categoryAction = categoryAction
            self.topicID = topicID
            self.copyright = copyright
        }
    }

    // MARK: - Attachment
    class Attachment: Codable {
        let type: AttachmentType
        let video: Video?
        let photo: AttachmentPhoto?
        let link: Link?

        init(type: AttachmentType, video: Video?, photo: AttachmentPhoto?, link: Link?) {
            self.type = type
            self.video = video
            self.photo = photo
            self.link = link
        }
    }

    // MARK: - Link
    class Link: Codable {
        let url: String
        let title, linkDescription, target: String
        let photo: LinkPhoto?
        let isFavorite: Bool
        let previewArticle: PreviewArticle?

        enum CodingKeys: String, CodingKey {
            case url, title
            case linkDescription = "description"
            case target, photo
            case isFavorite = "is_favorite"
            case previewArticle = "preview_article"
        }

        init(url: String, title: String, linkDescription: String, target: String, photo: LinkPhoto?, isFavorite: Bool, previewArticle: PreviewArticle?) {
            self.url = url
            self.title = title
            self.linkDescription = linkDescription
            self.target = target
            self.photo = photo
            self.isFavorite = isFavorite
            self.previewArticle = previewArticle
        }
    }

    // MARK: - LinkPhoto
    class LinkPhoto: Codable {
        let id, albumID, ownerID: Int
        let sizes: [Size]
        let text: String
        let date: Int

        enum CodingKeys: String, CodingKey {
            case id
            case albumID = "album_id"
            case ownerID = "owner_id"
            case sizes, text, date
        }

        init(id: Int, albumID: Int, ownerID: Int, sizes: [Size], text: String, date: Int) {
            self.id = id
            self.albumID = albumID
            self.ownerID = ownerID
            self.sizes = sizes
            self.text = text
            self.date = date
        }
    }

    // MARK: - Size
    class Size: Codable {
        let type: SizeType?
        let url: String
        let width, height: Int
        let withPadding: Int?

        enum CodingKeys: String, CodingKey {
            case type, url, width, height
            case withPadding = "with_padding"
        }

        init(type: SizeType?, url: String, width: Int, height: Int, withPadding: Int?) {
            self.type = type
            self.url = url
            self.width = width
            self.height = height
            self.withPadding = withPadding
        }
    }

    enum SizeType: String, Codable {
        case k = "k"
        case l = "l"
        case m = "m"
        case o = "o"
        case p = "p"
        case q = "q"
        case r = "r"
        case s = "s"
        case w = "w"
        case x = "x"
        case y = "y"
        case z = "z"
    }

    // MARK: - PreviewArticle
    class PreviewArticle: Codable {
        let id, ownerID: Int
        let ownerName: String
        let ownerPhoto: String
        let state: String
        let canReport: Bool
        let title, subtitle: String
        let views, shares: Int
        let isFavorite: Bool
        let url, viewURL: String
        let noFooter: Bool
        let accessKey: String
        let publishedDate: Int
        let photo: LinkPhoto

        enum CodingKeys: String, CodingKey {
            case id
            case ownerID = "owner_id"
            case ownerName = "owner_name"
            case ownerPhoto = "owner_photo"
            case state
            case canReport = "can_report"
            case title, subtitle, views, shares
            case isFavorite = "is_favorite"
            case url
            case viewURL = "view_url"
            case noFooter = "no_footer"
            case accessKey = "access_key"
            case publishedDate = "published_date"
            case photo
        }

        init(id: Int, ownerID: Int, ownerName: String, ownerPhoto: String, state: String, canReport: Bool, title: String, subtitle: String, views: Int, shares: Int, isFavorite: Bool, url: String, viewURL: String, noFooter: Bool, accessKey: String, publishedDate: Int, photo: LinkPhoto) {
            self.id = id
            self.ownerID = ownerID
            self.ownerName = ownerName
            self.ownerPhoto = ownerPhoto
            self.state = state
            self.canReport = canReport
            self.title = title
            self.subtitle = subtitle
            self.views = views
            self.shares = shares
            self.isFavorite = isFavorite
            self.url = url
            self.viewURL = viewURL
            self.noFooter = noFooter
            self.accessKey = accessKey
            self.publishedDate = publishedDate
            self.photo = photo
        }
    }

    // MARK: - AttachmentPhoto
    class AttachmentPhoto: Codable {
        let id, albumID, ownerID: Int
        let userID: Int?
        let sizes: [Size]
        let text: String
        let date: Int
        let postID: Int?
        let accessKey: String
        let lat, long: Double?

        enum CodingKeys: String, CodingKey {
            case id
            case albumID = "album_id"
            case ownerID = "owner_id"
            case userID = "user_id"
            case sizes, text, date
            case postID = "post_id"
            case accessKey = "access_key"
            case lat, long
        }

        init(id: Int, albumID: Int, ownerID: Int, userID: Int?, sizes: [Size], text: String, date: Int, postID: Int?, accessKey: String, lat: Double?, long: Double?) {
            self.id = id
            self.albumID = albumID
            self.ownerID = ownerID
            self.userID = userID
            self.sizes = sizes
            self.text = text
            self.date = date
            self.postID = postID
            self.accessKey = accessKey
            self.lat = lat
            self.long = long
        }
    }

    enum AttachmentType: String, Codable {
        case link = "link"
        case photo = "photo"
        case video = "video"
    }

    // MARK: - Video
    class Video: Codable {
        let accessKey: String
        let canComment, canLike, canRepost, canSubscribe: Int
        let canAddToFaves, canAdd, comments, date: Int
        let videoDescription: String
        let duration: Int
        let image: [Size]
        let firstFrame: [Size]?
        let width, height: Int?
        let id, ownerID: Int
        let title, trackCode: String
        let type: AttachmentType
        let views: Int
        let videoRepeat, localViews: Int?
        let platform: String?

        enum CodingKeys: String, CodingKey {
            case accessKey = "access_key"
            case canComment = "can_comment"
            case canLike = "can_like"
            case canRepost = "can_repost"
            case canSubscribe = "can_subscribe"
            case canAddToFaves = "can_add_to_faves"
            case canAdd = "can_add"
            case comments, date
            case videoDescription = "description"
            case duration, image
            case firstFrame = "first_frame"
            case width, height, id
            case ownerID = "owner_id"
            case title
            case trackCode = "track_code"
            case type, views
            case videoRepeat = "repeat"
            case localViews = "local_views"
            case platform
        }

        init(accessKey: String, canComment: Int, canLike: Int, canRepost: Int, canSubscribe: Int, canAddToFaves: Int, canAdd: Int, comments: Int, date: Int, videoDescription: String, duration: Int, image: [Size], firstFrame: [Size]?, width: Int?, height: Int?, id: Int, ownerID: Int, title: String, trackCode: String, type: AttachmentType, views: Int, videoRepeat: Int?, localViews: Int?, platform: String?) {
            self.accessKey = accessKey
            self.canComment = canComment
            self.canLike = canLike
            self.canRepost = canRepost
            self.canSubscribe = canSubscribe
            self.canAddToFaves = canAddToFaves
            self.canAdd = canAdd
            self.comments = comments
            self.date = date
            self.videoDescription = videoDescription
            self.duration = duration
            self.image = image
            self.firstFrame = firstFrame
            self.width = width
            self.height = height
            self.id = id
            self.ownerID = ownerID
            self.title = title
            self.trackCode = trackCode
            self.type = type
            self.views = views
            self.videoRepeat = videoRepeat
            self.localViews = localViews
            self.platform = platform
        }
    }

    // MARK: - CategoryAction
    class CategoryAction: Codable {
        let action: Action
        let name: String

        init(action: Action, name: String) {
            self.action = action
            self.name = name
        }
    }

    // MARK: - Action
    class Action: Codable {
        let target, type, url: String

        init(target: String, type: String, url: String) {
            self.target = target
            self.type = type
            self.url = url
        }
    }

    // MARK: - Comments
    class Comments: Codable {
        let count, canPost: Int
        let groupsCanPost: Bool?

        enum CodingKeys: String, CodingKey {
            case count
            case canPost = "can_post"
            case groupsCanPost = "groups_can_post"
        }

        init(count: Int, canPost: Int, groupsCanPost: Bool?) {
            self.count = count
            self.canPost = canPost
            self.groupsCanPost = groupsCanPost
        }
    }

    // MARK: - CopyHistory
    class CopyHistory: Codable {
        let id, ownerID, fromID, date: Int
        let postType: PostTypeEnum
        let text: String
        let attachments: [Attachment]
        let postSource: CopyHistoryPostSource

        enum CodingKeys: String, CodingKey {
            case id
            case ownerID = "owner_id"
            case fromID = "from_id"
            case date
            case postType = "post_type"
            case text, attachments
            case postSource = "post_source"
        }

        init(id: Int, ownerID: Int, fromID: Int, date: Int, postType: PostTypeEnum, text: String, attachments: [Attachment], postSource: CopyHistoryPostSource) {
            self.id = id
            self.ownerID = ownerID
            self.fromID = fromID
            self.date = date
            self.postType = postType
            self.text = text
            self.attachments = attachments
            self.postSource = postSource
        }
    }

    // MARK: - CopyHistoryPostSource
    class CopyHistoryPostSource: Codable {
        let type: PostSourceType

        init(type: PostSourceType) {
            self.type = type
        }
    }

    enum PostSourceType: String, Codable {
        case api = "api"
        case mvk = "mvk"
        case vk = "vk"
    }

    enum PostTypeEnum: String, Codable {
        case post = "post"
    }

    // MARK: - Copyright
    class Copyright: Codable {
        let id: Int
        let link: String
        let type, name: String

        init(id: Int, link: String, type: String, name: String) {
            self.id = id
            self.link = link
            self.type = type
            self.name = name
        }
    }

    // MARK: - Likes
    class Likes: Codable {
        let count, userLikes, canLike, canPublish: Int

        enum CodingKeys: String, CodingKey {
            case count
            case userLikes = "user_likes"
            case canLike = "can_like"
            case canPublish = "can_publish"
        }

        init(count: Int, userLikes: Int, canLike: Int, canPublish: Int) {
            self.count = count
            self.userLikes = userLikes
            self.canLike = canLike
            self.canPublish = canPublish
        }
    }

    // MARK: - ItemPostSource
    class ItemPostSource: Codable {
        let type: PostSourceType
        let platform: Platform?

        init(type: PostSourceType, platform: Platform?) {
            self.type = type
            self.platform = platform
        }
    }

    enum Platform: String, Codable {
        case android = "android"
        case iphone = "iphone"
    }

    // MARK: - Reposts
    class Reposts: Codable {
        let count, userReposted: Int

        enum CodingKeys: String, CodingKey {
            case count
            case userReposted = "user_reposted"
        }

        init(count: Int, userReposted: Int) {
            self.count = count
            self.userReposted = userReposted
        }
    }

    // MARK: - Views
    class Views: Codable {
        let count: Int

        init(count: Int) {
            self.count = count
        }
    }

    // MARK: - Profile
    class Profile: Codable {
        let id: Int
        let firstName, lastName: String
        let isClosed, canAccessClosed: Bool?
        let sex: Int
        let screenName: String?
        let photo50, photo100: String
        let online: Int
        let onlineInfo: OnlineInfo
        let deactivated: String?
        let onlineApp, onlineMobile: Int?

        enum CodingKeys: String, CodingKey {
            case id
            case firstName = "first_name"
            case lastName = "last_name"
            case isClosed = "is_closed"
            case canAccessClosed = "can_access_closed"
            case sex
            case screenName = "screen_name"
            case photo50 = "photo_50"
            case photo100 = "photo_100"
            case online
            case onlineInfo = "online_info"
            case deactivated
            case onlineApp = "online_app"
            case onlineMobile = "online_mobile"
        }

        init(id: Int, firstName: String, lastName: String, isClosed: Bool?, canAccessClosed: Bool?, sex: Int, screenName: String?, photo50: String, photo100: String, online: Int, onlineInfo: OnlineInfo, deactivated: String?, onlineApp: Int?, onlineMobile: Int?) {
            self.id = id
            self.firstName = firstName
            self.lastName = lastName
            self.isClosed = isClosed
            self.canAccessClosed = canAccessClosed
            self.sex = sex
            self.screenName = screenName
            self.photo50 = photo50
            self.photo100 = photo100
            self.online = online
            self.onlineInfo = onlineInfo
            self.deactivated = deactivated
            self.onlineApp = onlineApp
            self.onlineMobile = onlineMobile
        }
    }

    // MARK: - OnlineInfo
    class OnlineInfo: Codable {
        let visible: Bool
        let lastSeen, appID: Int?
        let isMobile, isOnline: Bool?

        enum CodingKeys: String, CodingKey {
            case visible
            case lastSeen = "last_seen"
            case appID = "app_id"
            case isMobile = "is_mobile"
            case isOnline = "is_online"
        }

        init(visible: Bool, lastSeen: Int?, appID: Int?, isMobile: Bool?, isOnline: Bool?) {
            self.visible = visible
            self.lastSeen = lastSeen
            self.appID = appID
            self.isMobile = isMobile
            self.isOnline = isOnline
        }
    }
}

