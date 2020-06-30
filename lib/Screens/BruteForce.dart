import 'dart:async';
import 'package:algolizzzer/Configuration/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class BruteForce extends StatefulWidget {
  @override
  BruteForceState createState() => BruteForceState();
}

class BruteForceState extends State<BruteForce> {
  List<int> _numArray = [];
  StreamController<List<int>> _streamController = StreamController();
  double totalBars = 69;
  bool isSorting = false;
  bool isSorted = false;

  int cycle_startx = 0;
  int posx = 0;
  int cycleindex;
  int nextx = 0;
  bool b = false;

  int fbar = -1;
  int lbar = -1;
  int rstart = -1;
  int rend = -1;
  int swapbar1 = -1;
  int swapbar2 = -1;
  int extra1 = -1;
  int extra2 = -1;
  int extra3 = -1;
  int extra4 = -1;
  int extra5 = -1;

  int selected = 0;
  static int duration = 200;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Duration dur() {
    return Duration(microseconds: duration.floor());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    totalBars = MediaQuery.of(context).size.width / 2;
    for (int i = 0; i < totalBars; ++i) {
      _numArray.add(Random().nextInt(kheightbars));
    }
    setState(() {});
  }

  _buildArray() {
    isSorted = false;
    _numArray = [];

    for (int i = 0; i < totalBars; ++i) {
      int x = Random().nextInt(kheightbars);
      _numArray.add(x);
      print(x);
    }
    _streamController.add(_numArray);
  }

  resetOnSort() async {
    if (isSorted) {
      _buildArray();
      await Future.delayed(Duration(milliseconds: 200));
    }
  }

  _sort() async {
    setState(() {
      isSorting = true;
    });
    await resetOnSort();
    Stopwatch stopwatch = new Stopwatch()..start();

    if (selected == 0) {
      await Bubblesort();
    }
    if (selected == 1) {
      await Combsort();
    }
    if (selected == 2) {
      await Cyclesort();
    }
    if (selected == 3) {
      await Insertionsort();
    }

    if (selected == 4) {
      await Pancakesort();
    }
    if (selected == 5) {
      await Selectionsort();
    }

    stopwatch.stop();

    _scaffoldKey.currentState.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        backgroundColor: Colors.white70,
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Finished in ${stopwatch.elapsed.inMilliseconds} ms.",
              style: TextStyle(color: Colors.black87),
            ),
          ],
        ),
      ),
    );
    setState(() {
      isSorting = false;
      isSorted = true;
    });
  }

  Color getcolor() {
    if (selected == 0) {
      return kbscolor;
    }
    if (selected == 1) {
      return kcocolor;
    }
    if (selected == 2) {
      return kcycolor;
    }
    if (selected == 3) {
      return kincolor;
    }
    if (selected == 4) {
      return kpacolor;
    }
    if (selected == 5) {
      return ksecolor;
    }
  }

  Bubblesort() async {
    bool swapped;
    int N = totalBars.floor();
    do {
      extra1 = N - 1;

      await Future.delayed(dur(), () {});
      _streamController.add(_numArray);
      swapped = false;
      for (int i = 1; i < N; i++) {
        extra2 = i;

        await Future.delayed(dur(), () {});
        _streamController.add(_numArray);

        if (_numArray[i - 1] > _numArray[i]) {
          int temp = _numArray[i - 1];
          _numArray[i - 1] = _numArray[i];
          _numArray[i] = temp;
          swapped = true;

          //visualize{
          swapbar1 = i;
          swapbar2 = i - 1;
          await Future.delayed(dur(), () {});
          await Future.delayed(dur(), () {});
          await Future.delayed(dur(), () {});
          _streamController.add(_numArray);
          //}

        }
        swapbar1 = -1;
        swapbar2 = -1;
      }
      N--;
    } while (swapped);
  }

  Combsort() async {
    int gap = totalBars.floor();

    bool swapped = true;
    while (gap != 1 || swapped == true) {
      gap = ((gap * 10) ~/ 13);
      if (gap < 1) {
        gap = 1;
      }
      swapped = false;
      for (int i = 0; i < totalBars - gap; i++) {
        extra1 = i;
        await Future.delayed(dur(), () {});
        _streamController.add(_numArray);

        extra2 = i + gap;
        await Future.delayed(dur(), () {});
        _streamController.add(_numArray);

        if (_numArray[i] > _numArray[i + gap]) {
          int temp = _numArray[i];
          _numArray[i] = _numArray[i + gap];
          _numArray[i + gap] = temp;
          swapped = true;

          swapbar1 = i;
          swapbar2 = i + gap;
          await Future.delayed(dur(), () {});
          await Future.delayed(dur(), () {});
          await Future.delayed(dur(), () {});

          _streamController.add(_numArray);
        }
        swapbar1 = -1;
        swapbar2 = -1;
      }
    }
  }

  Cyclesort() async {
    int writes = 0;
    for (int cycle_start = 0;
        cycle_start <= _numArray.length - 2;
        cycle_start++) {
      int item = _numArray[cycle_start];
      int pos = cycle_start;

      extra1 = cycle_start;

      for (int i = cycle_start + 1; i < _numArray.length; i++) {
        extra2 = i;
        await Future.delayed(dur());
        _streamController.add(_numArray);
        if (_numArray[i] < item) pos++;
      }

      if (pos == cycle_start) {
        setState(() {
          cycle_startx = item;
          posx = pos;
        });

        extra1 = -1;
        continue;
      }

      while (item == _numArray[pos]) {
        pos++;
      }

      b = true;

      setState(() {
        nextx = _numArray[pos];
        posx = pos;
        cycle_startx = item;
        cycleindex = cycle_start;
      });

      int temp = item;
      item = _numArray[pos];
      _numArray[pos] = temp;

      writes++;

      swapbar1 = pos;
      swapbar2 = cycle_start;
      await Future.delayed(dur());
      await Future.delayed(dur());
      await Future.delayed(dur());
      _streamController.add(_numArray);
      swapbar1 = -1;
      swapbar2 = -1;

      while (pos != cycle_start) {
        pos = cycle_start;

        for (int i = cycle_start + 1; i < _numArray.length; i++) {
          extra2 = i;
          await Future.delayed(dur());
          _streamController.add(_numArray);

          if (_numArray[i] < item) pos += 1;
        }

        while (item == _numArray[pos]) {
          pos += 1;
        }

        setState(() {
          nextx = _numArray[pos];
          posx = pos;
          cycle_startx = item;
          cycleindex = cycle_start;
        });

        int temp = item;
        item = _numArray[pos];
        _numArray[pos] = temp;
        writes++;

        swapbar1 = pos;
        swapbar2 = cycle_start;
        await Future.delayed(dur());
        await Future.delayed(dur());
        await Future.delayed(dur());
        _streamController.add(_numArray);
        swapbar1 = -1;
        swapbar2 = -1;
      }
    }
  }

  String getcytext() {
    String str;

    List<int> nos = [];
    for (int i in _numArray) nos.add(i);

    if (isSorting) {
      if (selected == 2) {
        if (posx == cycleindex) {
          str = "Rewrote ${nos[posx]} to $posx";
        } else {
          str = "Rewrote $cycle_startx to index $posx; next value:$nextx";
        }
      } else {
        str = " ";
      }
    } else
      str = " ";

    return str;
  }

  Insertionsort() async {
    for (int i = 1; i < totalBars.floor(); i++) {
      int key = _numArray[i];

      extra1 = i;
      await Future.delayed(dur(), () {});
      _streamController.add(_numArray);

      int j;
      for (j = i - 1; (j >= 0 && _numArray[j] > key); j--) {
        extra2 = j;
        await Future.delayed(dur(), () {});
        await Future.delayed(dur(), () {});
        _streamController.add(_numArray);

        _numArray[j + 1] = _numArray[j];
      }
      _numArray[j + 1] = key;
    }
  }

  Pancakesort() async {
    int curr_size = totalBars.floor();

    while (curr_size > 1) {
      extra1 = curr_size - 1;
      int mi = 0;

      for (int i = 0; i < curr_size; i++) {
        extra3 = i;
        if (_numArray[i] > _numArray[mi]) {
          mi = i;
        }

        extra2 = mi;

        await Future.delayed(dur(), () {});
        _streamController.add(_numArray);
      }
      extra3 = -1;
      extra2 = -1;

      rstart = 0;
      rend = mi;

      if (mi != curr_size) {
//     await panflip(mi);
        int start = 0;
        while (start < mi) {
          swapbar1 = mi;
          swapbar2 = start;

          int temp = _numArray[start];
          _numArray[start] = _numArray[mi];
          _numArray[mi] = temp;
          start++;
          mi--;

          await Future.delayed(dur(), () {});
          await Future.delayed(dur(), () {});
          await Future.delayed(dur(), () {});
          _streamController.add(_numArray);
        }

        rstart = 0;
        rend = curr_size - 1;

//       await panflip(curr_size-1)
        start = 0;
        int x = curr_size - 1;
        while (start < x) {
          int temp = _numArray[start];
          _numArray[start] = _numArray[x];
          _numArray[x] = temp;
          start++;
          x--;

          swapbar1 = x;
          swapbar2 = start;
          await Future.delayed(dur(), () {});
          await Future.delayed(dur(), () {});

          _streamController.add(_numArray);
        }
        swapbar1 = -1;
        swapbar2 = -1;
        rstart = -1;
        rend = -1;
      }
      curr_size--;
    }
  }

  Selectionsort() async {
    for (int i = 0; i < _numArray.length - 1; i++) {
      int minJ = i;

      extra1 = i;
      await Future.delayed(dur(), () {});
      _streamController.add(_numArray);

      for (int j = i + 1; j < _numArray.length; j++) {
        extra2 = j;
        await Future.delayed(dur(), () {});
        _streamController.add(_numArray);

        if (_numArray[minJ] > _numArray[j]) {
          int temp = _numArray[j];
          _numArray[j] = _numArray[i];
          _numArray[i] = temp;
          swapbar1 = i;
          swapbar2 = j;
          await Future.delayed(dur(), () {});
          await Future.delayed(dur(), () {});
          _streamController.add(_numArray);
          swapbar1 = -1;
          swapbar2 = -1;
        }

        await Future.delayed(dur(), () {});
        _streamController.add(_numArray);
      }
      await Future.delayed(dur(), () {});
      _streamController.add(_numArray);
    }
  }

  @override
  void dispose() {
    _streamController.close();

    super.dispose();
  }

  Color barsco(int num) {
    num--;

    if (selected == 0) {
      if (isSorted) {
        return kbscolor;
      } else if (!isSorting) {
        return Colors.white70;
      }

      if (swapbar1 == num || swapbar2 == num) return kbsswap;
      if (num == extra1) return kbsdark;
      if (num == extra2) return kbsiter;
      if (num != swapbar1 && num != swapbar2 && num != extra1 && num != extra2)
        return kbscolor;
    }
    if (selected == 1) {
      if (isSorted) {
        return kcocolor;
      } else if (!isSorting) {
        return Colors.white70;
      }
      if (num == swapbar1 || num == swapbar2) return kcoswap;
      if (num == extra1 || num == extra2) return kcodark;
      if (num != swapbar1 && num != swapbar2 && num != extra1 && num != extra2)
        return kcocolor;
    }
    if (selected == 2) {
      if (isSorted) {
        return kcycolor;
      } else if (!isSorting) {
        return Colors.white70;
      }
      if (swapbar1 == num || swapbar2 == num) return kcyswap;
      if (extra1 == num) return kcydark;
      if (extra2 == num) return kcydark;
      if (extra1 != num && extra2 != num) return kcycolor;
    }
    if (selected == 3) {
      if (isSorted) {
        return kincolor;
      } else if (!isSorting) {
        return Colors.white70;
      }
      if (extra1 == num) return kinsec;
      if (extra2 == num) return kindark;
      if (extra1 != num && extra2 != num) return kincolor;
    }
    if (selected == 4) {
      if (isSorted) {
        return kpacolor;
      } else if (!isSorting) {
        return Colors.white70;
      }
      if (num == swapbar1 || num == swapbar2) return kpaswap;
      if (rstart <= num && num <= rend) return kpadark;
      if (num == extra1) return kpandark;
      if (num == extra2) return kpamax;
      if (num == extra3) return kpanvdark;

      if (num != rstart &&
          num != rend &&
          num != extra1 &&
          num != extra3 &&
          num != extra2 &&
          num != swapbar2 &&
          num != swapbar1) return kpacolor;
    }
    if (selected == 5) {
      if (isSorted) {
        return ksecolor;
      } else if (!isSorting) {
        return Colors.white70;
      }

      if (swapbar1 == num || swapbar2 == num) return kseswap;
      if (extra1 == num || extra2 == num) return ksedark;

      if (num != extra1 && num != extra2 && num != swapbar1 && num != swapbar2)
        return ksecolor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        key: _scaffoldKey,
        backgroundColor: kbackgndColor,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              //=================================================================================BARS==================================================================================================
              Container(
                padding: const EdgeInsets.only(top: 0.0),
                child: StreamBuilder<Object>(
                    initialData: _numArray,
                    stream: _streamController.stream,
                    builder: (context, snapshot) {
                      List<int> numbers = snapshot.data;
                      int ind = 0;
                      return Row(
                        children: _numArray.map((int num) {
                          ind++;
                          return Padding(
                            padding: const EdgeInsets.only(left: 0.2),
                            child: Container(
                              child: CustomPaint(
                                painter: BarPainter(
                                  width: (MediaQuery.of(context).size.width -
                                          0.2 * totalBars +
                                          0.2) /
                                      totalBars,
                                  height: num,
                                  index: ind,
                                  colour: barsco(ind),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    }),
              ),
              //==============================================================================SETTINGS COLUMN=========================================================================
              Column(
                children: <Widget>[
//                  Row(
//                    children: <Widget>[
//                      Text(
//                        "Color bar: ",
//                        style: TextStyle(color: Colors.white54),
//                      ),
//                      Container(
//                        height: 10,
//                        width: 10,
//                        color: getcolor(),
//                      )
//                    ],
//                  ),

                  Text(getcytext(), style: TextStyle(color: Colors.white54)),
                  //=========================================================================SPEED SLIDER===============================================================================
                  CupertinoPicker(
                      itemExtent: 50,
                      onSelectedItemChanged: isSorting
                          ? null
                          : (int i) {
                              setState(() {
                                _buildArray();
                                selected = i;
                              });
                            },
                      children: <Widget>[
                        Text("BUBBLE SORT",
                            style: TextStyle(
                                color:
                                    selected == 0 ? getcolor() : kbuttonbackgnd,
                                fontSize: kfontsizename,
                                fontWeight: FontWeight.bold)),
                        Text("COMB SORT",
                            style: TextStyle(
                                color:
                                    selected == 1 ? getcolor() : kbuttonbackgnd,
                                fontSize: kfontsizename,
                                fontWeight: FontWeight.bold)),
                        Text("CYCLE SORT",
                            style: TextStyle(
                                color:
                                    selected == 2 ? getcolor() : kbuttonbackgnd,
                                fontSize: kfontsizename,
                                fontWeight: FontWeight.bold)),
                        Text("INSERTION SORT",
                            style: TextStyle(
                                color:
                                    selected == 3 ? getcolor() : kbuttonbackgnd,
                                fontSize: kfontsizename,
                                fontWeight: FontWeight.bold)),
                        Text("PANCAKE SORT",
                            style: TextStyle(
                                color:
                                    selected == 4 ? getcolor() : kbuttonbackgnd,
                                fontSize: kfontsizename,
                                fontWeight: FontWeight.bold)),
                        Text("SELECTION SORT",
                            style: TextStyle(
                                color:
                                    selected == 5 ? getcolor() : kbuttonbackgnd,
                                fontSize: kfontsizename,
                                fontWeight: FontWeight.bold)),
                      ]),

                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        child: Text(
                          "DURATION : ",
                          style: TextStyle(color: getcolor()),
                        ),
                      ),
                      Expanded(
                        child: Slider.adaptive(
                          divisions: divs,
                          value: duration.ceilToDouble(),
                          onChanged: (val) {
                            setState(() {
                              duration = val.floor();

//                            fun();
                            });
                            print(val);
                          },
                          activeColor: getcolor(),
                          inactiveColor: kbuttonbackgnd,
                          max: kspeedmax,
                          min: kspeedmin,
                        ),
                      )
                    ],
                  ),
                  //=========================================================================BARS SLIDER===============================================================================
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        child: Text(
                          "SIZE            : ",
                          style: TextStyle(color: getcolor()),
                        ),
                      ),
                      Expanded(
                        child: Slider.adaptive(
                          label: '${totalBars.toInt()}',
                          value: totalBars.ceilToDouble(),
                          onChanged: isSorting
                              ? null
                              : (val) {
                                  setState(() {
                                    totalBars = val.floor().ceilToDouble();
                                    _buildArray();
//                                    fbar = 0;
//                                    lbar = 0;
                                  });
                                  print(val);
                                },
                          activeColor: getcolor(),
                          inactiveColor: kbuttonbackgnd,
                          max: kmax,
                          min: kmin,
                          divisions: 215,
                        ),
                      )
                    ],
                  ),
//            =========================================================================THE BUILD AND SORT BUTTONS=================================================================================
                  Container(
                    decoration: BoxDecoration(
                      color: kbuttonbackgnd,
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: FlatButton(
                            onPressed: isSorting ? null : _buildArray,
                            child: Text(
                              "Build",
                              style: TextStyle(
                                  color: isSorting ? null : getcolor(),
                                  fontSize: 15),
                            ),
                          ),
                        ),
                        Expanded(
                          child: FlatButton(
                            onPressed: isSorting ? null : _sort,
                            child: Text(
                              "Sort",
                              style: TextStyle(
                                  color: isSorting ? null : getcolor(),
                                  fontSize: 15),
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
        ),
      ),
    );
  }
}

class BarPainter extends CustomPainter {
  final double width;
  final int height;
  final int index;
  final Color colour;

  BarPainter({this.height, this.index, this.width, this.colour});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = colour;
    paint.strokeCap = StrokeCap.square;
    paint.strokeWidth = width;

    canvas.drawLine(Offset(index * width, 0),
        Offset(index * width, height.ceilToDouble()), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
