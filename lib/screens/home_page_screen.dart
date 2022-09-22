import 'package:flutter/material.dart';

import '../helper/colors.dart' as color;
import '../widgets/flutter_wifi_iot.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

final List<String> devicesList = [];

class _HomePageScreenState extends State<HomePageScreen> {
  bool _addDevice = false;

  addDevices() {
    Navigator.of(context).pushNamed('/select_device');
    setState(() {
      if (_addDevice) {
        devicesList.add("Device ${devicesList.length + 1}");
      }
    });
  }

  devices(width, height) {
    return Container(
      width: width,
      height: height * 0.25,
      padding: const EdgeInsets.only(left: 5, right: 5, bottom: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              color.AppColor.gradientFirst,
              color.AppColor.gradientSecond
            ]),
      ),
      child: Column(children: [
        Row(children: [
          Expanded(
            child: Text('Select Device',
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 14,
                  color: color.AppColor.pageTitleSecondColor,
                  fontWeight: FontWeight.bold,
                )),
          ),
          IconButton(
            icon: const Icon(Icons.add),
            color: color.AppColor.pageIconSecondColor,
            onPressed: addDevices,
          )
        ]),
        Expanded(
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: devicesList.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  width: 120,
                  margin: const EdgeInsets.only(right: 5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: GridTile(
                        child: Icon(Icons.smart_toy_outlined, size: 110),
                        footer: GridTileBar(
                          backgroundColor: Colors.black.withOpacity(0.7),
                          title: Text(devicesList[index],
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyText2),
                        )),
                  ),
                );
              }),
        ),
      ]),
    );
  }

  detailsFirstFunction(width, color, icon, iconcolor, data, name) {
    return Container(
      width: (width / 2) - 15,
      height: 110,
      padding: const EdgeInsets.all(5),
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
        Padding(
          padding: const EdgeInsets.only(top: 5, right: 5),
          child: Icon(icon, color: iconcolor),
        ),
        SizedBox(
          width: width,
          child: Text(data,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 34,
              )),
        ),
        Container(
          padding: const EdgeInsets.only(left: 5, bottom: 5),
          width: width,
          child: Text(name,
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontSize: 14,
              )),
        ),
      ]),
    );
  }

  detailsSecondFunction(width, color, iconcolor, icon, name) {
    return Container(
      width: width,
      height: 110,
      padding: const EdgeInsets.all(5),
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
        Padding(
          padding: const EdgeInsets.only(top: 5, right: 5),
          child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            Icon(
              Icons.wb_sunny_outlined,
              color: iconcolor,
            ),
            const SizedBox(width: 10),
            Icon(
              Icons.water_drop_outlined,
              color: iconcolor,
            ),
          ]),
        ),
        SizedBox(
          width: width,
          child: Icon(
            icon,
            color: iconcolor,
            size: 45,
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 5, bottom: 5),
          width: width,
          child: Text(name,
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontSize: 14,
              )),
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: color.AppColor.pageBackground,
        title: const Text('Temp & Humidity Logger'),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle_sharp),
            iconSize: 45,
            color: color.AppColor.pageIconFirstColor,
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          devices(width, height),
          Column(children: [
            Container(
              width: width,
              padding: const EdgeInsets.all(10),
              child: Text('Device 1',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 14,
                    color: color.AppColor.pageTitleFirstColor,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              detailsFirstFunction(
                width,
                color.AppColor.pageContainerFirstColor,
                Icons.wb_sunny_outlined,
                color.AppColor.pageIconSecondColor,
                '23.45 \u00B0C',
                'Temperature',
              ),
              detailsFirstFunction(
                width,
                color.AppColor.pageContainerSecondColor,
                Icons.water_drop_outlined,
                color.AppColor.pageIconSecondColor,
                '71%',
                'Humidity',
              ),
            ]),
            const SizedBox(height: 10),
            detailsSecondFunction(
              width - 20,
              color.AppColor.pageContainerThirdColor,
              color.AppColor.pageIconSecondColor,
              Icons.area_chart_outlined,
              'Temperature & Humidity',
            ),
            const SizedBox(height: 10),
            detailsSecondFunction(
              width - 20,
              color.AppColor.pageContainerFourthColor,
              color.AppColor.pageIconSecondColor,
              Icons.settings,
              'Settings',
            ),
          ]),
        ]),
      ),
    );
  }
}
