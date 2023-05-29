import 'package:draggable_scrollable_example/component/restaurant_card.dart';
import 'package:flutter/material.dart';

const _googleMapsImage =
    'https://miro.medium.com/max/4064/1*qYUvh-EtES8dtgKiBRiLsA.png';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final DraggableScrollableController draggableScrollableController;
  bool isExpanded = false; //바텀시트가 맨 위까지 늘어나 있는지 검사
  double _menuOffset = 20;
  double menuSpreadRadius = 2;
  double menuBlurRadius = 25;
  List<String> list = ["쿠폰", "1인분", "배달비무료"];
  List<String> filters = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    draggableScrollableController = DraggableScrollableController();
    draggableScrollableController.addListener(listener);
  }

  void listener() {
    menuSpreadRadius = (-20 / 7) * draggableScrollableController.size + (20 / 7);
    menuBlurRadius = (-250 / 7) * draggableScrollableController.size + (250 / 7);
    if (draggableScrollableController.size >= 1) {
      setState(() {
        isExpanded = true;
      });
    } else {
      setState(() {
        isExpanded = false;
      });
    }
  }

  void _updateMenuOffset(double offset) {
    setState(() {
      _menuOffset = -offset + 20;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    draggableScrollableController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      body: SafeArea(
        child: Builder(builder: (context) {
          return Stack(
            children: [
              Positioned.fill(
                  bottom: MediaQuery.of(context).size.height * 0.3,
                  child: Image.network(
                    _googleMapsImage,
                    fit: BoxFit.cover,
                  )),
              Positioned.fill(
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (notification) {
                      if (notification is ScrollUpdateNotification) {
                        _updateMenuOffset(notification.metrics.pixels);
                      }
                      return false;
                    },
                    child: DraggableScrollableSheet(
                maxChildSize: 1,
                minChildSize: 0.3,
                initialChildSize: 0.3,
                controller: draggableScrollableController,
                builder:
                      (BuildContext context, ScrollController scrollController) {
                    return Material(
                      elevation: 10,
                      borderRadius: BorderRadius.circular(20),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Spacer(),
                                Container(
                                  width: 60,
                                  height: 4,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[600],
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                Spacer(),
                              ],
                            ),
                            SizedBox(
                              height: 100,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            RestaurantCard(
                              name: "엽기떡볶이 창전동점",
                              id: "asd4f6s868se-f-sdf6sa6df4se-d",
                              tags: ["엽떡", "이천떡볶이맛집", "매출왕"],
                              deliveryFee: 3000,
                              deliveryTime: 50,
                              image: Image.asset("assets/images/t_food.png"),
                              ratings: 4.8,
                              ratingsCount: 659,
                              isDetail: true,
                              detail:
                                  "이천 창전동점 동대문 옆기떢복이 입니다.\n\n모든 포장or배달에는 치즈+햄+유산균음료+단무지가 제공됩니다. \n\n주문접수 즉시 조리하는것을 원칙으로 "
                                  "조리시간이 떡볶이, 오뎅,반반정도 소요되며 닭볶음탕정도 소요됩니다. 시간걸리는점 양해부탁드리며 정성스럽게 따뜻하고"
                                  " 안전하게 보내드릴수있도록 노력하겠습니다.",
                            ),
                            SizedBox(
                              height: 150,
                            ),
                          ],
                        ),
                      ),
                    );
                },
              ),
                  )),
              Positioned(
                  top: _menuOffset,
                  left: 20,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            Scaffold.of(context).openDrawer();
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey,
                                              spreadRadius: menuSpreadRadius,
                                              blurRadius: menuBlurRadius),
                                        ],
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.circular(90)),
                              padding: EdgeInsets.all(12),
                              child: Icon(
                                Icons.menu,
                                color: Colors.white,
                              )),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        SizedBox(
                          height: 100,
                          child: SingleChildScrollView(
                            child: Row(
                              children: list.map((e) {
                                return Padding(
                                  padding: EdgeInsets.only(right: 8),
                                  child: ChoiceChip(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(300),
                                    ),
                                    backgroundColor: Colors.white,
                                    label: Text(
                                      e,
                                    ),
                                    selected: filters.contains(e),
                                    selectedColor: Colors.orange,
                                    onSelected: (bool selected) {
                                      setState(() {
                                        if (selected) {
                                          filters.add(e);
                                        } else {
                                          filters.remove(e);
                                        }
                                      });
                                    },
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        )
                      ],
                    ),
                  )),
              if (isExpanded)
                Positioned(
                  left: 16,
                  right: 16,
                  bottom: 16,
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(12)),
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                      child: Text(
                        "예약하기",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                )
            ],
          );
        }),
      ),
    );
  }
}
