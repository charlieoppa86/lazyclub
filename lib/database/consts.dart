import 'package:firebase_auth/firebase_auth.dart';

class Splash {
  static List<String> splashImages = [
    'assets/splash1.png',
    'assets/splash2.png',
    'assets/splash3.png',
    'assets/splash4.png',
  ];
}

class SwiperImg {
  static List<String> swiperImages = [
    'assets/swiper1.png',
    'assets/swiper2.png',
  ];
}

/* abstract class AuthBase {
  User? get currentUser;
  Future<User?> signInAnonymously();
  Future<void> signOut();
}

class Auth implements AuthBase {
  final FirebaseAuth _authInstance = FirebaseAuth.instance;

  @override
  User? get currentUser => _authInstance.currentUser;

  @override
  Future<User?> signInAnonymously() async {
    final userCredential = await _authInstance.signInAnonymously();
    return userCredential.user;
  }

  @override
  Future<void> signOut() async {
    await _authInstance.signOut();
//   }
// } */

// final FirebaseAuth authInstance = FirebaseAuth.instance;
// final User? user = authInstance.currentUser;
// final uid = user!.uid;

/* class ConstStudies {
  static List<StudyGroupModel> studyGroups = [
    StudyGroupModel(
        id: '0',
        cid: '0',
        imgUrl:
            'https://images.unsplash.com/photo-1532012197267-da84d127e765?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80',
        name: '성수동 부클러버',
        category: '습관형성',
        leader: '홍길동',
        leaderInfo: '반갑습니다',
        location: '성수동',
        minDesc: '매주 1권, 한달 4권 독서 토론!',
        maxDesc: '책에 미친 사람들이 엄청나게 많다구요!',
        price: '20000',
        isPopular: false,
        isOffline: false),
    StudyGroupModel(
        id: '1',
        cid: '1',
        imgUrl:
            'https://images.unsplash.com/photo-1513672494107-cd9d848a383e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1738&q=80',
        name: '스마트스토어러스',
        category: '창업',
        leader: '손오공',
        leaderInfo: '반갑습니다',
        location: '망원동',
        minDesc: '매달 50만 원씩만 더 법시다',
        maxDesc: '단 2달만에 온라인 셀러로!',
        price: '9000',
        isPopular: false,
        isOffline: false),
    StudyGroupModel(
        id: '2',
        cid: '2',
        imgUrl:
            'https://images.unsplash.com/photo-1491336477066-31156b5e4f35?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1740&q=80',
        name: '공인자격신들',
        category: '직무',
        leader: '김상식',
        leaderInfo: '반갑습니다',
        location: '이태원동',
        minDesc: '커리어 전환이 가능해요',
        maxDesc: '땀내나는 현장을 함께해요',
        price: '10000',
        isPopular: false,
        isOffline: false),
    StudyGroupModel(
        id: '3',
        cid: '3',
        imgUrl:
            'https://images.unsplash.com/photo-1532522750741-628fde798c73?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1740&q=80',
        name: '개발새발해',
        category: '창업',
        leader: '오박사',
        leaderInfo: '반갑습니다',
        location: '청담동',
        minDesc: '플러터로 앱만들기해요',
        maxDesc: '당신도 1인 개발자로 창업까지!',
        price: '4500',
        isPopular: false,
        isOffline: false),
    StudyGroupModel(
        id: '4',
        cid: '4',
        imgUrl:
            'https://images.unsplash.com/photo-1562086780-1c95244efd6b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1740&q=80',
        name: '초기창업자 품앗이방',
        category: '창업',
        leader: '이승건',
        leaderInfo: '반갑습니다',
        location: '역삼동',
        minDesc: '힘든 상황 공유해요',
        maxDesc: '하면 된다니깐',
        price: '10000',
        isPopular: true,
        isOffline: false),
    StudyGroupModel(
        id: '5',
        cid: '5',
        imgUrl:
            'https://images.unsplash.com/photo-1552674605-db6ffd4facb5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1740&q=80',
        name: '나이트러너스',
        category: '습관형성',
        leader: '최계란',
        leaderInfo: '반갑습니다',
        location: '반포동',
        minDesc: '직장인 뜁시당~!',
        maxDesc: '세달 동안 10kg 그냥 빠져요~',
        price: '30000',
        isPopular: true,
        isOffline: false),
    StudyGroupModel(
        id: '6',
        cid: '6',
        imgUrl:
            'https://images.unsplash.com/photo-1551033406-611cf9a28f67?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80',
        name: '하루코딩',
        category: '직무',
        leader: '캡틴성수',
        leaderInfo: '반갑습니다',
        location: '줌',
        minDesc: '하루30분 코딩 스터디입니다',
        maxDesc: '코딩은 습관입니다',
        price: '20000',
        isPopular: false,
        isOffline: true),
    StudyGroupModel(
        id: '7',
        cid: '7',
        imgUrl:
            'https://images.unsplash.com/photo-1448387473223-5c37445527e7?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1740&q=80',
        name: '우리집 계단오르기',
        category: '습관형성',
        leader: '로건',
        leaderInfo: '반갑습니다',
        location: '각자 집',
        minDesc: '하루에 150kcal씩 뺍니다',
        maxDesc: '계단으로 런지하는 남자',
        price: '10000',
        isPopular: false,
        isOffline: false),
    StudyGroupModel(
        id: '8',
        cid: '8',
        imgUrl:
            'https://images.unsplash.com/photo-1513001900722-370f803f498d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80',
        name: '한달작가',
        category: '습관형성',
        leader: '김영하',
        leaderInfo: '반갑습니다',
        location: '디스코드',
        minDesc: '블로그부터 출판까지 하고싶다면?',
        maxDesc: '20년 작가외길 인생',
        price: '10000',
        isPopular: true,
        isOffline: true),
    StudyGroupModel(
        id: '9',
        cid: '9',
        imgUrl:
            'https://images.unsplash.com/photo-1530281700549-e82e7bf110d6?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=776&q=80',
        name: '반려견 교육',
        category: '기타',
        leader: '개남',
        leaderInfo: '반갑습니다',
        location: '옥수동',
        minDesc: '반려생활 엄두가 안나세요?',
        maxDesc: '강아지 교육이 힘드신분들 모두 모여',
        price: '10000',
        isPopular: true,
        isOffline: true),
    StudyGroupModel(
        id: '10',
        cid: '10',
        imgUrl:
            'https://images.unsplash.com/photo-1580519542036-c47de6196ba5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1742&q=80',
        name: '목돈만들기',
        category: '재테크',
        leader: '부읽남',
        leaderInfo: '반갑습니다',
        location: '줌',
        minDesc: '돈은 굴려야 제맛입니다!',
        maxDesc: '월 30만 원만 있으면 됨',
        price: '10000',
        isPopular: true,
        isOffline: false),
  ];
}
 */



/* class StudyGroup {
  static final List<Map<String, dynamic>> studyOffline = [
    {
      "id": "0",
      "cid": "0",
      "imgUrl": "assets/study0.png",
      "name": "성수동 부클러버",
      "category": "독서",
      "leader": "조승연",
      "format": "오프라인",
      "location": "성수동",
      "mindesc": "매주 1권, 한달 4권 독서 토론!",
      "maxdesc": "책에 미친 사람들이 엄청나게 많다구요!",
      "price": "15000",
      "favorite": "812",
      "members": "201",
      "ratings": "123",
      "comments": "완전 좋아요"
    },
    {
      "id": "1",
      "cid": "1",
      "imgUrl": "assets/study1.png",
      "name": "스마트스토어러스",
      "category": "부업",
      "leader": "손오공",
      "format": "오프라인",
      "location": "망원동",
      "mindesc": "매달 50만 원씩만 더 법시다",
      "maxdesc": "단 2달만에 온라인 셀러로!",
      "price": "18000",
      "favorite": "123",
      "members": "98",
      "ratings": "45",
      "comments": "진짜 좋아요"
    },
    {
      "id": "2",
      "cid": "2",
      "imgUrl": "assets/study2.png",
      "name": "공인자격신들",
      "category": "자격증",
      "leader": "김상식",
      "format": "오프라인",
      "location": "이태원동",
      "mindesc": "커리어 전환이 가능해요",
      "maxdesc": "땀내나는 현장을 함께해요",
      "price": "12000",
      "favorite": "73",
      "members": "23",
      "ratings": "19",
      "comments": "땀내 납니다"
    },
    {
      "id": "3",
      "cid": "3",
      "imgUrl": "assets/study3.png",
      "name": "개발새발해",
      "category": "1인창업",
      "leader": "오박사",
      "format": "오프라인",
      "location": "청담동",
      "mindesc": "플러터로 앱만들기해요",
      "maxdesc": "당신도 1인 개발자로 창업까지!",
      "price": "25000",
      "favorite": "523",
      "members": "912",
      "ratings": "427",
      "comments": "성공했습니다!"
    },
    {
      "id": "4",
      "cid": "4",
      "imgUrl": "assets/study4.png",
      "name": "예비창업자 수다방",
      "category": "스타트업",
      "leader": "이승건",
      "format": "오프라인",
      "location": "역삼동",
      "mindesc": "힘든 상황 공유해요",
      "maxdesc": "하면 된다니깐",
      "price": "10000",
      "favorite": "232",
      "members": "192",
      "ratings": "80",
      "comments": "완전 재밌어요~",
    },
    {
      "id": "5",
      "cid": "5",
      "imgUrl": "assets/study5.png",
      "name": "나이트러너스",
      "category": "건강",
      "leader": "최계란",
      "format": "오프라인",
      "location": "반포동",
      "mindesc": "직장인 뜁시당~!",
      "maxdesc": "세달 동안 10kg 그냥 빠져요~",
      "price": "5000",
      "favorite": "832",
      "members": "190",
      "ratings": "47",
      "comments": "스트레스 확 날아감~"
    }
  ];

  static final List<Map<String, String>> studyOnline = [
    {
      "id": "0",
      "cid": "0",
      "imgUrl": "assets/study6.png",
      "name": "하루코딩",
      "category": "개발지식",
      "leader": "캡틴성수",
      "format": "온라인",
      "location": "줌",
      "mindesc": "하루30분 코딩 스터디입니다",
      "maxdesc": "코딩은 습관입니다",
      "price": "10000",
      "favorite": "1298",
      "members": "1291",
      "ratings": "562",
      "comments": "너무너무 재밌어요"
    },
    {
      "id": "1",
      "cid": "1",
      "imgUrl": "assets/study7.png",
      "name": "우리집 계단오르기",
      "category": "건강",
      "leader": "로건",
      "format": "온라인",
      "location": "개인 스마트폰",
      "mindesc": "하루에 150kcal씩 뺍니다",
      "maxdesc": "계단으로 런지하는 남자",
      "price": "3000",
      "favorite": "249",
      "members": "210",
      "ratings": "112",
      "comments": "허벅지 터지는 느낌 굿"
    },
    {
      "id": "2",
      "cid": "2",
      "imgUrl": "assets/study8.png",
      "name": "한달작가",
      "category": "글쓰기",
      "leader": "김영하",
      "format": "온라인",
      "location": "줌",
      "mindesc": "블로그부터 출판까지 하고싶다면?",
      "maxdesc": "20년 작가외길 인생",
      "price": "24000",
      "favorite": "918",
      "members": "249",
      "ratings": "320",
      "comments": "서론, 본론, 결론의 재다짐"
    },
    {
      "id": "3",
      "cid": "3",
      "imgUrl": "assets/study9.png",
      "name": "아이디어분수쇼",
      "category": "직장생활",
      "leader": "젤기획",
      "format": "온라인",
      "location": "디스코드",
      "mindesc": "당신도 아이디어천재 가능!",
      "maxdesc": "된다니까요, 되요!",
      "price": "12000",
      "favorite": "123",
      "members": "424",
      "ratings": "209",
      "comments": "써먹을데가 많네요?!"
    },
  ];
} */
