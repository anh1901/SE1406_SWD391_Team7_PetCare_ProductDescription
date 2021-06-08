// import 'package:petcare/caches/shared_storage.dart';
// import 'package:petcare/config/http_refresh/http_request.dart';
// import 'package:petcare/models/comment_model.dart';
// import 'package:petcare/models/login_info_model.dart';
// import 'package:petcare/models/post_model.dart';
// import 'package:petcare/models/video_model.dart';
// import 'package:petcare/widgets/toast.dart';
//
// class FindRequest {
//   static Future requestPostList(int pageIndex) async {
//     LoginInfo loginInfo = SharedStorage.loginInfo;
//     final url = FindURL.user_selectNotRelation +
//         '?listType=2&pageIndex=$pageIndex&pageSize=10&total=388&userLoginId=${loginInfo.userId}';
//     ResponseData result = await RequestUrl.requestData(url);
//
//     List<PostModel> focus = [];
//     if (result.isSuccess) {
//       if (result.data != null && result.data['records'] != null) {
//         List<dynamic> jsonArr = result.data['records'] ?? [];
//         focus =
//             jsonArr.map<PostModel>((item) => PostModel.fromJson(item)).toList();
//       }
//     } else {
//       Toast.showError(result.message);
//     }
//     return focus;
//   }
//
//   static Future<List<CommentModel>> requestCommentList(
//       int messageId, int pageIndex) async {
//     LoginInfo loginInfo = SharedStorage.loginInfo;
//     final url = FindURL.selectCommentPage +
//         '?messageId=$messageId&pageIndex=$pageIndex&pageSize=10&replySize=5&userId=${loginInfo.userId}&userLoginId=${loginInfo.userId}';
//     final result = await RequestUrl.requestData(url);
//
//     List<CommentModel> comments = [];
//     if (result.isSuccess) {
//       if (result.data != null && result.data['records'] != null) {
//         List<dynamic> jsonArr = result.data['records'] ?? [];
//         for (var json in jsonArr) {
//           Map<String, dynamic> mapJson = json;
//           comments.add(CommentModel.fromJson(mapJson));
//         }
//       }
//     } else {
//       Toast.showError(result.message);
//     }
//     return comments;
//   }
//
//   static Future<bool> requestLike(bool agree,
//       {int messageId, int commentId}) async {
//     LoginInfo loginInfo = SharedStorage.loginInfo;
//     int agreeStatus = agree ? 0 : 1;
//
//     final url = FindURL.updateAgree +
//         '?agreeStatus=$agreeStatus&messageId=$messageId&commentId=$commentId&userId=${loginInfo.userId}';
//     final result = await RequestUrl.requestData(url);
//
//     if (!result.isSuccess) {
//       Toast.showError(result.message);
//     }
//
//     return result.isSuccess;
//   }
//
//   static Future<bool> requestComment(String commentInfo, int messageId) async {
//     LoginInfo loginInfo = SharedStorage.loginInfo;
//
//     final url = FindURL.comment_save;
//     Map<String, dynamic> params = {
//       'commentInfo': commentInfo,
//       'messageId': messageId,
//       'token': loginInfo.token,
//       'userId': loginInfo.userId
//     };
//     final result =
//         await RequestUrl.requestData(url, method: 'post', params: params);
//
//     if (!result.isSuccess) {
//       Toast.showError(result.message);
//     }
//
//     return result.isSuccess;
//   }
//
//   static Future<bool> replyComment(
//       String commentInfo, int commentId, int beReplyedUserId) async {
//     LoginInfo loginInfo = SharedStorage.loginInfo;
//
//     final url = FindURL.comment_reply_save;
//     Map<String, dynamic> params = {
//       'beReplyedUserId': beReplyedUserId,
//       'commentInfo': commentInfo,
//       'commentId': commentId,
//       'token': loginInfo.token,
//       'replyUserId': loginInfo.userId
//     };
//     final result =
//         await RequestUrl.requestData(url, method: 'post', params: params);
//
//     if (!result.isSuccess) {
//       Toast.showError(result.message);
//     }
//
//     return result.isSuccess;
//   }
//
//   static Future<bool> deleteComment(int commentId) async {
//     LoginInfo loginInfo = SharedStorage.loginInfo;
//
//     final url = FindURL.comment_delete +
//         '?commentId=35327&userLoginId=${loginInfo.userId}';
//     final result = await RequestUrl.requestData(url);
//
//     Toast.showToast(result.message);
//
//     return result.isSuccess;
//   }
//
//   static Future<List<VideoModel>> requestVideoList(
//       int messageId, int pageIndex) async {
//     LoginInfo loginInfo = SharedStorage.loginInfo;
//     final url = FindURL.selectCurrentVideoPage +
//         '?messageId=$messageId&orderColumn=create_time&pageIndex=$pageIndex&pageSize=10&userLoginId=${loginInfo.userId}';
//     final result = await RequestUrl.requestData(url);
//
//     List<VideoModel> videos = [];
//     if (result.isSuccess) {
//       List<dynamic> jsonArr = result.data ?? [];
//       for (var json in jsonArr) {
//         Map<String, dynamic> mapJson = json;
//         videos.add(VideoModel.fromJson(mapJson));
//       }
//     } else {
//       Toast.showError(result.message);
//     }
//     return videos;
//   }
//
//   static Future<bool> requestFocus(bool attation, int userByid) async {
//     LoginInfo loginInfo = SharedStorage.loginInfo;
//     int isFlag = attation ? 0 : 1;
//
//     final url = FindURL.updateAttation +
//         '?isFlag=$isFlag&userByid=$userByid&userId=${loginInfo.userId}';
//     ResponseData result = await RequestUrl.requestData(url);
//
//     if (!result.isSuccess) {
//       Toast.showToast(result.message);
//     }
//
//     return result.isSuccess;
//   }
// }
