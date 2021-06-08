import 'dart:convert';

CommentModel commentModelFromJson(String str) =>
    CommentModel.fromJson(json.decode(str));

String commentModelToJson(CommentModel data) => json.encode(data.toJson());

class CommentModel {
  CommentModel({
    this.commentId,
    this.commentInfo,
    this.userId,
    this.nickname,
    this.headImg,
    this.replySize,
    this.publishTime,
    this.noReply,
    this.userLoginId,
    this.commentReplyVOs,
    this.petDays,
    this.authorUserId,
    this.noLike,
    this.likeStatus,
  });

  int commentId;
  String commentInfo;
  int userId;
  String nickname;
  String headImg;
  int replySize;
  String publishTime;
  int noReply;
  int userLoginId;
  List<CommentReplyVo> commentReplyVOs;
  String petDays;
  int authorUserId;
  int noLike;
  String likeStatus;

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
        commentId: json["commentId"] ?? 0,
        commentInfo: json["commentInfo"] ?? '',
        userId: json["userId"] ?? 0,
        nickname: json["nickname"] ?? '',
        headImg: json["headImg"] ?? '',
        replySize: json["replySize"] ?? 0,
        publishTime: json["publishTime"] ?? '',
        noReply: json["noReply"] ?? 0,
        userLoginId: json["userLoginId"] ?? 0,
        commentReplyVOs: List<CommentReplyVo>.from(
                (json["commentReplyVOs"] ?? [])
                    .map((x) => CommentReplyVo.fromJson(x))) ??
            [],
        petDays: json["petDays"] ?? '',
        authorUserId: json["authorUserId"] ?? 0,
        noLike: json["noLike"] ?? 0,
        likeStatus: json["likeStatus"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "commentId": commentId,
        "commentInfo": commentInfo,
        "userId": userId,
        "nickname": nickname,
        "headImg": headImg,
        "replySize": replySize,
        "publishTime": publishTime,
        "cntReply": noReply,
        "userLoginId": userLoginId,
        "commentReplyVOs":
            List<dynamic>.from(commentReplyVOs.map((x) => x.toJson())),
        "petDays": petDays,
        "authorUserId": authorUserId,
        "cntAgree": noLike,
        "likeStatus": likeStatus,
      };
}

class CommentReplyVo {
  CommentReplyVo({
    this.userId,
    this.replyUserId,
    this.replyNickname,
    this.commentInfo,
    this.replyId,
    this.headImg,
    this.nickname,
    this.atusers,
    this.replyPublishTime,
  });

  int userId;
  int replyUserId;
  String replyNickname;
  String commentInfo;
  int replyId;
  String headImg;
  String nickname;
  List<dynamic> atusers;
  String replyPublishTime;

  factory CommentReplyVo.fromJson(Map<String, dynamic> json) => CommentReplyVo(
        userId: json["userId"],
        replyUserId: json["replyUserId"],
        replyNickname: json["replyNickname"],
        commentInfo: json["commentInfo"],
        replyId: json["replyId"],
        headImg: json["headImg"],
        nickname: json["nickname"],
        atusers: List<dynamic>.from(json["atusers"].map((x) => x)),
        replyPublishTime: json["replyPublishTime"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "replyUserId": replyUserId,
        "replyNickname": replyNickname,
        "commentInfo": commentInfo,
        "replyId": replyId,
        "headImg": headImg,
        "nickname": nickname,
        "atusers": List<dynamic>.from(atusers.map((x) => x)),
        "replyPublishTime": replyPublishTime,
      };
}
