import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:petcare/models/events_model.dart';
import 'package:petcare/redux/redux_state.dart';
import 'package:petcare/widgets/app_size.dart';
import 'package:petcare/widgets/commons.dart';
import 'package:petcare/widgets/custom_text.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'components/event_screen_title.dart';

List<EventModel> eventList = [
  EventModel(
      sender: "System",
      time: "9:00 AM",
      date: "20 January 2022",
      message: "You have an appointment. Check your pet health everyday."),
  EventModel(
      sender: "System",
      time: "12:30 PM",
      date: "25 January 2022",
      message: "The discount start in 24h."),
  EventModel(
      sender: "Store 1",
      time: "12:30 PM",
      date: "25 January 2022",
      message: "Food sale is on the line."),
];

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key key}) : super(key: key);

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  Widget build(BuildContext context) {
    return StoreBuilder<ReduxState>(builder: (context, store) {
      return Scaffold(
        body: SafeArea(
          child: SmartRefresher(
            controller: _refreshController,
            enablePullDown: true,
            enablePullUp: false,
            onRefresh: () async {
              setState(() {
                //
              });
            },
            child: ListView(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: title,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 12),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: CustomText(
                          text: "Check out new event.",
                          size: 18,
                          color: ColorStyles.color_666666,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 12),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: CustomText(
                          text: "Latest",
                          size: 20,
                          color: ColorStyles.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                //
                Container(
                  height: SizeFit.screenHeight / 10,
                  width: SizeFit.screenWidth * 0.95,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: 1,
                    itemBuilder: (_, index) {
                      if (eventList.length == 0) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            alignment: Alignment.center,
                            child: CustomText(
                                text: "You have no event yet.",
                                size: 22,
                                color: Colors.grey),
                          ),
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            decoration:
                                BoxDecoration(color: Colors.lightBlue[100]),
                            child: Column(
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    //view events
                                  }, //view pet detail
                                  child: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 5.0),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                CustomText(
                                                  text:
                                                      "${eventList[index].sender} ",
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                Container(
                                                  constraints:
                                                      new BoxConstraints(
                                                          maxWidth: SizeFit
                                                                  .screenWidth *
                                                              0.7),
                                                  child: CustomText(
                                                      text:
                                                          "${eventList[index].message}"),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              CustomText(
                                                text:
                                                    "${eventList[index].date} ",
                                                color: Colors.grey,
                                                size: 12,
                                              ),
                                              CustomText(
                                                text:
                                                    "${eventList[index].time}.",
                                                color: Colors.grey,
                                                size: 12,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 12),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: CustomText(
                          text: "Older",
                          size: 20,
                          color: ColorStyles.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: SizeFit.screenHeight * 0.6,
                  width: SizeFit.screenWidth * 0.95,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: eventList.length - 1,
                    itemBuilder: (_, index) {
                      if (eventList.length == 0) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            alignment: Alignment.center,
                            child: CustomText(
                                text: "You have no new event yet.",
                                size: 22,
                                color: Colors.grey),
                          ),
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            decoration:
                                BoxDecoration(color: Colors.lightBlue[100]),
                            child: Column(
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    //view events
                                  }, //view pet detail
                                  child: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 5.0),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                CustomText(
                                                  text:
                                                      "${eventList[index + 1].sender} ",
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                Container(
                                                  constraints:
                                                      new BoxConstraints(
                                                          maxWidth: SizeFit
                                                                  .screenWidth *
                                                              0.7),
                                                  child: CustomText(
                                                      text:
                                                          "${eventList[index + 1].message}"),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              CustomText(
                                                text:
                                                    "${eventList[index + 1].date} ",
                                                color: Colors.grey,
                                                size: 12,
                                              ),
                                              CustomText(
                                                text:
                                                    "${eventList[index + 1].time}.",
                                                color: Colors.grey,
                                                size: 12,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
