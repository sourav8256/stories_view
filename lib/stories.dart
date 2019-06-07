import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'models/story.dart';

class StoriesWidget extends StatefulWidget {
  final String profilePicUrl;
  final String name;
  final String time;
  final List<Story> stories;

  StoriesWidget(this.profilePicUrl, this.name, this.time, this.stories);

  @override
  State<StatefulWidget> createState() {
    return new _StoriesWidgetState(profilePicUrl, name, time, stories);
  }
}

class _StoriesWidgetState extends State<StoriesWidget> {
  String profilePicUrl;
  String name;
  String time;
  List<Story> stories;

  _StoriesWidgetState(this.profilePicUrl, this.name, this.time, this.stories);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.black),
      child: Stack(
        children: <Widget>[
          Center(
            child: CarouselSlider(
              enlargeCenterPage: true,
              pauseAutoPlayOnTouch: Duration(seconds: 10),
              autoPlay: true,
              viewportFraction: 1.0,
              items: getStories(stories),
            ),
          ),
          new Container(
            width: 70.0,
            height: 70.0,
            margin: EdgeInsets.all(12.0),
            decoration: new BoxDecoration(
              shape: BoxShape.circle,
              image: new DecorationImage(
                fit: BoxFit.fill,
                image: new NetworkImage(
                  profilePicUrl,
                ),
              ),
            ),
          ),
          new Container(
            margin: EdgeInsets.only(left: 95.0, top: 20.0),
            child: new Text(
              name,
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
          ),
          new Container(
            margin: EdgeInsets.only(left: 95.0, top: 45.0),
            child: new Text(
              time,
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.white,
              ),
            ),
          ),
          new ProgressIndicatorDemo(),
        ],
      ),
    );
  }

  List<Widget> getStories(List<Story> stories) {
    List<Widget> storyWidgets = new List();

    for (int i = 0; i < stories.length; i++) {
      storyWidgets.add(getStory(stories[i].imageUrl, stories[i].caption));
    }

    return storyWidgets;
  }

  Widget getStory(String imageUrl, String caption) {
    return Container(
      width: double.infinity,
      child: Stack(
        children: <Widget>[
          SizedBox.expand(
            child: Center(
              child: Image.network(
                imageUrl,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProgressIndicatorDemo extends StatefulWidget {
  @override
  _ProgressIndicatorDemoState createState() =>
      new _ProgressIndicatorDemoState();
}

class _ProgressIndicatorDemoState extends State<ProgressIndicatorDemo>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 7000),
      vsync: this,
    );
    animation = Tween(begin: 0.0, end: 1.0).animate(controller)
      ..addListener(() {
        setState(() {
          // the state that has changed here is the animation object’s value
        });
      });
    controller.repeat();
  }

  @override
  void dispose() {
    controller.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: LinearProgressIndicator(
        value: animation.value,
      ),
    );
  }
}
