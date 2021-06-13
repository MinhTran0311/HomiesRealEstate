import 'dart:math';
import 'dart:ui';

import 'package:boilerplate/constants/app_theme.dart';
import 'package:boilerplate/constants/assets.dart';
import 'package:boilerplate/models/converter/local_converter.dart';
import 'package:boilerplate/models/lichsugiaodich/lichsugiadich.dart';
import 'package:boilerplate/models/post/hoadonbaidang/hoadonbaidang.dart';
import 'package:boilerplate/models/post/newpost/newpost.dart';
import 'package:boilerplate/models/post/post.dart';
import 'package:boilerplate/models/post/postpack/pack.dart';
import 'package:boilerplate/stores/language/language_store.dart';
import 'package:boilerplate/stores/post/post_store.dart';
import 'package:boilerplate/stores/theme/theme_store.dart';
import 'package:boilerplate/stores/town/town_store.dart';
import 'package:boilerplate/stores/user/user_store.dart';
import 'package:boilerplate/ui/home/detail.dart';
import 'package:boilerplate/ui/home/filter.dart';
import 'package:boilerplate/ui/profile/mypost/editpost/editpost.dart';
import 'package:boilerplate/ui/profile/wallet/wallet.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:boilerplate/widgets/generalMethods.dart';
import 'package:boilerplate/widgets/progress_indicator_widget.dart';
import 'package:boilerplate/widgets/rounded_button_widget.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:http/http.dart';
import 'package:material_dialog/material_dialog.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MyPostScreen extends StatefulWidget {
  final UserStore userStore;
  final PostStore postStore;
  MyPostScreen({@required this.userStore, this.postStore});
  @override
  _MyPostScreenState createState() =>
      _MyPostScreenState(userStore: userStore, postStore: postStore);
}

enum BestTutorSite { javatpoint, w3schools, tutorialandexample }

class _MyPostScreenState extends State<MyPostScreen> {
  BestTutorSite _site = BestTutorSite.javatpoint;
  final UserStore userStore;
  final PostStore postStore;
  TextEditingController _searchController11 = new TextEditingController();
  _MyPostScreenState({@required this.userStore, this.postStore});
  TownStore _townStore;
  ThemeStore _themeStore;
  String dropdownValue = "Tất cả";
  int key = 0;
  GlobalKey _refresherKey1 = GlobalKey();
  GlobalKey _contentKey1 = GlobalKey();
  bool isRefreshing1 = false;
  RefreshController _refreshController1 =
      RefreshController(initialRefresh: false);
  final ScrollController _scrollController1 =
      ScrollController(keepScrollOffset: true);
  List<DateTime> selectedDatefl = new List<DateTime>();
  List<Pack> selectedPack = new List<Pack>();

  @override
  void initState() {
    super.initState();
    selectedDatefl = new List<DateTime>(int.parse(postStore.sobaidang));
    selectedPack = new List<Pack>(int.parse(postStore.sobaidang));
    songay = new List<int>(int.parse(postStore.sobaidang));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _themeStore = Provider.of<ThemeStore>(context);
    _townStore = Provider.of<TownStore>(context);
    if (!postStore.loadingPostForCur) postStore.getPostForCurs(false, "", key);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Icon: Icons.app_registration,
        title: Text(
          "Bài đăng của tôi",
          //size:24,
          style: Theme.of(context).textTheme.button.copyWith(
              fontWeight: FontWeight.bold, fontSize: 20, letterSpacing: 1.0),
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget buildFilter(String filterName) {
    return Container(
      margin: EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
          border: Border.all(
            color: Colors.grey[300],
            width: 1,
          )),
      child: Center(
        child: Text(
          filterName,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Stack(children: <Widget>[
      _handleErrorMessage(),
      _buildMainContent(),
    ]);
  }

  Widget _buildMainContent() {
    return Observer(
      builder: (context) {
        return postStore.loadingPostForCur
            ? CustomProgressIndicatorWidget()
            : _buildPostsList();
      },
    );
  }

  Widget _buildPostsList() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: EdgeInsets.only(top: 0, left: 24, right: 24, bottom: 0),
        child: TextField(
          autofocus: false,
          keyboardType: TextInputType.text,
          controller: _searchController11,
          onChanged: (value) {},
          style: TextStyle(
            fontSize: 28,
            height: 1,
            fontWeight: FontWeight.bold,
          ),
          decoration: InputDecoration(
              hintText: "Tìm kiếm",
              hintStyle: TextStyle(
                fontSize: 24,
                color: Colors.grey[400],
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.orange[400]),
              ),
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)),
              suffixIcon: Padding(
                padding: EdgeInsets.only(left: 16),
                child: IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Colors.grey[400],
                    size: 28,
                  ),
                  onPressed: () async {
                    postStore.getPostForCurs(
                        false,
                        _searchController11 != null
                            ? _searchController11.text.toString()
                            : "",
                        key);
                    await Future.delayed(Duration(milliseconds: 2000));
                    // if (mounted) setState(() {});
                    isRefreshing1 = true;
                    _refreshController1.refreshCompleted();
                  },
                ),
              )),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 24.0),
        child: DropdownButton<String>(
          value: dropdownValue,
          //  elevation: 16
          onChanged: (String newValue) {
            setState(() {
              dropdownValue = newValue;
              if (newValue == "Tất cả")
                key = 0;
              else if (newValue == "Hết hạn")
                key = -1;
              else
                key = 1;
              postStore.getPostForCurs(
                  false,
                  _searchController11 != null
                      ? _searchController11.text.toString()
                      : "",
                  key);
            });
          },
          items: <String>["Tất cả", "Hết hạn", "Còn hạn"]
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
      _buildListView()
    ]);
  }

  Widget _buildListView() {
    return postStore.postForCurList != null
        ? Expanded(
            child: SmartRefresher(
              key: _refresherKey1,
              controller: _refreshController1,
              enablePullUp: true,
              enablePullDown: true,
              header: WaterDropHeader(
                refresh: SizedBox(
                  width: 25.0,
                  height: 25.0,
                  child: Icon(
                    Icons.flight_takeoff_outlined,
                    color: Colors.amber,
                    size: 20,
                  ),
                ),
                idleIcon: SizedBox(
                  width: 25.0,
                  height: 25.0,
                  child: Icon(
                    Icons.flight_takeoff_outlined,
                    color: Colors.amber,
                    size: 20,
                  ),
                ),
                waterDropColor: Colors.amber,
              ),
              physics: BouncingScrollPhysics(),
              footer: ClassicFooter(
                loadStyle: LoadStyle.ShowWhenLoading,
                completeDuration: Duration(milliseconds: 500),
              ),
              onLoading: () async {
                print("loading");
                postStore.getPostForCurs(
                    false,
                    _searchController11 != null
                        ? _searchController11.text.toString()
                        : "",
                    key);
                await Future.delayed(Duration(milliseconds: 2000));

                if (mounted) {
                  setState(() {});
                }
                _scrollController1.jumpTo(
                  _scrollController1.position.maxScrollExtent,
                );
                _refreshController1.loadComplete();
              },
              onRefresh: () async {
                print("refresh");
                postStore.getPostForCurs(
                    false,
                    _searchController11 != null
                        ? _searchController11.text.toString()
                        : "",
                    key);
                await Future.delayed(Duration(milliseconds: 2000));
                if (mounted) setState(() {});
                isRefreshing1 = true;
                _refreshController1.refreshCompleted();
              },
              scrollController: _scrollController1,
              primary: false,
              child: ListView.builder(
                key: _contentKey1,
                controller: _scrollController1,
                itemCount: postStore.postForCurList.posts.length,
                itemBuilder: (context, position) {
                  return _buildPostPoster(
                      postStore.postForCurList.posts[position], position);
                },
              ),
            ),
          )
        : Center(
            child: Text(
              "chưa có bài đăng",
            ),
          );
  }

  List<int> songay = new List<int>();
  _selectDatefl(
    BuildContext context,
    DateTime ngayhethan,
    int index,
  ) async {
    if (selectedDatefl[index] == null) if (DateTime.now().isAfter(ngayhethan))
      selectedDatefl[index] = DateTime.now().add(Duration(days: 1));
    else
      selectedDatefl[index] = ngayhethan.add(Duration(days: 1));
    final DateTime picked = await showDatePicker(
      context: context,
      locale: const Locale('en', ''),
      initialDate: selectedDatefl[index].subtract(Duration(days: 0)),
      firstDate: DateTime.now().isAfter(ngayhethan)
          ? DateTime.now().add(Duration(days: 1))
          : ngayhethan.add(Duration(days: 1)),
      lastDate: DateTime.now().add(const Duration(days: 100)),
    );
    if (picked != null && picked != selectedDatefl[index])
      setState(() {
        songay[index] = 0;
        if (DateTime.now().isAfter(
            DateTime.parse(postStore.postForCurList.posts[index].thoiHan))) {
          while (
              picked.isAfter(DateTime.now().add(Duration(days: songay[index]))))
            songay[index]++;
          selectedDatefl[index] =
              DateTime.now().add(Duration(days: songay[index]));
        } else {
          while (picked.isAfter(
              DateTime.parse(postStore.postForCurList.posts[index].thoiHan)
                  .add(Duration(days: songay[index])))) songay[index]++;
          selectedDatefl[index] =
              DateTime.parse(postStore.postForCurList.posts[index].thoiHan)
                  .add(Duration(days: songay[index]));
        }
      });
  }

  void _showBottomSheetPopMenu(Post post, int position) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        )),
        builder: (BuildContext context) {
          return Wrap(
            children: [
              buildPopMenuBottom(post, position),
            ],
          );
        });
  }

  Widget buildPopMenuBottom(Post post, int position) {
    return Container(
        padding: EdgeInsets.only(right: 24, left: 24, top: 32, bottom: 24),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Icon(
                  Icons.edit_sharp,
                  color: Colors.grey,
                  size: 28,
                ),
                SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  child: Text(
                    "Chỉnh sửa",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditpostScreen(
                                  post: post,
                                  townStore: _townStore,
                                  postStore: postStore,
                                  userStore: userStore,
                                )));
                  },
                ),
              ],
            ),
            SizedBox(
              height: 24,
            ),
            Row(
              children: [
                Icon(
                  Icons.delete,
                  color: Colors.grey,
                  size: 28,
                ),
                SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  child: Text(
                    "Xóa bài đăng",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    var futureValue = showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                              "Bạn có chắc chắn muốn xóa bài đăng?",
                              style:
                                  TextStyle(fontSize: 24, fontFamily: 'intel'),
                            ),
                            content: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RoundedButtonWidget(
                                  buttonText: "Đồng ý",
                                  buttonColor: Colors.green,
                                  onPressed: () {
                                    Navigator.of(context).pop(true);
                                  },
                                ),
                                RoundedButtonWidget(
                                  buttonColor: Colors.grey,
                                  buttonText: "Hủy",
                                  onPressed: () {
                                    Navigator.of(context).pop(false);
                                  },
                                )
                              ],
                            ),
                          );
                        });
                    futureValue.then((value) {
                      post.trangThai = "Off";
                      if (value) postStore.Delete(post);
                      // true/false
                    });
                  },
                ),
              ],
            ),
          ],
        ));
  }

  Widget _buildPostPoster(Post post, int index) {
    Newpost newpost;
    return Observer(builder: (context) {
      return Card(
        margin: EdgeInsets.only(bottom: 24, right: 10, left: 10),
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Column(children: [
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Detail(post: post)));
            },
            child: Container(
              height: 210,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: post.featuredImage != null
                    ? NetworkImage(post.featuredImage)
                    : AssetImage(Assets.front_img),
                fit: BoxFit.cover,
              )),
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [
                      0.5,
                      1.0
                    ],
                        colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.7),
                    ])),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.yellow[700],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          width: 80,
                          padding: EdgeInsets.symmetric(vertical: 4),
                          child: Center(
                            child: Text(
                              post.tagLoaiBaidang,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: DateTime.now()
                                      .isAfter(DateTime.parse(post.thoiHan))
                                  ? Colors.red[700]
                                  : Colors.green[600],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          width: 80,
                          padding: EdgeInsets.symmetric(vertical: 4),
                          child: Center(
                              child: DateTime.now()
                                      .isAfter(DateTime.parse(post.thoiHan))
                                  ? Text("Hết hạn",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ))
                                  : Text("Còn Hạn",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ))),
                        ),
                        GestureDetector(
                          onTap: () {
                            _showBottomSheetPopMenu(post, index);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                BorderRadius.all(Radius.circular(100))),
                            width: 38,
                            height: 38,
                            child: Icon(
                            Icons.menu_outlined,
                            size: 25,
                            color: _themeStore.darkMode
                                ? Colors.white
                                : Colors.black,
                          ),
                        )),
                      ],
                    ),
                    Expanded(child: Container()),
                    Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            post.tieuDe,
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                post.dienTich.toString() + ' m2',
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.fade,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                priceFormat(post.gia),
                                textAlign: TextAlign.end,
                                overflow: TextOverflow.fade,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: Colors.white,
                                    size: 14,
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Flexible(
                                    child: Container(
                                      padding: EdgeInsets.only(right: 4),
                                      child: Text(
                                        post.tenXa,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(post.diemBaiDang.toString(),
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                      )),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 14,
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 8.0,
                    )
                  ],
                ),
              ),
            ),
          ),
          ExpansionTile(
            title: Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Text(
                "Gia hạn",
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
              ),
            ),
            tilePadding: EdgeInsets.only(top: 0.0),
            //.all(0),
            children: <Widget>[
              Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Text(
                          "Ngày hết hạn: ${post.thoiHan.split("T")[0]} ${post.thoiHan.split("T")[1].split(".")[0]}"),
                    ),
                    if (selectedDatefl[index] != null) (SizedBox(height: 12)),
                    if (selectedDatefl[index] != null &&
                        DateTime.now().isAfter(DateTime.parse(post.thoiHan)))
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: DropdownButtonFormField<Pack>(
                          hint: Text("Chọn gói bài đăng mới"),
                          value: selectedPack[index],
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                            onPressed: () => setState(() {
                              selectedPack[index] = null;
                            }),
                            icon: Icon(Icons.clear),
                          )),
                          onChanged: (Pack Value) {
                            setState(() {
                              selectedPack[index] = Value;
                            });
                          },
                          items: postStore.packList.packs.map((Pack type) {
                            return DropdownMenuItem<Pack>(
                              value: type,
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.account_circle,
                                    color: const Color(0xFF167F67),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    type.tenGoi,
                                    style: TextStyle(),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    if (selectedDatefl[index] != null) (SizedBox(height: 12)),
                    if (selectedDatefl[index] != null)
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: (Text(
                            "Gia hạn đến:   ${selectedDatefl[index].toIso8601String().split("T")[0]} ${selectedDatefl[index].toIso8601String().split("T")[1].split(".")[0]}")),
                      ),
                    SizedBox(height: 12),
                    if (selectedDatefl[index] != null)
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: (Text(
                            "Phí gia hạn:    ${(selectedPack[index] == null) ? songay[index] * postStore.packList.packs[post.goiBaiDangId - 1].phi : songay[index] * selectedPack[index].phi}")),
                      ),
                    SizedBox(height: 12),
                    RoundedButtonWidget(
                      onPressed: () async => {
                        _selectDatefl(
                            context, DateTime.parse(post.thoiHan), index)
                      },
                      buttonColor: Colors.amber,
                      textColor: Colors.white,
                      buttonText: ('Chọn ngày kết thúc'),
                    ),
                    if (selectedDatefl[index] != null)
                      RoundedButtonWidget(
                        onPressed: () {
                          newpost = new Newpost();
                          if (songay[index] *
                                  (selectedPack[index] == null
                                      ? postStore.packList
                                          .packs[post.goiBaiDangId - 1].phi
                                      : selectedPack[index].phi) >
                              userStore.userCurrent.wallet) {
                            var futureValue = showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(
                                      "Bạn không đủ số dư để thực hiện giao dịch?",
                                      style: TextStyle(
                                          fontSize: 24, fontFamily: 'intel'),
                                    ),
                                    content: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        RoundedButtonWidget(
                                          buttonText: "Nạp thêm tiền",
                                          buttonColor: Colors.green,
                                          onPressed: () {
                                            Navigator.of(context).pop(true);
                                          },
                                        ),
                                        RoundedButtonWidget(
                                          buttonColor: Colors.grey,
                                          buttonText: "Hủy",
                                          onPressed: () {
                                            Navigator.of(context).pop(false);
                                          },
                                        )
                                      ],
                                    ),
                                  );
                                });
                            futureValue.then((value) {
                              Route route = MaterialPageRoute(
                                  builder: (context) => NapTienPage(
                                        userID: userStore.userCurrent.UserID,
                                      ));
                              Navigator.push(context, route);
                            });
                          } else {
                            var futureValue = showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(
                                      "Gia hạn bài viết và thực hiện thanh toán?",
                                      style: TextStyle(
                                          fontSize: 24, fontFamily: 'intel'),
                                    ),
                                    content: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        RoundedButtonWidget(
                                          buttonText: "Đồng ý",
                                          buttonColor: Colors.green,
                                          onPressed: () {
                                            Navigator.of(context).pop(true);
                                          },
                                        ),
                                        RoundedButtonWidget(
                                          buttonColor: Colors.grey,
                                          buttonText: "Hủy",
                                          onPressed: () {
                                            Navigator.of(context).pop(false);
                                          },
                                        )
                                      ],
                                    ),
                                  );
                                });
                            futureValue.then((value) {
                              //_postStore.postPost(_newpost);
                              post.giagoi = selectedPack[index] == null
                                  ? postStore
                                      .packList.packs[post.goiBaiDangId - 1].phi
                                  : selectedPack[index].phi;
                              post.goiBaiDangId = selectedPack[index] == null
                                  ? post.goiBaiDangId
                                  : selectedPack[index].id;
                              post.thoiHan =
                                  selectedDatefl[index].toIso8601String();
                              newpost.post = post;
                              newpost.lichsugiaodichs = new lichsugiaodich();
                              newpost.lichsugiaodichs.userId = post.userId;
                              newpost.lichsugiaodichs.ghiChu =
                                  "${post.tieuDe} gia hạn";
                              newpost.lichsugiaodichs.thoiDiem =
                                  DateTime.now().toIso8601String();
                              newpost.lichsugiaodichs.soTien =
                                  selectedPack[index] == null
                                      ? songay[index] * post.giagoi
                                      : songay[index] * selectedPack[index].phi;
                              newpost.hoadonbaidang = new Hoadonbaidang();
                              newpost.hoadonbaidang.thoiDiem =
                                  newpost.lichsugiaodichs.thoiDiem;
                              newpost.hoadonbaidang.giaGoi =
                                  selectedPack[index] == null
                                      ? post.giagoi
                                      : selectedPack[index].phi;
                              newpost.hoadonbaidang.soNgayMua = songay[index];
                              newpost.hoadonbaidang.tongTien =
                                  newpost.lichsugiaodichs.soTien;
                              newpost.hoadonbaidang.ghiChu =
                                  "Gia hạn bài đăng \"${post.tieuDe}\"";
                              newpost.hoadonbaidang.baiDangId = post.id;
                              newpost.hoadonbaidang.goiBaiDangId =
                                  selectedPack[index] == null
                                      ? post.goiBaiDangId
                                      : selectedPack[index].id;
                              newpost.hoadonbaidang.userId = post.userId;
                              postStore.giahan(newpost);
                              setState(() {
                                selectedDatefl[index] = null;
                                selectedPack[index] = null;
                              });
                            });
                          }
                        },
                        buttonColor: Colors.amber,
                        textColor: Colors.white,
                        buttonText: ('Gia hạn'),
                      ),
                  ]),
            ],
          ),
        ]),
      );
    });
  }

  Widget _handleErrorMessage() {
    return Observer(
      builder: (context) {
        if (postStore.errorStore.errorMessage.isNotEmpty) {
          return showErrorMessage(postStore.errorStore.errorMessage,context);
        }
        if (postStore.successgiahan) {
          postStore.successgiahan = false;
          showSuccssfullMesssage("Gia hạn thành công",context);
        }
        if (postStore.successdelete) {
          postStore.successdelete = false;
          showSuccssfullMesssage("Xóa bài đăng thành công",context);
        }
        return SizedBox.shrink();
      },
    );
  }
}
