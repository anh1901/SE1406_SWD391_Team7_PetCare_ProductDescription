import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:page_transition/page_transition.dart';
import 'package:petcare/redux/redux_state.dart';
import 'package:petcare/screens/pets_screen/components/pet_services.dart';
import 'package:petcare/widgets/commons.dart';
import 'package:petcare/widgets/custom_text.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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
  @override
  void initState() {
    super.initState();
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
