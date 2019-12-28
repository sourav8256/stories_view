import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'models/story.dart';
import 'models/Values.dart';

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
              autoPlayInterval: Duration(milliseconds: Values.AUTO_PLAY_INTERVAL),
              autoPlayAnimationDuration: Duration(milliseconds: Values.ANIMATION_DURATION),
              pauseAutoPlayOnTouch: Duration(seconds: 7),
              autoPlay: true,
              viewportFraction: 1.0,
              items: getStories(stories),
            ),
          ),
          new Container(
            // carousel
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
            // image
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
            // name
            margin: EdgeInsets.only(left: 95.0, top: 45.0),
            child: new Text(
              time,
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.white,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: getProgressIndicators(stories),
          ),
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

List<Widget> getProgressIndicators(List<Story> stories) {
  List<Widget> progressIndicators = new List();

  for (int i = 0; i < stories.length; i++) {
    // progressIndicators.add(new Expanded(child: ProgressIndicatorDemo(i.toDouble(),(i+1).toDouble())));
    progressIndicators.add(
      Expanded(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(1.0,0.0,1.0,0.0),
          child: ProgressIndicatorDemo(-i.toDouble(),1.0),
        ),
      )
    );
  }

  return progressIndicators;
}

class ProgressIndicatorDemo extends StatefulWidget {
  
  final double start,end;

  ProgressIndicatorDemo(this.start,this.end);

  @override
  _ProgressIndicatorDemoState createState() => _ProgressIndicatorDemoState(start,end);
}

class _ProgressIndicatorDemoState extends State<ProgressIndicatorDemo> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  double start,end;
  int delay = Values.AUTO_PLAY_INTERVAL;

  _ProgressIndicatorDemoState(this.start,this.end);

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(milliseconds: delay*(end-start).toInt()),
      vsync: this,
    );
    animation = Tween(begin: start, end: end).animate(controller)
      ..addListener(() {
        setState(() {
          // the state that has changed here is the animation object’s value
        });
      });
    controller.forward();
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {}
    });
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
