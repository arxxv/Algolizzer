import 'dart:async';
import 'package:algolizzzer/Configuration/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class DivideandConquer extends StatefulWidget {
  @override
  DivideandConquerState createState() => DivideandConquerState();
}

class DivideandConquerState extends State<DivideandConquer> {
  List<int> _numArray = [];
  StreamController<List<int>> _streamController = StreamController();
  double totalBars = 69;
  bool isSorting = false;
  bool isSorted = false;

  int fbar = -1;
  int lbar = -1;
  int rstart = -1;
  int rend = -1;
//  int bac=-1;

  bool fbarbool = false;
  bool lbarbool = false;
  bool rstartbool = false;
  bool rendbool = false;

  var loc = 0;

  int selected = 0;
//  double speed = 1/duration;
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
//    fbar = null;
//    lbar = null;
    isSorted = false;
    _numArray = [];

    for (int i = 0; i < totalBars; ++i) {
      _numArray.add(Random().nextInt(kheightbars));
    }

    _streamController.add(_numArray);
  }

  resetOnSort() async {
//    fbar = null;
//    lbar = null;
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
      await Mergesort(0, totalBars.floor() - 1);
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
    fbarbool = false;
    lbarbool = false;
    lbar = -1;
    rstartbool = false;

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
//    fbar = null;
//    lbar = null;
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

  Selectionsort() async {
    for (int i = 0; i < _numArray.length - 1; i++) {
      int minJ = i;
      fbarbool = true;
      fbar = i;
      await Future.delayed(dur(), () {});
      _streamController.add(_numArray);

      for (int j = i + 1; j < _numArray.length; j++) {
        lbarbool = true;
        lbar = j;
        await Future.delayed(dur(), () {});
        _streamController.add(_numArray);

        if (_numArray[minJ] > _numArray[j]) {
          int temp = _numArray[j];
          _numArray[j] = _numArray[i];
          _numArray[i] = temp;
        }

        await Future.delayed(dur(), () {});
        _streamController.add(_numArray);
      }
      await Future.delayed(dur(), () {});
      _streamController.add(_numArray);
    }
//    for (int i = 0; i < _numArray.length; i++) {
//      for (int j = i + 1; j < _numArray.length; j++) {
//        if (_numArray[i] > _numArray[j]) {
//          int temp = _numArray[j];
//          _numArray[j] = _numArray[i];
//          _numArray[i] = temp;
//        }
//
//        await Future.delayed(dur(), () {});
//        _streamController.add(_numArray);
//      }
//      await Future.delayed(dur(), () {});
//      _streamController.add(_numArray);
//    }
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
        fbarbool = true;
        fbar = i;
        await Future.delayed(dur(), () {});
        _streamController.add(_numArray);

        lbarbool = true;
        lbar = i + gap;
        await Future.delayed(dur(), () {});
        _streamController.add(_numArray);

        if (_numArray[i] > _numArray[i + gap]) {
          int temp = _numArray[i];
          _numArray[i] = _numArray[i + gap];
          _numArray[i + gap] = temp;
          swapped = true;
        }

//        await Future.delayed(dur(), () {});
//        _streamController.add(_numArray);
      }
//      await Future.delayed(dur(), () {});
//      _streamController.add(_numArray);
    }
  }

  Cyclesort() async {
    int writes = 0;
    for (int cycle_start = 0;
        cycle_start <= _numArray.length - 2;
        cycle_start++) {
      int item = _numArray[cycle_start];
      int pos = cycle_start;
      fbarbool = true;
      fbar = cycle_start;
      for (int i = cycle_start + 1; i < _numArray.length; i++) {
        lbarbool = true;
        lbar = i;
        await Future.delayed(dur());
        _streamController.add(_numArray);
        if (_numArray[i] < item) pos++;
      }

      if (pos == cycle_start) {
        continue;
      }

      while (item == _numArray[pos]) {
        pos += 1;
      }

      if (pos != cycle_start) {
        int temp = item;
        item = _numArray[pos];
        _numArray[pos] = temp;
        writes++;
      }

      while (pos != cycle_start) {
        pos = cycle_start;

        for (int i = cycle_start + 1; i < _numArray.length; i++) {
          lbarbool = true;
          lbar = i;
          await Future.delayed(dur());
          _streamController.add(_numArray);

          if (_numArray[i] < item) pos += 1;
          //=======================================

        }

        while (item == _numArray[pos]) {
          pos += 1;
        }

        if (item != _numArray[pos]) {
          int temp = item;
          item = _numArray[pos];
          _numArray[pos] = temp;
          writes++;
        }
      }
    }
  }

  Mergesort(int l, int r) async {
    Future<void> merge(int l, int m, int r) async {
      int L = m - l + 1;
      int R = r - m;

      List LL = new List(L);
      List RL = new List(R);

      for (int i = 0; i < L; i++) LL[i] = _numArray[l + i];
      for (int j = 0; j < R; j++) RL[j] = _numArray[m + j + 1];

      int i = 0, j = 0;
      int k = l;

      while (i < L && j < R) {
        if (LL[i] <= RL[j]) {
          _numArray[k] = LL[i];
          i++;
        } else {
          _numArray[k] = RL[j];
          j++;
        }

        await Future.delayed(dur(), () {});
        _streamController.add(_numArray);

        k++;
      }

      while (i < L) {
        _numArray[k] = LL[i];
        i++;
        k++;

        await Future.delayed(dur(), () {});
        _streamController.add(_numArray);
      }

      while (j < R) {
        _numArray[k] = RL[j];
        j++;
        k++;

        await Future.delayed(dur(), () {});
        _streamController.add(_numArray);
      }
    }

    if (l < r) {
      int m = (r + l) ~/ 2;

      await Mergesort(l, m);
      await Mergesort(m + 1, r);

      await Future.delayed(dur(), () {});

      _streamController.add(_numArray);

      await merge(l, m, r);
    }
  }

  Insertionsort() async {
    for (int i = 1; i < totalBars.floor(); i++) {
      int key = _numArray[i];
      fbarbool = true;
      fbar = i;
      await Future.delayed(dur(), () {});
      _streamController.add(_numArray);
      int j;
      for (j = i - 1; (j >= 0 && _numArray[j] > key); j--) {
        lbarbool = true;
        lbar = j;
        _numArray[j + 1] = _numArray[j];
        await Future.delayed(dur(), () {});
        _streamController.add(_numArray);
      }
      _numArray[j + 1] = key;
    }

//    for (int i = 0; i < totalBars; i++) {
//      int key = _numArray[i];
//      int j = i - 1;
//
//      while (j >= 0 && _numArray[j] > key) {
//        _numArray[j + 1] = _numArray[j];
//        j = j - 1;
//        await Future.delayed(dur(), () {});
//        _streamController.add(_numArray);
//      }
//      await Future.delayed(dur(), () {});
//      _streamController.add(_numArray);
//      _numArray[j + 1] = key;
//    }
  }

//  panflip(i) async {
//    int start = 0;
//
//    while (start < i) {
//      int temp = _numArray[start];
//      _numArray[start] = _numArray[i];
//      _numArray[i] = temp;
//      start++;
//      i--;
//
//      fbarbool = true;
//      lbarbool = true;
//      fbar = i;
//      lbar = start;
//      await Future.delayed(dur(), () {});
//      _streamController.add(_numArray);
//    }
//  }

  Pancakesort() async {
    int curr_size = totalBars.floor();

    while (curr_size > 1) {
      int mi = 0;

      for (int i = 0; i < curr_size; i++) {
        if (_numArray[i] > _numArray[mi]) {
          mi = i;
        }

        rstartbool = true;
        rstart = mi;
        await Future.delayed(dur(), () {});
        _streamController.add(_numArray);

//        rendbool = false;
//        rend = -1;
//        await Future.delayed(dur(), () {});
//        _streamController.add(_numArray);
      }
      rendbool = true;
      rend = curr_size - 1;
      rstartbool = false;

      if (mi != curr_size) {
//     await panflip(mi);
        int start = 0;
        while (start < mi) {
          int temp = _numArray[start];
          _numArray[start] = _numArray[mi];
          _numArray[mi] = temp;
          start++;
          mi--;

          fbarbool = true;
          lbarbool = true;
          fbar = mi;
          lbar = start;

          await Future.delayed(dur(), () {});
          _streamController.add(_numArray);
        }
//       await panflip(curr_size-1)
        start = 0;
        int x = curr_size - 1;
        while (start < x) {
          int temp = _numArray[start];
          _numArray[start] = _numArray[x];
          _numArray[x] = temp;
          start++;
          x--;

          fbarbool = true;
          lbarbool = true;
          fbar = x;
          lbar = start;
          await Future.delayed(dur(), () {});
          _streamController.add(_numArray);
        }
      }
      curr_size--;
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
      } else if (!fbarbool) {
        return Colors.white70;
      } else if (fbarbool && !lbarbool) {
        if (fbar == num) {
          return Colors.red;
        } else {
          return kbscolor;
        }
      } else if (fbarbool && lbarbool) {
        if (num == fbar || num == lbar) {
          return Colors.red;
        } else {
          return kbscolor;
        }
      }
    }
    if (selected == 1) {
      if (isSorted) {
        return kcocolor;
      } else if (!fbarbool) {
        return Colors.white70;
      } else if (fbarbool && !lbarbool) {
        if (fbar == num) {
          return kcodark;
        } else {
          return kcocolor;
        }
      } else if (fbarbool && lbarbool) {
        if (num == fbar || num == lbar) {
          return kcodark;
        } else {
          return kcocolor;
        }
      }
    }
    if (selected == 2) {
      if (isSorted) {
        return kcycolor;
      } else if (!fbarbool) {
        return Colors.white70;
      } else if (fbarbool && !lbarbool) {
        if (num == fbar) {
          return kcydark;
        } else {
          return kcycolor;
        }
      } else if (fbarbool && lbarbool) {
        if (num == fbar || num == lbar) {
          return kcydark;
        } else {
          return kcycolor;
        }
      }
    }
    if (selected == 3) {
      if (isSorted) {
        return kincolor;
      } else if (!fbarbool) {
        return Colors.white70;
      } else if (fbarbool && !lbarbool) {
        if (num == fbar) {
          return kindark;
        } else {
          return kincolor;
        }
      } else if (fbarbool && lbarbool) {
        if (num == fbar || num == lbar) {
          return kindark;
        } else {
          return kincolor;
        }
      }
    }

    if (selected == 4) {
      if (isSorted) {
        return kpacolor;
      } else if (!isSorting) {
        return Colors.white70;
      } else if (rendbool) {
        if (num == rend) {
          return kpandark;
        } else if (rstartbool) {
          if (num == rstart) {
            return Colors.red;
          } else {
            return kpacolor;
          }
        } else if ((fbarbool && lbarbool)) {
          if (num == fbar || num == lbar) {
            return kpadark;
          } else {
            return kpacolor;
          }
        } else {
          return kpacolor;
        }
      } else if ((fbarbool && lbarbool)) {
        if (num == fbar || num == lbar) {
          return kpadark;
        } else {
          return kpacolor;
        }
      }
    }
    if (selected == 5) {
      if (isSorted) {
        return ksecolor;
      } else if (!fbarbool) {
        return Colors.white70;
      } else if (fbarbool && !lbarbool) {
        if (num == fbar) {
          return ksedark;
        } else {
          return ksecolor;
        }
      } else if (fbarbool && lbarbool) {
        if (num == fbar || num == lbar) {
          return ksedark;
        } else {
          return ksecolor;
        }
      }
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
                        Text("MERGE SORT",
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
  final double loc;

  BarPainter({this.height, this.index, this.width, this.colour, this.loc});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = colour;
    paint.strokeCap = StrokeCap.round;
    paint.strokeWidth = width;

    canvas.drawLine(Offset(index * width, 0),
        Offset(index * width, height.ceilToDouble()), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
