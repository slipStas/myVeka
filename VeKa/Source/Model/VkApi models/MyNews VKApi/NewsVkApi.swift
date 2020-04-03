//
//  NewsVkApi.swift
//  VeKa
//
//  Created by Stanislav Slipchenko on 03.04.2020.
//  Copyright © 2020 Stanislav Slipchenko. All rights reserved.
//

import Foundation

// MARK: - MyNewsVkAPI
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
        let canDoubtCategory, canSetCategory: Bool
        let type: PostTypeEnum
        let sourceID, date: Int
        let postType: PostTypeEnum
        let text: String
        let markedAsAds: Int?
        let attachments: [ItemAttachment]?
        let postSource: PostSource
        let comments: Comments
        let likes: Likes
        let reposts: Reposts
        let views: Views
        let isFavorite: Bool
        let postID: Int
        let topicID: Int?
        let categoryAction: CategoryAction?
        let copyHistory: [CopyHistory]?
        let signerID: Int?
        
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
            case topicID = "topic_id"
            case categoryAction = "category_action"
            case copyHistory = "copy_history"
            case signerID = "signer_id"
        }
        
        init(canDoubtCategory: Bool, canSetCategory: Bool, type: PostTypeEnum, sourceID: Int, date: Int, postType: PostTypeEnum, text: String, markedAsAds: Int?, attachments: [ItemAttachment]?, postSource: PostSource, comments: Comments, likes: Likes, reposts: Reposts, views: Views, isFavorite: Bool, postID: Int, topicID: Int?, categoryAction: CategoryAction?, copyHistory: [CopyHistory]?, signerID: Int?) {
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
            self.topicID = topicID
            self.categoryAction = categoryAction
            self.copyHistory = copyHistory
            self.signerID = signerID
        }
    }
    
    // MARK: - ItemAttachment
    class ItemAttachment: Codable {
        let type: AttachmentType
        let photo: AttachmentPhoto?
        let video: PurpleVideo?
        let link: Link?
        let poll: Poll?
        
        init(type: AttachmentType, photo: AttachmentPhoto?, video: PurpleVideo?, link: Link?, poll: Poll?) {
            self.type = type
            self.photo = photo
            self.video = video
            self.link = link
            self.poll = poll
        }
    }
    
    // MARK: - Link
    class Link: Codable {
        let url: String
        let title: String
        let caption: String?
        let linkDescription: String
        let photo: LinkPhoto
        let isFavorite: Bool
        let target: String?
        
        enum CodingKeys: String, CodingKey {
            case url, title, caption
            case linkDescription = "description"
            case photo
            case isFavorite = "is_favorite"
            case target
        }
        
        init(url: String, title: String, caption: String?, linkDescription: String, photo: LinkPhoto, isFavorite: Bool, target: String?) {
            self.url = url
            self.title = title
            self.caption = caption
            self.linkDescription = linkDescription
            self.photo = photo
            self.isFavorite = isFavorite
            self.target = target
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
        case a = "a"
        case b = "b"
        case c = "c"
        case d = "d"
        case e = "e"
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
    
    // MARK: - Poll
    class Poll: Codable {
        let id, ownerID, created: Int
        let question: String
        let votes: Int
        let answers: [Answer]
        let anonymous, multiple: Bool
        let answerIDS: [JSONAny]
        let endDate: Int
        let closed, isBoard, canEdit, canVote: Bool
        let canReport, canShare: Bool
        let authorID: Int
        let photo: PollPhoto
        
        enum CodingKeys: String, CodingKey {
            case id
            case ownerID = "owner_id"
            case created, question, votes, answers, anonymous, multiple
            case answerIDS = "answer_ids"
            case endDate = "end_date"
            case closed
            case isBoard = "is_board"
            case canEdit = "can_edit"
            case canVote = "can_vote"
            case canReport = "can_report"
            case canShare = "can_share"
            case authorID = "author_id"
            case photo
        }
        
        init(id: Int, ownerID: Int, created: Int, question: String, votes: Int, answers: [Answer], anonymous: Bool, multiple: Bool, answerIDS: [JSONAny], endDate: Int, closed: Bool, isBoard: Bool, canEdit: Bool, canVote: Bool, canReport: Bool, canShare: Bool, authorID: Int, photo: PollPhoto) {
            self.id = id
            self.ownerID = ownerID
            self.created = created
            self.question = question
            self.votes = votes
            self.answers = answers
            self.anonymous = anonymous
            self.multiple = multiple
            self.answerIDS = answerIDS
            self.endDate = endDate
            self.closed = closed
            self.isBoard = isBoard
            self.canEdit = canEdit
            self.canVote = canVote
            self.canReport = canReport
            self.canShare = canShare
            self.authorID = authorID
            self.photo = photo
        }
    }
    
    // MARK: - Answer
    class Answer: Codable {
        let id: Int
        let text: String
        let votes: Int
        let rate: Double
        
        init(id: Int, text: String, votes: Int, rate: Double) {
            self.id = id
            self.text = text
            self.votes = votes
            self.rate = rate
        }
    }
    
    // MARK: - PollPhoto
    class PollPhoto: Codable {
        let id: Int
        let color: String
        let images: [Size]
        
        init(id: Int, color: String, images: [Size]) {
            self.id = id
            self.color = color
            self.images = images
        }
    }
    
    enum AttachmentType: String, Codable {
        case audio = "audio"
        case link = "link"
        case photo = "photo"
        case poll = "poll"
        case video = "video"
    }
    
    // MARK: - PurpleVideo
    class PurpleVideo: Codable {
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
        let videoRepeat: Int?
        let type: AttachmentType
        let views: Int
        let localViews: Int?
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
            case videoRepeat = "repeat"
            case type, views
            case localViews = "local_views"
            case platform
        }
        
        init(accessKey: String, canComment: Int, canLike: Int, canRepost: Int, canSubscribe: Int, canAddToFaves: Int, canAdd: Int, comments: Int, date: Int, videoDescription: String, duration: Int, image: [Size], firstFrame: [Size]?, width: Int?, height: Int?, id: Int, ownerID: Int, title: String, trackCode: String, videoRepeat: Int?, type: AttachmentType, views: Int, localViews: Int?, platform: String?) {
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
            self.videoRepeat = videoRepeat
            self.type = type
            self.views = views
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
        let attachments: [CopyHistoryAttachment]
        let postSource: PostSource
        
        enum CodingKeys: String, CodingKey {
            case id
            case ownerID = "owner_id"
            case fromID = "from_id"
            case date
            case postType = "post_type"
            case text, attachments
            case postSource = "post_source"
        }
        
        init(id: Int, ownerID: Int, fromID: Int, date: Int, postType: PostTypeEnum, text: String, attachments: [CopyHistoryAttachment], postSource: PostSource) {
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
    
    // MARK: - CopyHistoryAttachment
    class CopyHistoryAttachment: Codable {
        let type: AttachmentType
        let video: FluffyVideo?
        let photo: AttachmentPhoto?
        let link: Link?
        let audio: Audio?
        
        init(type: AttachmentType, video: FluffyVideo?, photo: AttachmentPhoto?, link: Link?, audio: Audio?) {
            self.type = type
            self.video = video
            self.photo = photo
            self.link = link
            self.audio = audio
        }
    }
    
    // MARK: - Audio
    class Audio: Codable {
        let artist: String
        let id, ownerID: Int
        let title: String
        let duration: Int
        let trackCode: String
        let url: String
        let date, genreID: Int
        
        enum CodingKeys: String, CodingKey {
            case artist, id
            case ownerID = "owner_id"
            case title, duration
            case trackCode = "track_code"
            case url, date
            case genreID = "genre_id"
        }
        
        init(artist: String, id: Int, ownerID: Int, title: String, duration: Int, trackCode: String, url: String, date: Int, genreID: Int) {
            self.artist = artist
            self.id = id
            self.ownerID = ownerID
            self.title = title
            self.duration = duration
            self.trackCode = trackCode
            self.url = url
            self.date = date
            self.genreID = genreID
        }
    }
    
    // MARK: - FluffyVideo
    class FluffyVideo: Codable {
        let accessKey: String
        let canComment, canLike, canRepost, canSubscribe: Int
        let canAddToFaves, canAdd, comments, date: Int
        let videoDescription: String
        let duration: Int
        let image: [Size]
        let id, ownerID: Int
        let title, trackCode: String
        let type: AttachmentType
        let views, localViews: Int
        let platform: String
        
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
            case duration, image, id
            case ownerID = "owner_id"
            case title
            case trackCode = "track_code"
            case type, views
            case localViews = "local_views"
            case platform
        }
        
        init(accessKey: String, canComment: Int, canLike: Int, canRepost: Int, canSubscribe: Int, canAddToFaves: Int, canAdd: Int, comments: Int, date: Int, videoDescription: String, duration: Int, image: [Size], id: Int, ownerID: Int, title: String, trackCode: String, type: AttachmentType, views: Int, localViews: Int, platform: String) {
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
            self.id = id
            self.ownerID = ownerID
            self.title = title
            self.trackCode = trackCode
            self.type = type
            self.views = views
            self.localViews = localViews
            self.platform = platform
        }
    }
    
    // MARK: - PostSource
    class PostSource: Codable {
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
    
    enum PostSourceType: String, Codable {
        case api = "api"
        case mvk = "mvk"
        case vk = "vk"
    }
    
    enum PostTypeEnum: String, Codable {
        case post = "post"
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
        let onlineApp, onlineMobile: Int?
        let deactivated: String?
        
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
            case onlineApp = "online_app"
            case onlineMobile = "online_mobile"
            case deactivated
        }
        
        init(id: Int, firstName: String, lastName: String, isClosed: Bool?, canAccessClosed: Bool?, sex: Int, screenName: String?, photo50: String, photo100: String, online: Int, onlineInfo: OnlineInfo, onlineApp: Int?, onlineMobile: Int?, deactivated: String?) {
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
            self.onlineApp = onlineApp
            self.onlineMobile = onlineMobile
            self.deactivated = deactivated
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
    
    // MARK: - Encode/decode helpers
    
    class JSONNull: Codable, Hashable {
        
        public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
            return true
        }
        
        public var hashValue: Int {
            return 0
        }
        
        public init() {}
        
        public required init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if !container.decodeNil() {
                throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
            }
        }
        
        public func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            try container.encodeNil()
        }
    }
    
    class JSONCodingKey: CodingKey {
        let key: String
        
        required init?(intValue: Int) {
            return nil
        }
        
        required init?(stringValue: String) {
            key = stringValue
        }
        
        var intValue: Int? {
            return nil
        }
        
        var stringValue: String {
            return key
        }
    }
    
    class JSONAny: Codable {
        
        let value: Any
        
        static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
            let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
            return DecodingError.typeMismatch(JSONAny.self, context)
        }
        
        static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
            let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
            return EncodingError.invalidValue(value, context)
        }
        
        static func decode(from container: SingleValueDecodingContainer) throws -> Any {
            if let value = try? container.decode(Bool.self) {
                return value
            }
            if let value = try? container.decode(Int64.self) {
                return value
            }
            if let value = try? container.decode(Double.self) {
                return value
            }
            if let value = try? container.decode(String.self) {
                return value
            }
            if container.decodeNil() {
                return JSONNull()
            }
            throw decodingError(forCodingPath: container.codingPath)
        }
        
        static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
            if let value = try? container.decode(Bool.self) {
                return value
            }
            if let value = try? container.decode(Int64.self) {
                return value
            }
            if let value = try? container.decode(Double.self) {
                return value
            }
            if let value = try? container.decode(String.self) {
                return value
            }
            if let value = try? container.decodeNil() {
                if value {
                    return JSONNull()
                }
            }
            if var container = try? container.nestedUnkeyedContainer() {
                return try decodeArray(from: &container)
            }
            if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
                return try decodeDictionary(from: &container)
            }
            throw decodingError(forCodingPath: container.codingPath)
        }
        
        static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
            if let value = try? container.decode(Bool.self, forKey: key) {
                return value
            }
            if let value = try? container.decode(Int64.self, forKey: key) {
                return value
            }
            if let value = try? container.decode(Double.self, forKey: key) {
                return value
            }
            if let value = try? container.decode(String.self, forKey: key) {
                return value
            }
            if let value = try? container.decodeNil(forKey: key) {
                if value {
                    return JSONNull()
                }
            }
            if var container = try? container.nestedUnkeyedContainer(forKey: key) {
                return try decodeArray(from: &container)
            }
            if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
                return try decodeDictionary(from: &container)
            }
            throw decodingError(forCodingPath: container.codingPath)
        }
        
        static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
            var arr: [Any] = []
            while !container.isAtEnd {
                let value = try decode(from: &container)
                arr.append(value)
            }
            return arr
        }
        
        static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
            var dict = [String: Any]()
            for key in container.allKeys {
                let value = try decode(from: &container, forKey: key)
                dict[key.stringValue] = value
            }
            return dict
        }
        
        static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
            for value in array {
                if let value = value as? Bool {
                    try container.encode(value)
                } else if let value = value as? Int64 {
                    try container.encode(value)
                } else if let value = value as? Double {
                    try container.encode(value)
                } else if let value = value as? String {
                    try container.encode(value)
                } else if value is JSONNull {
                    try container.encodeNil()
                } else if let value = value as? [Any] {
                    var container = container.nestedUnkeyedContainer()
                    try encode(to: &container, array: value)
                } else if let value = value as? [String: Any] {
                    var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                    try encode(to: &container, dictionary: value)
                } else {
                    throw encodingError(forValue: value, codingPath: container.codingPath)
                }
            }
        }
        
        static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
            for (key, value) in dictionary {
                let key = JSONCodingKey(stringValue: key)!
                if let value = value as? Bool {
                    try container.encode(value, forKey: key)
                } else if let value = value as? Int64 {
                    try container.encode(value, forKey: key)
                } else if let value = value as? Double {
                    try container.encode(value, forKey: key)
                } else if let value = value as? String {
                    try container.encode(value, forKey: key)
                } else if value is JSONNull {
                    try container.encodeNil(forKey: key)
                } else if let value = value as? [Any] {
                    var container = container.nestedUnkeyedContainer(forKey: key)
                    try encode(to: &container, array: value)
                } else if let value = value as? [String: Any] {
                    var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                    try encode(to: &container, dictionary: value)
                } else {
                    throw encodingError(forValue: value, codingPath: container.codingPath)
                }
            }
        }
        
        static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
        
        public required init(from decoder: Decoder) throws {
            if var arrayContainer = try? decoder.unkeyedContainer() {
                self.value = try JSONAny.decodeArray(from: &arrayContainer)
            } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
                self.value = try JSONAny.decodeDictionary(from: &container)
            } else {
                let container = try decoder.singleValueContainer()
                self.value = try JSONAny.decode(from: container)
            }
        }
        
        public func encode(to encoder: Encoder) throws {
            if let arr = self.value as? [Any] {
                var container = encoder.unkeyedContainer()
                try JSONAny.encode(to: &container, array: arr)
            } else if let dict = self.value as? [String: Any] {
                var container = encoder.container(keyedBy: JSONCodingKey.self)
                try JSONAny.encode(to: &container, dictionary: dict)
            } else {
                var container = encoder.singleValueContainer()
                try JSONAny.encode(to: &container, value: self.value)
            }
        }
    }
}

