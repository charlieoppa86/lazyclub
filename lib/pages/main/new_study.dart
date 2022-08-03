import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lazyclub/utils/global_methods.dart';
import 'package:lazyclub/constants/db_constants.dart';
import 'package:lazyclub/components/providers/theme/style.dart';
import 'package:lazyclub/utils/utils.dart';
import 'package:lazyclub/database/categories.dart';
import 'package:lazyclub/pages/auth/login_page.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:lazyclub/pages/main/my_study.dart';
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';

class UploadStudyPage extends StatefulWidget {
  static const routeName = '/UploadStudyPage';
  const UploadStudyPage({super.key});

  @override
  State<UploadStudyPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadStudyPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  String mainCatValue = '포맷';
  String subCatValue = '주제';
  List<String> subCatList = [];
  bool processing = false;
  //File? _pickedImage;
  //Uint8List webImage = Uint8List(8);

/*   late final TextEditingController studyNameController,
      studyMinDescController,
      studyLocationController,
      studyPriceController,
      studyMaxDescController,
      studyLeaderController,
      studyLeadIntroController,
      studyApplyLinkController;

  @override
  void initState() {
    studyNameController = TextEditingController();
    studyMinDescController = TextEditingController();
    studyLocationController = TextEditingController();
    studyPriceController = TextEditingController();
    studyMaxDescController = TextEditingController();
    studyLeaderController = TextEditingController();
    studyLeadIntroController = TextEditingController();
    studyApplyLinkController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    studyNameController.dispose();
    studyMinDescController.dispose();
    studyLocationController.dispose();
    studyPriceController.dispose();
    studyMaxDescController.dispose();
    studyLeaderController.dispose();
    studyLeadIntroController.dispose();
    studyApplyLinkController.dispose();
    super.dispose();
  } */

  void _clearForm() {
    _formKey.currentState!.reset();
    setState(() {
      _imageFile = null;
      // webImage = Uint8List(8);
    });
  }

  // 신규 변수
  late String studyName;
  late String studyMinDesc;
  late String studyLocation;
  late int studyPrice;
  late String studyMaxDesc;
  late String studyLeaderName;
  late String studyLeaderInfo;
  late String studyApplyLink;
  //

  // 신규 이미지 피커
/*   final ImagePicker _picker = ImagePicker();

  XFile? _imageFile;
  dynamic _pickedImageError;

  CollectionReference profileImage =
      FirebaseFirestore.instance.collection('profileImage');

  void _pickImageFromCamera() async {
    try {
      final pickedImage = await _picker.pickImage(
          source: ImageSource.camera,
          maxHeight: 150,
          maxWidth: 150,
          imageQuality: 95);
      setState(() {
        _imageFile = pickedImage;
      });
    } catch (error) {
      setState(() {
        _pickedImageError();
      });
    }
  } */
  final ImagePicker _picker = ImagePicker();

  XFile? _imageFile;
  List<String> studyThumbnail = [];
  dynamic _pickedImageError;

  void _pickImageFromGallery() async {
    try {
      final pickedImage = await _picker.pickImage(
          source: ImageSource.gallery,
          maxHeight: 150,
          maxWidth: 150,
          imageQuality: 95);
      setState(() {
        _imageFile = pickedImage!;
      });
    } catch (error) {
      setState(() {
        _pickedImageError();
      });
    }
  }

  Widget previewImage() {
    return ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        child: Image.file(File(_imageFile!.path), fit: BoxFit.fill));
  }

  // 스터디 업로드

  void selectStudyCate(String? value) {
    if (value == '포맷') {
      subCatList = [];
    } else if (value == '오프라인') {
      subCatList = studyOffline;
    } else if (value == '온라인') {
      subCatList = studyOnline;
    }

    setState(() {
      mainCatValue = value!;
      subCatValue = '주제';
    });
  }

  Future<void> _uploadImage() async {
    final User? user = authInstance.currentUser;
    if (mainCatValue != '포맷' && subCatValue != '주제') {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();

        if (_imageFile != null) {
          setState(() {
            processing = true;
          });
          try {
            firebase_storage.Reference ref = firebase_storage
                .FirebaseStorage.instance
                .ref('studies/${path.basename(_imageFile!.path)}');

            await ref.putFile(File(_imageFile!.path)).whenComplete(() async {
              await ref.getDownloadURL().then((value) {
                studyThumbnail.add(value);
              });
            });
          } catch (error) {
            print(error);
          }
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('프로필 이미지를 채워주셔야해요!')));
        }
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('모든 필드를 채워주셔야해요!')));
      }

      if (user == null) {
        GlobalMethods.errorDialog(content: '로그인이 필요합니다', context: context);
        Navigator.pushReplacementNamed(context, LoginPage.routeName);
        return;
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('스터디 카테고리를 선택해주세요!')));
    }
  }

  void _uploadData() async {
    if (studyThumbnail.isNotEmpty) {
      CollectionReference studyRef =
          FirebaseFirestore.instance.collection('studies');

      final _uuid = const Uuid().v4();

      await studyRef.doc(_uuid).set({
        'studyFormat': mainCatValue,
        'studySubject': subCatValue,
        'studyName': studyName,
        'studyMinDesc': studyMinDesc,
        'studyLocation': studyLocation,
        'studyPrice': studyPrice,
        'studyMaxDesc': studyMaxDesc,
        'studyLeaderName': studyLeaderName,
        'studyLeaderInfo': studyLeaderInfo,
        'studyApplyLink': studyApplyLink,
        'studyThumbnail': studyThumbnail,
        'uid': FirebaseAuth.instance.currentUser!.uid,
        'id': _uuid,
        'createdAt': Timestamp.now()
      }).whenComplete(() {
        setState(() {
          processing = false;
          _imageFile = null;
          mainCatValue = '포맷';
          subCatList = [];
          studyThumbnail = [];
        });
        Fluttertoast.showToast(
            msg: "새로운 스터디를 만들었어요🎉",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey.shade700,
            textColor: Colors.white,
            fontSize: 16.0);
        _formKey.currentState!.reset();
      });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('이미지를 선택해주세요!')));
    }
  }

  void _uploadStudy() async {
    await _uploadImage().whenComplete(() => _uploadData());
    /*  final User? user = authInstance.currentUser;
    if (mainCatValue != '포맷' && subCatValue != '주제') {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();

        if (_imageFile != null) {
          try {
            firebase_storage.Reference ref = firebase_storage
                .FirebaseStorage.instance
                .ref('studies/${path.basename(_imageFile!.path)}');

            await ref.putFile(File(_imageFile!.path)).whenComplete(() async {
              await ref.getDownloadURL().then((value) {
                studyThumbnail.add(value);
              }).whenComplete(() async {
                CollectionReference studyRef =
                    FirebaseFirestore.instance.collection('studies');

                await studyRef.doc().set({
                  'studyFormat': mainCatValue,
                  'studySubject': subCatValue,
                  'studyName': studyName,
                  'studyMinDesc': studyMinDesc,
                  'studyLocation': studyLocation,
                  'studyPrice': studyPrice,
                  'studyMaxDesc': studyMaxDesc,
                  'studyLeaderName': studyLeaderName,
                  'studyLeaderInfo': studyLeaderInfo,
                  'studyApplyLink': studyApplyLink,
                  'studyThumbnail': studyThumbnail,
                  'uid': FirebaseAuth.instance.currentUser!.uid,
                });
              });
            });
          } catch (error) {
            print(error);
          }

          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('새로운 스터디 업로드 성공!')));

          setState(() {
            _imageFile = null;
            mainCatValue = '포맷';
            // subCatValue = '주제';
            subCatList = [];
          });
          _formKey.currentState!.reset();
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('프로필 이미지를 채워주셔야해요!')));
        }
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('모든 필드를 채워주셔야해요!')));
      }

      if (user == null) {
        GlobalMethods.errorDialog(content: '로그인이 필요합니다', context: context);
        Navigator.pushReplacementNamed(context, LoginPage.routeName);
        return;
      }

      //final isVaild = _formKey.currentState!.validate();

    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('스터디 카테고리를 선택해주세요!')));
    } */
  }

  Widget _studyThumbnail() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        children: [
          Text(
            '대표 이미지',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          SizedBox(
            width: 8,
          ),
          TextButton(
              onPressed: () {
                setState(() {
                  _imageFile = null;
                  //webImage = Uint8List(8);
                });
              },
              child: Text(
                '재설정',
                style: TextStyle(fontSize: 14),
              ))
        ],
      ),
      SizedBox(
        height: 10,
      ),
      GestureDetector(
        onTap: () {
          _pickImageFromGallery();
        },
        child: Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
                color: headTextClr.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10)),
            child: _imageFile == null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        IconlyLight.image,
                        size: 30,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        '이미지 추가',
                        style: TextStyle(color: headTextClr, fontSize: 14),
                      )
                    ],
                  )
                : previewImage()),
      ),
    ]);
  }

  Widget _studyName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '스터디 이름',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: TextFormField(
            validator: ((value) {
              if (value!.isEmpty) {
                return '스터디 이름을 입력해주세요';
              }
              return null;
            }),
            onSaved: ((value) {
              studyName = value!;
            }),
            // controller: studyNameController,
            maxLines: 1,
            maxLength: 20,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                hintText: '스터디 이름을 지어주세요',
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: headTextClr)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: headTextClr, width: 1)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: bluishClr, width: 2))),
          ),
        ),
      ],
    );
  }

  Widget _studyMinDesc() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '스터디 요약',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: TextFormField(
            validator: ((value) {
              if (value!.isEmpty) {
                return '스터디 요약을 입력해주세요';
              }
              return null;
            }),
            onSaved: ((value) {
              studyMinDesc = value!;
            }),
            //controller: studyMinDescController,
            maxLines: 1,
            maxLength: 30,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                hintText: '스터디에 대한 짧은 설명을 적어주세요',
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: headTextClr)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: headTextClr, width: 1)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: bluishClr, width: 2))),
          ),
        ),
      ],
    );
  }

  Widget _studyCategory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '스터디 카테고리',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.4,
              color: lightBgClr,
              child: DropdownButtonHideUnderline(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: DropdownButton(
                    iconSize: 30,
                    dropdownColor: lightBgClr,
                    isExpanded: true,
                    onChanged: (String? value) {
                      selectStudyCate(value);
                    },
                    hint: const Text('포맷'),
                    value: mainCatValue,
                    items: studyCategory.map<DropdownMenuItem<String>>((value) {
                      return DropdownMenuItem(
                        child: Text(value),
                        value: value,
                      );
                    }).toList()),
              )),
            ),
            Spacer(),
            Container(
              width: MediaQuery.of(context).size.width * 0.4,
              color: lightBgClr,
              child: DropdownButtonHideUnderline(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: DropdownButton(
                    iconSize: 30,
                    dropdownColor: lightBgClr,
                    isExpanded: true,
                    onChanged: (String? value) {
                      setState(() {
                        subCatValue = value!;
                      });
                    },
                    hint: const Text(
                      '주제',
                    ),
                    value: subCatValue,
                    items: subCatList.map<DropdownMenuItem<String>>((value) {
                      return DropdownMenuItem(
                        child: Text(value),
                        value: value,
                      );
                    }).toList()),
              )),
            )
          ],
        ),
      ],
    );
  }

  Widget _studyLocation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '스터디 위치',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: TextFormField(
            validator: ((value) {
              if (value!.isEmpty) {
                return '스터디가 진행되는 장소를 입력해주세요';
              }
              return null;
            }),
            onSaved: ((value) {
              studyLocation = value!;
            }),
            // controller: studyLocationController,
            maxLines: 1,
            maxLength: 10,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                hintText: '00시 00구, 혹은 줌, 구글밋으로 적어주세요',
                counterText: '',
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: headTextClr)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: headTextClr, width: 1)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: bluishClr, width: 2))),
          ),
        ),
      ],
    );
  }

  Widget _studyPrice() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '스터디 비용 (원)',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return '1회당 스터디 비용을 입력해주세요';
              } else if (value.isValidPrice() != true) {
                return '가격이 잘못 설정됐습니다';
              }
              return null;
            },
            onSaved: ((value) {
              studyPrice = int.parse(value!);
            }),
            // controller: studyPriceController,
            maxLines: 1,
            maxLength: 10,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp('[0-9]'))
            ],
            decoration: InputDecoration(
                hintText: '1회당 비용을 입력해 주세요',
                counterText: '',
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: headTextClr)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: headTextClr, width: 1)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: bluishClr, width: 2))),
          ),
        ),
      ],
    );
  }

  Widget _studyMaxDesc() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '스터디 상세 정보',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: TextFormField(
            validator: ((value) {
              if (value!.isEmpty) {
                return '스터디의 자세한 설명을 입력해주세요';
              }
              return null;
            }),
            onSaved: ((value) {
              studyMaxDesc = value!;
            }),
            //controller: studyMaxDescController,
            minLines: 3,
            maxLines: 20,
            maxLength: 600,
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
                hintText: '스터디를 자유롭게 소개해보세요',
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: headTextClr)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: headTextClr, width: 1)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: bluishClr, width: 2))),
          ),
        ),
      ],
    );
  }

  Widget _leaderName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '리더 닉네임',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: TextFormField(
            validator: ((value) {
              if (value!.isEmpty) {
                return '스터디 주최자를 입력해주세요';
              }
              return null;
            }),
            onSaved: ((value) {
              studyLeaderName = value!;
            }),
            //controller: studyLeaderController,
            maxLines: 1,
            maxLength: 10,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                hintText: '스터디 리더의 이름/닉네임을 입력해주세요',
                counterText: '',
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: headTextClr)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: headTextClr, width: 1)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: bluishClr, width: 2))),
          ),
        ),
      ],
    );
  }

  Widget _leaderInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '리더 한줄 소개',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: TextFormField(
            validator: ((value) {
              if (value!.isEmpty) {
                return '리더님이 어떤 분인지 알려주세요';
              }
              return null;
            }),
            onSaved: ((value) {
              studyLeaderInfo = value!;
            }),
            //controller: studyLeadIntroController,
            maxLines: 1,
            maxLength: 30,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                hintText: '리더님을 한 줄로 소개해주세요',
                counterText: '',
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: headTextClr)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: headTextClr, width: 1)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: bluishClr, width: 2))),
          ),
        ),
      ],
    );
  }

  Widget _leaderThumbnail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              '리더 프로필',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(
              width: 8,
            ),
            TextButton(
                onPressed: () {
                  setState(() {
                    _imageFile = null;
                    // webImage = Uint8List(8);
                  });
                },
                child: Text(
                  '재설정',
                  style: TextStyle(fontSize: 14),
                ))
          ],
        ),
        SizedBox(
          height: 5,
        ),
        GestureDetector(
          onTap: () {
            _pickImageFromGallery();
          },
          child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                  color: headTextClr.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10)),
              child: _imageFile == null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          IconlyLight.image,
                          size: 30,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          '이미지 추가',
                          style: TextStyle(color: headTextClr, fontSize: 14),
                        )
                      ],
                    )
                  : previewImage()),
        ),
      ],
    );
  }

  Widget _studyApplication() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '신청 링크',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: TextFormField(
            validator: ((value) {
              if (value!.isEmpty) {
                return '리더님과 소통할 수 있는 곳이 필요해요';
              }
              return null;
            }),
            onSaved: ((value) {
              studyApplyLink = value!;
            }),
            //controller: studyApplyLinkController,
            maxLength: 50,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                hintText: '카카오 오픈 채팅방 링크 등을 복붙해주세요',
                counterText: '',
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: headTextClr)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: headTextClr, width: 1)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: bluishClr, width: 2))),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    final _scaffoldColor = Theme.of(context).scaffoldBackgroundColor;
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(color: headTextClr),
              centerTitle: false,
              title: Text(
                '새 스터디',
                style: TextStyle(
                    color: headTextClr,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -1),
              ),
              actions: [],
              elevation: 0,
            ),
            body: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              controller: ScrollController(),
              child: Container(
                padding: EdgeInsets.all(25),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _studyThumbnail(),
                          SizedBox(
                            height: 30,
                          ),
                          _studyName(),
                          SizedBox(
                            height: 20,
                          ),
                          _studyMinDesc(),
                          SizedBox(
                            height: 20,
                          ),
                          _studyCategory(),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          _studyLocation(),
                          SizedBox(
                            height: 20,
                          ),
                          _studyPrice(),
                          SizedBox(
                            height: 20,
                          ),
                          _studyMaxDesc(),
                          SizedBox(
                            height: 20,
                          ),
                          _leaderName(),
                          SizedBox(
                            height: 20,
                          ),
                          _leaderInfo(),
                          SizedBox(
                            height: 20,
                          ),
                          /*     _leaderThumbnail(),
                          SizedBox(
                            height: 20,
                          ), */
                          _studyApplication(),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(primary: bluishClr),
                            onPressed: () {
                              processing == true ? null : _uploadStudy();
                              Navigator.pushReplacementNamed(
                                  context, MyStudiesList.routeName);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                '스터디 등록',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                            style:
                                ElevatedButton.styleFrom(primary: Colors.red),
                            onPressed: () {
                              _clearForm();
                            }, //_clearForm,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                '초기화',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }

/*   Future<void> _pickImage() async {
    if (!kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var selected = File(image.path);
        setState(() {
          _pickedImage = selected;
        });
      } else {
        print('이미지가 없어요!');
      }
    } else if (kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var f = await image.readAsBytes();
        setState(() {
          webImage = f;
          _pickedImage = File('a');
        });
      } else {
        print('이미지가 없어요!');
      }
    } else {
      print('무언가 에러가 나고 있습니다');
    }
  } */

}

extension PriceValidator on String {
  bool isValidPrice() {
    return RegExp(r'^((([1-9][0-9]*[\.]*)||([0][\.]*))([0-9]{1,2}))$')
        .hasMatch(this);
  }
}
