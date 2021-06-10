import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:highlighter_coachmark/highlighter_coachmark.dart';
import 'package:page_transition/page_transition.dart';
import 'package:petcare/caches/shared_storage.dart';
import 'package:petcare/redux/redux_state.dart';
import 'package:petcare/screens/pets_screen/components/pet_services.dart';
import 'package:petcare/widgets/commons.dart';
import 'package:petcare/widgets/custom_text.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'components/add_appointment/map_screen.dart';
import 'components/pet_appointment.dart';
import 'components/pet_list.dart';
import 'create_pet.dart';

class PetsScreen extends StatefulWidget {
  const PetsScreen({Key key}) : super(key: key);

  @override
  _PetsScreenState createState() => _PetsScreenState();
}

class _PetsScreenState extends State<PetsScreen> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final isTutorial = SharedStorage.showTutorial;
  GlobalKey _appointmentKey = GlobalObjectKey("appointmentKey");
  GlobalKey _petsKey = GlobalObjectKey("petKey");
  @override
  void initState() {
    super.initState();
    _loadCoachMark();
  }

  Future<void> _loadCoachMark() async {
    Timer(Duration(seconds: 1), () => showCoachMarkApppointment());
  }

  void showCoachMarkApppointment() {
    CoachMark coachMarkFAB = CoachMark();
    RenderBox target = _appointmentKey.currentContext.findRenderObject();
    Rect markRect = target.localToGlobal(Offset.zero) & target.size;
    markRect = Rect.fromCircle(
        center: markRect.center, radius: markRect.longestSide * 0.6);

    coachMarkFAB.show(
        targetContext: _appointmentKey.currentContext,
        markRect: markRect,
        children: [
          Center(
              child: Text("Tap to add\na new appointment",
                  style: const TextStyle(
                    fontSize: 24.0,
                    fontStyle: FontStyle.italic,
                    color: Colors.white,
                  )))
        ],
        duration: Duration(seconds: 3),
        onClose: () {
          Timer(Duration(seconds: 1), () => showCoachMarkPet());
        });
  }

  void showCoachMarkPet() {
    CoachMark coachMarkTile = CoachMark();
    RenderBox target = _petsKey.currentContext.findRenderObject();

    Rect markRect = target.localToGlobal(Offset.zero) & target.size;
    markRect = markRect.inflate(5.0);

    coachMarkTile.show(
        targetContext: _appointmentKey.currentContext,
        markRect: markRect,
        markShape: BoxShape.rectangle,
        children: [
          Positioned(
              top: markRect.bottom + 15.0,
              right: 5.0,
              child: Text("Tap on button\nto add a pet",
                  style: const TextStyle(
                    fontSize: 24.0,
                    fontStyle: FontStyle.italic,
                    color: Colors.white,
                  )))
        ],
        duration: Duration(seconds: 3),
        onClose: () {
          SharedStorage.saveShowTutorial();
        });
  }

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<ReduxState>(builder: (context, store) {
      return Scaffold(
        body: SafeArea(
          child: ListView(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 45.0, top: 10.0),
                    child: Row(
                      children: [
                        Text(
                          AppLocalizations.of(context).hello,
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          " User",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.blue[200],
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 12),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: CustomText(
                        text: AppLocalizations.of(context).petsScreenTitle,
                        size: 18,
                        color: ColorStyles.color_666666,
                      ),
                    ),
                  ),
                ],
              ),
              PetServicesList(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 12),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Row(
                        children: [
                          CustomText(
                            text: AppLocalizations.of(context).petsAppointment,
                            size: 22,
                            color: ColorStyles.color_1a1a1a,
                          ),
                          CustomText(
                            text: " (${appointmentList.length})",
                            size: 18,
                            color: ColorStyles.color_1a1a1a,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    key: isTutorial ? null : _appointmentKey,
                    padding: const EdgeInsets.only(top: 10, right: 12),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.bottomToTop,
                                child: MapScreen()));
                      },
                      child: Icon(
                        Icons.add_circle,
                        size: 40,
                        color: ColorStyles.main_color,
                      ),
                    ),
                  ),
                ],
              ),
              PetAppointment(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 12),
                    child: CustomText(
                      text: AppLocalizations.of(context).myPets,
                      size: 22,
                      color: ColorStyles.color_1a1a1a,
                    ),
                  ),
                  Padding(
                    key: isTutorial ? null : _petsKey,
                    padding: const EdgeInsets.only(top: 10, right: 12),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.bottomToTop,
                                child: CreatePetScreen()));
                      },
                      child: Icon(
                        Icons.add_circle,
                        size: 40,
                        color: ColorStyles.main_color,
                      ),
                    ),
                  ),
                ],
              ),
              PetList(),
            ],
          ),
        ),
      );
    });
  }
}
