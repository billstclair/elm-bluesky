----------------------------------------------------------------------
--
-- Entities.elm
-- Mastodon API entities.
-- Copyright (c) 2019 Bill St. Clair <billstclair@gmail.com>
-- Some rights reserved.
-- Distributed under the MIT License
-- See LICENSE
--
----------------------------------------------------------------------


module Mastodon.Entities exposing
    ( Entity(..)
    , Datetime, UrlString, HtmlString, ISO6391, UnixTimestamp
    , Account, Source, Token, Application, Attachment
    , Meta, Card, Context, Error, Filter, Instance
    , URLs, Stats, ListEntity, Mention, Notification, Poll
    , PushSubscription, Relationship, Results
    , Status, ScheduledStatus, Tag, History, Conversation
    , Emoji, Field, AttachmentType(..), MetaInfo(..), Focus, CardType(..)
    , FilterContext(..), NotificationType(..), PollOption
    , Visibility(..), StatusParams
    , WrappedAccount(..), WrappedStatus(..)
    )

{-| The Mastodon API entities.

These are JSON-encoded over the wire. Mastodon.EncodeDecode knows how to do that.

Documented at <https://docs.joinmastodon.org/api/entities/>

Each of the Entities has a `v` field, which is the raw JS value from
which it was decoded. This is useful if you want to display what you
got over the wire. Code that creates these can set it to
`Json.Encode.null`.


## Entity

@docs Entity


## String aliases

@docs Datetime, UrlString, HtmlString, ISO6391, UnixTimestamp


## Entities

@docs Account, Source, Token, Application, Attachment
@docs Meta, Card, Context, Error, Filter, Instance
@docs URLs, Stats, ListEntity, Mention, Notification, Poll
@docs PushSubscription, Relationship, Results
@docs Status, ScheduledStatus, Tag, History, Conversation


## Entity field types

@docs Emoji, Field, AttachmentType, MetaInfo, Focus, CardType
@docs FilterContext, NotificationType, PollOption
@docs Visibility, StatusParams


## Wrappers to prevent type recursion

@docs WrappedAccount, WrappedStatus

-}

import Json.Encode as JE exposing (Value)


{-| Alias of `String`
-}
type alias Datetime =
    String


{-| Alias of `String`
-}
type alias UrlString =
    String


{-| Alias of `String`
-}
type alias HtmlString =
    String


{-| Alias of `String`
-}
type alias ISO6391 =
    String


{-| Alias of `String`
-}
type alias UnixTimestamp =
    String


{-| Account entity
-}
type alias Account =
    { id : String
    , username : String
    , acct : String
    , display_name : String
    , locked : Bool
    , created_at : Datetime
    , followers_count : Int
    , following_count : Int
    , statuses_count : Int
    , note : String
    , url : UrlString
    , avatar : UrlString
    , avatar_static : UrlString
    , header : UrlString
    , header_static : UrlString
    , emojis : List Emoji
    , moved : Maybe WrappedAccount
    , fields : List Field
    , bot : Bool
    , v : Value
    }


{-| Wrapped `Account`, to prevent type recursion.
-}
type WrappedAccount
    = WrappedAccount Account


{-| Values for the `Account.fields` and `Source.fields` lists.
-}
type alias Field =
    { name : String
    , value : HtmlString
    , verified_at : Maybe Datetime
    }


{-| Source entity.
-}
type alias Source =
    { privacy : String
    , sensitive : Bool
    , language : ISO6391
    , note : String
    , fields : List Field
    , v : Value
    }


{-| Token entity.
-}
type alias Token =
    { access_token : String
    , token_type : String
    , scope : String
    , created_at : Int
    , v : Value
    }


{-| Application entity.
-}
type alias Application =
    { name : String
    , website : Maybe UrlString
    , v : Value
    }


{-| Attachment entity.
-}
type alias Attachment =
    { id : String
    , type_ : AttachmentType
    , url : UrlString
    , remote_url : Maybe UrlString
    , preview_url : UrlString
    , text_url : Maybe UrlString
    , meta : Maybe Meta
    , description : String
    , v : Value
    }


{-| The types for the `Attachment.type_` field.
-}
type AttachmentType
    = UnknownAttachment
    | ImageAttachment
    | GifvAttachment
    | VideoAttachment


{-| Meta entity.
-}
type alias Meta =
    { small : Maybe MetaInfo
    , original : Maybe MetaInfo
    , focus : Maybe Focus
    , v : Value
    }


{-| Possibilities for the `Meta` fields.
-}
type MetaInfo
    = ImageMeta
        { width : Maybe Int
        , height : Maybe Int
        , size : Maybe Int
        , aspect : Maybe Float
        }
    | VideoMeta
        { width : Maybe Int
        , height : Maybe Int
        , frame_rate : Maybe Int
        , duration : Maybe Float
        , bitrate : Maybe Int
        }


{-| The optional focus of an image attachment.
-}
type alias Focus =
    { x : Float
    , y : Float
    }


{-| Card entity.
-}
type alias Card =
    { url : UrlString
    , title : String
    , description : String
    , image : Maybe UrlString
    , type_ : CardType
    , author_name : Maybe String
    , author_url : Maybe UrlString
    , provider_name : Maybe String
    , provider_url : Maybe UrlString
    , html : Maybe HtmlString
    , width : Maybe Int
    , height : Maybe Int
    , v : Value
    }


{-| Choices for the `Card.type_` field.
-}
type CardType
    = LinkCard
    | PhotoCard
    | VideoCard
    | RichCard


{-| Context entity.
-}
type alias Context =
    { ancestors : List Status
    , descendents : List Status
    , v : Value
    }


{-| Values for the `Account.emojis` list.
-}
type alias Emoji =
    { shortcode : String
    , static_url : UrlString
    , url : UrlString
    , visible_in_picker : Bool
    }


{-| Error entity.
-}
type alias Error =
    { error : String
    , v : Value
    }


{-| Filter entity.
-}
type alias Filter =
    { id : String
    , phrase : String
    , context : List Context
    , expires_at : Datetime
    , irreversible : Bool
    , whole_word : Bool
    , v : Value
    }


{-| Choices for the `Filter.context` list.
-}
type FilterContext
    = HomeContext
    | NotificationsContext
    | PublicContext
    | ThreadContext


{-| Instance entity.
-}
type alias Instance =
    { uri : String
    , title : String
    , description : String
    , email : String
    , version : String
    , thumbnail : Maybe UrlString
    , urls : Maybe URLs
    , stats : Stats
    , languages : List ISO6391
    , contact_account : Maybe Account
    , v : Value
    }


{-| Value of `Instance.urls`.
-}
type alias URLs =
    { streaming_api : UrlString
    }


{-| Stats entity.
-}
type alias Stats =
    { user_count : Int
    , status_count : Int
    , domain_count : Int
    , v : Value
    }


{-| List entity.
-}
type alias ListEntity =
    { id : String
    , title : String
    , v : Value
    }


{-| Mention entity.
-}
type alias Mention =
    { url : UrlString
    , username : String
    , acct : String
    , id : String
    , v : Value
    }


{-| Notification entity.
-}
type alias Notification =
    { id : String
    , type_ : NotificationType
    , created_at : Datetime
    , account : Account
    , status : Maybe Status
    , v : Value
    }


{-| Choices for `Notification.type_`.
-}
type NotificationType
    = FollowNotification
    | MentionNotification
    | ReblogNotification
    | FavouriteNotification


{-| Poll entity.
-}
type alias Poll =
    { id : String
    , expires_at : Maybe Datetime
    , expired : Bool
    , multiple : Bool
    , votes_count : Int
    , options : List PollOption
    , voted : Bool
    , v : Value
    }


{-| Elements of the `Poll.options` list.
-}
type alias PollOption =
    { title : String
    , votes_count : Maybe Int
    }


{-| Push subscription entity.
-}
type alias PushSubscription =
    { id : String
    , endpoint : UrlString
    , server_key : String
    , alerts : Value --not documented
    , v : Value
    }


{-| Relationship entity.
-}
type alias Relationship =
    { id : String
    , following : Bool
    , followed_by : Bool
    , blocking : Bool
    , muting : Bool
    , muting_notifications : Bool
    , requested : Bool
    , domain_blocking : Bool
    , showing_reblogs : Bool
    , endorsed : Bool
    , v : Value
    }


{-| Results entity.
-}
type alias Results =
    { accounts : List Account
    , statuses : List Status
    , hashtags : List Tag
    , v : Value
    }


{-| Status entity.
-}
type alias Status =
    { id : String
    , uri : String
    , url : Maybe UrlString
    , account : Account
    , in_reply_to_id : Maybe String
    , in_reply_to_account_id : Maybe String
    , reblog : Maybe WrappedStatus
    , content : HtmlString
    , created_at : Datetime
    , emojis : List Emoji
    , replies_count : Int
    , reblogs_count : Int
    , favourites_count : Int
    , reblogged : Bool
    , favourited : Bool
    , muted : Bool
    , sensitive : Bool
    , spoiler_text : String
    , visibility : Visibility
    , media_attachments : List Attachment
    , mentions : List Mention
    , tags : List Tag
    , card : Maybe Card
    , poll : Maybe Poll
    , application : Application
    , language : Maybe String
    , pinned : Bool
    , v : Value
    }


{-| Wrapped `Status`, to prevent type recursion.
-}
type WrappedStatus
    = WrappedStatus Status


{-| Values for `Status.visibility`.
-}
type Visibility
    = PublicVisibility
    | UnlistedVisibility
    | PrivateVisibility
    | DirectVisibility


{-| ScheduledStatus entity.
-}
type alias ScheduledStatus =
    { id : String
    , scheduled_at : Datetime
    , params : List StatusParams
    , media_attachments : List Attachment
    , v : Value
    }


{-| Elements of `ScheduledStatus.params`.
-}
type alias StatusParams =
    { text : String
    , in_reply_to_id : Maybe String
    , media_ids : List String
    , sensitive : Bool
    , spoiler_text : Maybe String
    , visibility : Visibility
    , scheduled_at : Maybe Datetime
    , application_id : String
    }


{-| Tag entity.
-}
type alias Tag =
    { name : String
    , url : UrlString
    , history : List History
    , v : Value
    }


{-| History entity.
-}
type alias History =
    { day : UnixTimestamp
    , uses : Int
    , accounts : Int
    , v : Value
    }


{-| Conversation entity.
-}
type alias Conversation =
    { id : String
    , accounts : List Account
    , last_status : Maybe Status
    , unread : Bool
    , v : Value
    }


{-| One type to rule them all.

This is mostly to make tests easier to define. Most code will use
individual entities explicitly.

-}
type Entity
    = AccountEntity Account
    | SourceEntity Source
    | TokenEntity Token
    | ApplicationEntity Application
    | AttachmentEntity Attachment
    | MetaEntity Meta
    | CardEntity Card
    | ContextEntity Context
    | ErrorEntity Error
    | FilterEntity Filter
    | InstanceEntity Instance
    | StatsEntity Stats
    | ListEntityEntity ListEntity
    | MentionEntity Mention
    | NotificationEntity Notification
    | PollEntity Poll
    | PushSubscriptionEntity PushSubscription
    | RelationshipEntity Relationship
    | ResultsEntity Results
    | StatusEntity Status
    | ScheduledStatusEntity ScheduledStatus
    | TagEntity Tag
    | HistoryEntity History
    | ConversationEntity Conversation
