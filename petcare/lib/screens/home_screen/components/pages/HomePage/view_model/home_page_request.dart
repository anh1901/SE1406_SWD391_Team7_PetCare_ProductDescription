class FindRequest {
  static Future requestPostList(int pageIndex) async {
    // LoginInfo loginInfo = SharedStorage.loginInfo;
    // // final url = FindURL.user_selectNotRelation +
    // //     '?listType=2&pageIndex=$pageIndex&pageSize=10&total=388&userLoginId=${loginInfo.userId}';
    // ResponseData result = await RequestUrl.requestData(url);
    //
    // List<PostModel> focus = [];
    // if (result.isSuccess) {
    //   if (result.data != null && result.data['records'] != null) {
    //     List<dynamic> jsonArr = result.data['records'] ?? [];
    //     focus =
    //         jsonArr.map<PostModel>((item) => PostModel.fromJson(item)).toList();
    //   }
    // } else {
    //   Toast.showError(result.message);
    // }
    // return focus;
  }
}
