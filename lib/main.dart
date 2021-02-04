import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'On Drag UIKitView Issue When Scroll CustomScrollView'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _hideUIView = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (c, i) {
                if (i == 10)
                  return _hideUIView
                      ? Container()
                      : VisibilityDetector(
                          key: Key("UIView"),
                          onVisibilityChanged: (visibilityInfo) {
                            var visiblePercentage =
                                visibilityInfo.visibleFraction * 100;
                            if (visiblePercentage > 90) {
                              setState(() {
                                _hideUIView = true;
                              });
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: UIView(),
                          ),
                        );

                return Container(
                  height: 200,
                  margin: const EdgeInsets.only(top: 8.0),
                  decoration: BoxDecoration(
                    color: Colors.green[300],
                  ),
                  child: Center(
                    child: Text(
                      "Container",
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              },
              childCount: 16,
            ),
          ),
        ],
      ),
    );
  }
}

class UIView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 200.0,
      child: UiKitView(viewType: 'rect'),
    );
  }
}
