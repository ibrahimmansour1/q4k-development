import 'package:flutter/material.dart';

import 'cubit/answer_cubit.dart';

Color appColor = const Color(0xff17234d);
List questionThatAnswered = [];

class PageViewScreen extends StatefulWidget {
  const PageViewScreen(
      {Key? key,
      required this.snapshot,
      required this.department,
      required this.subject})
      : super(key: key);
  final dynamic snapshot;
  final dynamic department;
  final dynamic subject;

  @override
  State<PageViewScreen> createState() => _PageViewScreenState();
}

class _PageViewScreenState extends State<PageViewScreen> {
  final _pageViewController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageViewController,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (_, i) {
        return Scaffold(

          body: Stack(
            children: [
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: appColor,
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(50),
                          bottomRight: Radius.circular(50),
                        )),
                    height: MediaQuery.of(context).size.height * 0.15,
                  ),
                ],
              ),
              Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            boxShadow: kElevationToShadow[4],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        padding: const EdgeInsetsDirectional.all(15.0),
                        margin: EdgeInsetsDirectional.only(
                          top:widget.snapshot.data.docs[i]['url'] !=null? MediaQuery.of(context).size.height * 0.05:MediaQuery.of(context).size.height *0.10,
                          start: 20,
                          end: 20,
                        ),

                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            if(widget.snapshot.data.docs[i]['url'] !=null)
                              Container(
                                padding: EdgeInsetsDirectional.only(top: 30.0),
                                child: Image.network(widget.snapshot.data.docs[i]['url']
                                ),
                              ),
                            Text(
                              '${widget.snapshot.data.docs[i]['question']}',
                              style: TextStyle(
                                fontSize: widget.snapshot.data.docs[i]
                                    ['fontSizeOfQuestion'],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                          top:widget.snapshot.data.docs[i]['url'] !=null? MediaQuery.of(context).size.height * 0.03:MediaQuery.of(context).size.height * 0.03,
                          left: MediaQuery.of(context).size.width * 0.45,
                          child: Container(
                            decoration: BoxDecoration(
                                boxShadow: kElevationToShadow[4],
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            padding: const EdgeInsetsDirectional.all(20.0),
                            child: Text(
                              '${i + 1}/${widget.snapshot.data.docs.length}',
                              style: TextStyle(color: appColor),
                            ),
                          )),
                    ],
                  ),
                  Expanded(
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              questionThatAnswered.add(
                                  widget.snapshot.data.docs[i]['question']);
                            });
                            if (_pageViewController.page! < widget.snapshot.data.docs.length-1) {
                              Future.delayed(Duration(milliseconds: 500)).then((value) {
                                _pageViewController.nextPage(
                                    duration: const Duration(milliseconds: 700),
                                    curve: Curves.fastLinearToSlowEaseIn);
                              });

                            }

                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsetsDirectional.only(
                                end: 20, start: 20, top: 10, bottom: 10),
                            padding: const EdgeInsetsDirectional.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: questionThatAnswered.contains(
                                      widget.snapshot.data.docs[i]['question'])
                                  ? Border.all(
                                      color: widget.snapshot.data.docs[i]
                                                  ['answerInIndex'] ==
                                              0
                                          ? Colors.green
                                          : Colors.red,
                                      width: 5)
                                  : null,
                              color: Colors.white,
                              boxShadow: kElevationToShadow[4],
                            ),
                            child: Text(
                              '${widget.snapshot.data.docs[i]['answers'][0]}',
                              style: TextStyle(
                                fontSize: widget.snapshot.data.docs[i]
                                    ['fontSizeOfAnswers'],
                              ),
                            ),
                          ),
                        ),
                        //   SizedBox(height: 2,),
                        InkWell(
                          onTap: () {
                            setState(() {
                              questionThatAnswered.add(
                                  widget.snapshot.data.docs[i]['question']);
                            });
                            if (_pageViewController.page! < widget.snapshot.data.docs.length-1) {
                              Future.delayed(Duration(milliseconds: 500)).then((value) {
                                _pageViewController.nextPage(
                                    duration: const Duration(milliseconds: 700),
                                    curve: Curves.fastLinearToSlowEaseIn);
                              });

                            }
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsetsDirectional.only(
                                end: 20, start: 20, top: 10, bottom: 10),
                            padding: const EdgeInsetsDirectional.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: questionThatAnswered.contains(
                                      widget.snapshot.data.docs[i]['question'])
                                  ? Border.all(
                                      color: widget.snapshot.data.docs[i]
                                                  ['answerInIndex'] ==
                                              1
                                          ? Colors.green
                                          : Colors.red,
                                      width: 5)
                                  : null,
                              color: Colors.white,
                              boxShadow: kElevationToShadow[4],
                            ),
                            child: Text(
                              '${widget.snapshot.data.docs[i]['answers'][1]}',
                              style: TextStyle(
                                fontSize: widget.snapshot.data.docs[i]
                                    ['fontSizeOfAnswers'],
                              ),
                            ),
                          ),
                        ),
                        //  SizedBox(height:5,),
                        if (widget.snapshot.data.docs[i]['answers'][2] != '')
                          InkWell(
                            onTap: () {
                              setState(() {
                                questionThatAnswered.add(
                                    widget.snapshot.data.docs[i]['question']);
                              });
                              if (_pageViewController.page! < widget.snapshot.data.docs.length-1) {
                                Future.delayed(const Duration(milliseconds: 500)).then((value) {
                                  _pageViewController.nextPage(
                                      duration: const Duration(milliseconds: 700),
                                      curve: Curves.fastLinearToSlowEaseIn);
                                });

                              }
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsetsDirectional.only(
                                  end: 20, start: 20, top: 10, bottom: 10),
                              padding: const EdgeInsetsDirectional.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: questionThatAnswered.contains(widget
                                        .snapshot.data.docs[i]['question'])
                                    ? Border.all(
                                        color: widget.snapshot.data.docs[i]
                                                    ['answerInIndex'] ==
                                                2
                                            ? Colors.green
                                            : Colors.red,
                                        width: 5)
                                    : null,
                                color: Colors.white,
                                boxShadow: kElevationToShadow[4],
                              ),
                              child: Text(
                                '${widget.snapshot.data.docs[i]['answers'][2]}',
                                style: TextStyle(
                                  fontSize: widget.snapshot.data.docs[i]
                                      ['fontSizeOfAnswers'],
                                ),
                              ),
                            ),
                          ),
                        //  SizedBox(
                        //     height: 10,
                        //   ),
                        if (widget.snapshot.data.docs[i]['answers'][3] != '')
                          InkWell(
                            onTap: () {
                              setState(() {
                                questionThatAnswered.add(
                                    widget.snapshot.data.docs[i]['question']);
                              });
                              if (_pageViewController.page! < widget.snapshot.data.docs.length-1) {
                                Future.delayed(const Duration(milliseconds: 500)).then((value) {
                                  _pageViewController.nextPage(
                                      duration: const Duration(milliseconds: 700),
                                      curve: Curves.fastLinearToSlowEaseIn);
                                });

                              }
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsetsDirectional.only(
                                  end: 20, start: 20, top: 10, bottom: 10),
                              padding: const EdgeInsetsDirectional.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: questionThatAnswered.contains(widget
                                        .snapshot.data.docs[i]['question'])
                                    ? Border.all(
                                        color: widget.snapshot.data.docs[i]
                                                    ['answerInIndex'] ==
                                                3
                                            ? Colors.green
                                            : Colors.red,
                                        width: 5)
                                    : null,
                                color: Colors.white,
                                boxShadow: kElevationToShadow[4],
                              ),
                              child: Text(
                                '${widget.snapshot.data.docs[i]['answers'][3]}',
                                style: TextStyle(
                                  fontSize: widget.snapshot.data.docs[i]
                                      ['fontSizeOfAnswers'],
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
      itemCount: widget.snapshot.data.docs.length,
    );
  }
}
