import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// ignore: must_be_immutable
abstract class BasePageWidget extends StatefulWidget {
  BasePageWidgetState basePageWidgetState;
  @override
  BasePageWidgetState createState() {
    basePageWidgetState = createPageState();
    return basePageWidgetState;
  }

  BasePageWidgetState createPageState();
}

abstract class BasePageWidgetState<T extends BasePageWidget> extends State<T> {
  bool _isAppBarShow = true; //是否显示导航栏

  bool _isErrorWidgetShow = false; //是否显示错误信息
  bool _isLoadingWidgetShow = false; //是否显示加载中
  bool _isEmptyWidgetShow = false; //是否显示空数据视图
  String _emptyContentMessage = "...暂无数据...";

  String _errorContentMessage = "网络连接错误，请检查网络";

  FontWeight _fontWeight = FontWeight.w600; //错误页面和空页面的字体粗度

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getBaseAppBar(),
      body: Container(
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            getContentWidget(context),
//            _getBaseErrorWidget(),
//            _getBaseEmptyWidget(),
//            _getBaseLoadingWidget(),
          ],
        ),
      ),
    );
  }

  Widget getContentWidget(BuildContext buildContext);

  Widget _getBaseErrorWidget() {
    return Offstage(
      offstage: !_isErrorWidgetShow,
      child: getErrorWidget(),
    );
  }

  Widget _getBaseLoadingWidget() {
    return Offstage(
      offstage: !_isLoadingWidgetShow,
      child: getLoadingWidget(),
    );
  }

  Widget _getBaseEmptyWidget() {
    return Offstage(
      offstage: !_isEmptyWidgetShow,
      child: getEmptyWidget(),
    );
  }

  ///加载中loading视图
  Widget getLoadingWidget() {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 80),
      color: Colors.white,
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Image(
            //   image: AssetImage("images/status_ic_state_loading.png"),
            //   width: 100,
            //   height: 100,
            // ),

            SpinKitFadingCircle(
              itemBuilder: (_, int index) {
                return DecoratedBox(
                  decoration: BoxDecoration(
                      color: index.isEven ? Colors.red : Colors.green),
                );
              },
            ),

            Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Text(
                "加载中...",
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: _fontWeight,
                ),
              ),
            ),

            //  Transform.rotate(
            //    child: Image(
            //       image: AssetImage("images/status_ic_state_loading.png"),
            //     width: 100,
            //     height: 100,
            //    ),
            //    angle: pi/2.0,
            //  )
          ],
        ),
      ),
    );
  }

  ///空数据页面
  Widget getEmptyWidget() {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 80),
      color: Colors.white,
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(
                color: Colors.black12,
                image: AssetImage("images/status_ic_state_empty.png"),
                width: 200,
                height: 200,
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Text(
                  _emptyContentMessage,
                  style: TextStyle(color: Colors.grey, fontWeight: _fontWeight),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  ///错误页面
  Widget getErrorWidget() {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 80),
      color: Colors.white,
      width: 300,
      height: 300,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
              image: AssetImage("images/status_ic_state_error.png"),
              width: 200,
              height: 200,
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Text(
                _errorContentMessage,
                style: TextStyle(color: Colors.grey, fontWeight: _fontWeight),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: OutlineButton(
                child: Text("点击重新加载",
                    style:
                        TextStyle(color: Colors.grey, fontWeight: _fontWeight)),
                onPressed: () => {onRetryListener()},
              ),
            )
          ],
        ),
      ),
    );
  }

  ///点击重试
  void onRetryListener();

  PreferredSizeWidget _getBaseAppBar() {
    return PreferredSize(
      child: Offstage(
        offstage: !_isAppBarShow,
        child: getAppBar(),
      ),
      preferredSize: Size.fromHeight(48),
    );
  }

  ///导航栏
  AppBar getAppBar();

  ///设置appbar的状态
  void setAppBarVisable(bool isVisable) {
    setState(() {
      _isAppBarShow = isVisable;
    });
  }

  void showContent() {
    setState(() {
      _isEmptyWidgetShow = false;
      _isLoadingWidgetShow = false;
      _isErrorWidgetShow = false;
    });
  }

  void showloading() {
    setState(() {
      _isEmptyWidgetShow = false;
      _isLoadingWidgetShow = true;
      _isErrorWidgetShow = false;
    });
  }

  void showEmpty() {
    setState(() {
      _isEmptyWidgetShow = true;
      _isLoadingWidgetShow = false;
      _isErrorWidgetShow = false;
    });
  }

  void showError() {
    setState(() {
      _isEmptyWidgetShow = false;
      _isLoadingWidgetShow = false;
      _isErrorWidgetShow = true;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void toast(String text) {
    if (null != text) {
      showToast(text);
    }
  }
}
