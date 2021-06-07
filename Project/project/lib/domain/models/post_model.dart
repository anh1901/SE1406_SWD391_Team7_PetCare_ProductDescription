// PostModel postModelFromJson(String str) => PostModel.fromJson(json.decode(str));
//
// String postModelToJson(PostModel data) => json.encode(data.toJson());

import 'comment_model.dart';

class PostList {
  List<PostModel> postList;
  PostList({this.postList});
  factory PostList.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['posts'] as List;
    List<PostModel> postList = list.map((i) => PostModel.fromJson(i)).toList();
    // print(postList);
    return new PostList(
      postList: postList,
    );
  }
}

class PostModel {
  int postId;
  int userId;
  String messageType;
  String messageInfo;
  int noComment;
  int noLike;
  int noRead;
  int fileCount;
  String location;
  String followStatus;
  String isSelf;
  String likeStatus;
  String createTime;
  String time;
  List<FileList> fileList;
  UserInfo userInfo;
  TagLabel tagLabel;
  List<CommentModel> commentList;
  PostModel({
    this.postId,
    this.userId,
    this.messageType,
    this.messageInfo,
    this.noComment,
    this.noLike,
    this.noRead,
    this.fileCount,
    this.followStatus,
    this.isSelf,
    this.likeStatus,
    this.createTime,
    this.time,
    this.fileList,
    this.userInfo,
    this.location,
    this.tagLabel,
    this.commentList,
  });
  factory PostModel.fromJson(Map<String, dynamic> json) {
    return new PostModel(
      postId: json["postId"],
      userId: json["userId"],
      messageType: json["messageType"],
      messageInfo: json["messageInfo"],
      noComment: json["noComment"],
      noLike: json["noLike"],
      noRead: json["noRead"],
      fileCount: json["fileCount"],
      followStatus: json["followStatus"],
      isSelf: json["isSelf"],
      likeStatus: json["likeStatus"],
      createTime: json["createTime"],
      time: json["time"],
      location: json["location"],
      fileList: List<FileList>.from(
          json["fileList"].map((x) => FileList.fromJson(x))),
      userInfo: UserInfo.fromJson(json["userInfo"]),
      tagLabel: TagLabel.fromJson(json["tagLabel"] ?? {}),
      commentList: List<CommentModel>.from(
          json["commentList"].map((x) => CommentModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "postId": postId,
        "userId": userId,
        "messageType": messageType,
        "messageInfo": messageInfo,
        "noComment": noComment,
        "noLike": noLike,
        "noRead": noRead,
        "fileCount": fileCount,
        "followStatus": followStatus,
        "isSelf": isSelf,
        "likeStatus": likeStatus,
        "createTime": createTime,
        "time": time,
        "location": location,
        "fileList": List<dynamic>.from(fileList.map((x) => x.toJson())),
        "userInfo": userInfo.toJson(),
        "tagLabel": tagLabel.toJson(),
        "commentList": List<dynamic>.from(commentList.map((x) => x.toJson())),
      };
}

class FileList {
  int fileId;
  String fileUrl;
  String fileType;
  int height;
  int width;
  FileList({
    this.fileId,
    this.fileUrl,
    this.fileType,
    this.height,
    this.width,
  });

  factory FileList.fromJson(Map<String, dynamic> json) => FileList(
        fileId: json["fileId"],
        fileUrl: json["fileUrl"],
        fileType: json["fileType"],
        height: json["height"],
        width: json["width"],
      );

  Map<String, dynamic> toJson() => {
        "fileId": fileId,
        "fileUrl": fileUrl,
        "fileType": fileType,
        "height": height,
        "width": width,
      };
}

class TagLabel {
  int tagId;
  String tagName;

  TagLabel({
    this.tagId,
    this.tagName,
  });
  factory TagLabel.fromJson(Map<String, dynamic> json) => TagLabel(
        tagId: json["tagId"] ?? 0,
        tagName: json["tagName"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "tagId": tagId,
        "tagName": tagName,
      };
}

class UserInfo {
  int userId;
  String avatarImg;
  String nickname;
  String city;
  UserInfo({this.userId, this.avatarImg, this.nickname, this.city});
  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        userId: json["userId"],
        avatarImg: json["avatarImg"],
        nickname: json["nickname"],
        city: json["city"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "avatarImg": avatarImg,
        "nickname": nickname,
        'city': city
      };
}
