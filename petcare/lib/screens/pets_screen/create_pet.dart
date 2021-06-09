import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cupertino_radio_choice/cupertino_radio_choice.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petcare/models/pet_model.dart';
import 'package:petcare/widgets/app_size.dart';
import 'package:petcare/widgets/commons.dart';
import 'package:petcare/widgets/custom_text.dart';
import 'package:petcare/widgets/toast.dart';
import 'package:video_player/video_player.dart';

List<String> types = ["Dog", "Cat", "Rabbit", "Bird"];
final Map<String, String> genderMap = {
  'Male': 'Male',
  'Female': 'Female',
};
final FirebaseAuth auth = FirebaseAuth.instance;
final User user = auth.currentUser;
final uid = (user == null) ? "YA0MCREEIsG4U8bUtyXQ" : user.uid;

class CreatePetScreen extends StatefulWidget {
  const CreatePetScreen({Key key}) : super(key: key);
  @override
  _CreatePetScreenState createState() => _CreatePetScreenState();
}

class _CreatePetScreenState extends State<CreatePetScreen> {
  DateTime today = DateTime.now();
  File image;
  String fileName;
  PickedFile _imageFile;
  String uploadUrl;
  dynamic _pickImageError;
  bool isVideo = false;
  String _selectedType;
  String _selectedGender = genderMap.keys.first;
  String petName, petBreed, description, birthday;
  double weight;
  final ImagePicker _picker = ImagePicker();
  final TextEditingController maxWidthController = TextEditingController();
  final TextEditingController maxHeightController = TextEditingController();
  final TextEditingController qualityController = TextEditingController();
  FirebaseStorage storage = FirebaseStorage.instance;
  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: today,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != today)
      setState(() {
        today = picked;
        birthday = picked as String;
      });
  }

  void onGenderSelected(String genderKey) {
    setState(() {
      _selectedGender = genderKey;
    });
  }

  getPetName(String name) {
    this.petName = name;
  }

  getPetDescription(String description) {
    this.description = description;
  }

  getPetWeight(String weight) {
    this.weight = double.parse(weight);
  }

  getBreed(String breed) {
    this.petBreed = breed;
  }

  createPet() {
    addPet();
    Toast.showSuccess(AppLocalizations.of(context).addPetSuccess);
    Navigator.of(context).pop();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    maxWidthController.dispose();
    maxHeightController.dispose();
    qualityController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key('createPet'),
      direction: DismissDirection.down,
      onDismissed: (_) => Navigator.pop(context),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xFDDAE4E7),
        body: SafeArea(
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 50),
                child: CustomText(
                  text: AppLocalizations.of(context).addPetTitle,
                  size: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: CustomText(
                  text: AppLocalizations.of(context).addPetQuestion,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: SizeFit.screenHeight / 5.5,
                        width: SizeFit.screenWidth,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/background.png"),
                              fit: BoxFit.none,
                            ),
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blue[50],
                                offset: Offset(4, 6),
                                blurRadius: 20,
                              ),
                            ]),
                        padding: EdgeInsets.only(top: 8),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      _onImageButtonPressed(ImageSource.gallery,
                                          context: context);
                                    },
                                    child: Image.asset(
                                      "assets/images/gallery.png",
                                      width: 80,
                                      height: 80,
                                    ),
                                  ),
                                  CustomText(
                                      text: AppLocalizations.of(context)
                                          .fromGallery,
                                      size: 20),
                                ],
                              ),
                              Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      _onImageButtonPressed(ImageSource.camera,
                                          context: context);
                                    },
                                    child: Image.asset(
                                      "assets/images/camera.png",
                                      width: 80,
                                      height: 80,
                                    ),
                                  ),
                                  CustomText(
                                      text: AppLocalizations.of(context)
                                          .fromCamera,
                                      size: 20),
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
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: _imageFile != null
                    ? Row(
                        children: [
                          SizedBox(
                              height: 100,
                              width: 100,
                              child: Image.file(image)),
                          SizedBox(
                              height: 100,
                              width: SizeFit.screenWidth * 0.7,
                              child: CustomText(
                                  text: "Chosen an image from $image")),
                        ],
                      )
                    : CustomText(text: AppLocalizations.of(context).noPetImage),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomText(
                  text: AppLocalizations.of(context).petName,
                  size: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context).name,
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.0),
                    ),
                  ),
                  onChanged: (String name) {
                    getPetName(name);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomText(
                  text: AppLocalizations.of(context).petType,
                  size: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton(
                  isExpanded: true,
                  hint: Text(AppLocalizations.of(context).petTypeLabel),
                  value: _selectedType,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedType = newValue;
                    });
                  },
                  items: types.map((location) {
                    return DropdownMenuItem(
                      child: new Text(location),
                      value: location,
                    );
                  }).toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomText(
                  text: AppLocalizations.of(context).breed,
                  size: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context).breed,
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.0),
                    ),
                  ),
                  onChanged: (String breed) {
                    getBreed(breed);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomText(
                  text: AppLocalizations.of(context).weight,
                  size: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context).weight,
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.0),
                    ),
                  ),
                  onChanged: (String weight) {
                    getPetWeight(weight);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomText(
                  text: AppLocalizations.of(context).description,
                  size: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context).description,
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.0),
                    ),
                  ),
                  onChanged: (String description) {
                    getPetDescription(description);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomText(
                  text: AppLocalizations.of(context).birthday,
                  size: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(color: Colors.white),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomText(
                            text: "${today.toLocal()}".split(' ')[0],
                            color: Colors.grey),
                      ),
                    ),
                    RaisedButton(
                      onPressed: () => _selectDate(context),
                      child: Icon(Icons.today),
                      color: Colors.cyanAccent,
                    ),
                  ],
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Container(
              //     height: 200,
              //     child: CupertinoDatePicker(
              //       mode: CupertinoDatePickerMode.date,
              //       initialDateTime: DateTime(1969, 1, 1),
              //       onDateTimeChanged: (DateTime newDateTime) {
              //         birthday = DateFormat('yyyy-MM-dd').format(newDateTime);
              //       },
              //     ),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomText(
                  text: AppLocalizations.of(context).gender,
                  size: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CupertinoRadioChoice(
                        choices: genderMap,
                        onChange: onGenderSelected,
                        initialKeyValue: _selectedGender,
                        selectedColor: Colors.lightBlueAccent,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(30.0),
                  color: ColorStyles.main_color,
                  child: MaterialButton(
                    minWidth: SizeFit.screenWidth,
                    padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    onPressed: () {
                      createPet();
                    },
                    child: CustomText(
                        text: AppLocalizations.of(context).addPetButton,
                        size: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final petRef = FirebaseFirestore.instance
      .collection('users/$uid/pets')
      .withConverter<PetModel>(
        fromFirestore: (snapshot, _) => PetModel.fromJson(snapshot.data()),
        toFirestore: (pet, _) => pet.toJson(),
      );
  Future<void> _upload() async {
    try {
      await storage.ref(fileName).putFile(
          image,
          SettableMetadata(customMetadata: {
            'uploaded_by': uid,
            'description': 'Upload by $uid'
          }));
      uploadUrl = await storage.ref(fileName).getDownloadURL();
      // setState(() {});
    } on FirebaseException catch (error) {}
  }

  Future<void> addPet() async {
    //upload image
    await _upload();
    // Add a pet
    await petRef.add(
      PetModel(
        petImg: uploadUrl,
        petName: petName,
        petBreed: petBreed,
        sex: _selectedGender,
        birthday: birthday,
        petWeight: weight.toString(),
        type: _selectedType,
        description: description,
      ),
    );
  }

  void _onImageButtonPressed(ImageSource source, {BuildContext context}) async {
    await _displayPickImageDialog(context,
        (double maxWidth, double maxHeight, int quality) async {
      try {
        final pickedFile = await _picker.getImage(
          source: source,
          maxWidth: maxWidth,
          maxHeight: maxHeight,
          imageQuality: quality,
        );
        setState(() {
          _imageFile = pickedFile;
          fileName = _imageFile.path.split('/').last;
          image = File(pickedFile.path);
        });
      } catch (e) {
        setState(() {
          _pickImageError = e;
        });
      }
    });
  }

  Future<void> _displayPickImageDialog(
      BuildContext context, OnPickImageCallback onPick) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Access to device widget?'),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                  child: const Text('Agree'),
                  onPressed: () {
                    double width = maxWidthController.text.isNotEmpty
                        ? double.parse(maxWidthController.text)
                        : null;
                    double height = maxHeightController.text.isNotEmpty
                        ? double.parse(maxHeightController.text)
                        : null;
                    int quality = qualityController.text.isNotEmpty
                        ? int.parse(qualityController.text)
                        : null;
                    onPick(width, height, quality);
                    Navigator.of(context).pop();
                  }),
            ],
          );
        });
  }
}

typedef void OnPickImageCallback(
    double maxWidth, double maxHeight, int quality);

class AspectRatioVideo extends StatefulWidget {
  AspectRatioVideo(this.controller);

  final VideoPlayerController controller;

  @override
  AspectRatioVideoState createState() => AspectRatioVideoState();
}

class AspectRatioVideoState extends State<AspectRatioVideo> {
  VideoPlayerController get controller => widget.controller;
  bool initialized = false;

  void _onVideoControllerUpdate() {
    if (!mounted) {
      return;
    }
    if (initialized != controller.value.isInitialized) {
      initialized = controller.value.isInitialized;
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    controller.addListener(_onVideoControllerUpdate);
  }

  @override
  void dispose() {
    controller.removeListener(_onVideoControllerUpdate);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (initialized) {
      return Center(
        child: AspectRatio(
          aspectRatio: controller.value.aspectRatio,
          child: VideoPlayer(controller),
        ),
      );
    } else {
      return Container();
    }
  }
}
