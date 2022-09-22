// ignore_for_file: deprecated_member_use, package_api_docs, public_member_api_docs
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wifi_iot/wifi_iot.dart';

import '../helper/colors.dart' as color;
// import 'dart:io' show Platform;

class SelectInternet extends StatefulWidget {
  @override
  _SelectInternetState createState() => _SelectInternetState();
}

class _SelectInternetState extends State<SelectInternet> {
  static const routeName = '/select_internet';

  List<WifiNetwork> _htResultNetwork = [];
  bool _isEnabled = false;
  bool _isConnected = false;
  String ssid = "";
  String ssidpasscord = "";
  String ssidActive = "";
  String nameStartWith = "Temp_&_Humidity_";
  var _textFieldController = TextEditingController();
  @override
  initState() {
    getWifis();
    super.initState();
  }

  // Future<List<APClient>> getClientList(
  //     bool onlyReachables, int reachableTimeout) async {
  //   List<APClient> htResultClient;
  //   try {
  //     htResultClient = await WiFiForIoTPlugin.getClientList(
  //         onlyReachables, reachableTimeout);
  //   } on PlatformException {
  //     htResultClient = <APClient>[];
  //   }

  //   return htResultClient;
  // }

  showDialogBox(String name) {
    showDialog(
        context: context,
        builder: (context) {
          _textFieldController.text = "";
          return AlertDialog(
            title: Text(
              'Enter "${name}" Passcode:',
              style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: color.AppColor.pageTitleFirstColor),
            ),
            // content: Text('Do you really want to delete?'),
            content: TextField(
                onChanged: (value) {
                  setState(() {
                    ssidpasscord = value;
                  });
                },
                controller: _textFieldController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: '"${name}" Passcode',
                )),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Close'),
              ),
              TextButton(
                  onPressed: () {
                    // print("------------------------------");
                    // print(name);
                    // print(_textFieldController.text);
                    // print("------------------------------");
                    // WiFiForIoTPlugin.removeWifiNetwork(poCommand.argument);

                    // WiFiForIoTPlugin.removeWifiNetwork(ssidActive);
                    // WiFiForIoTPlugin.connect(
                    //   name,
                    //   password: _textFieldController.text,
                    //   joinOnce: true,
                    //   security: NetworkSecurity.WPA,
                    // );
                    Future.delayed(const Duration(milliseconds: 2000), () {
                      Navigator.pop(context);
                    });
                    Future.delayed(const Duration(milliseconds: 4000));
                    setState(() {});
                  },
                  child: const Text('Join'))
            ],
          );
        });
  }

  isRegisteredWifiNetwork(String ssid) {
    return ssid == this.ssid;
  }

  getList(contex) {
    return ListView.builder(
      itemBuilder: (builder, i) {
        var network = _htResultNetwork[i];
        var isConnctedWifi = false;
        if (_isConnected)
          isConnctedWifi = isRegisteredWifiNetwork(network.ssid as String);

        if (_htResultNetwork != null && _htResultNetwork.length > 0) {
          if (isConnctedWifi) {
            ssidActive = network.ssid.toString();
          }
          return Container(
            color: isConnctedWifi
                ? color.AppColor.gradientFirst
                : Colors.transparent,
            child: ListTile(
              title: Text(
                network.ssid.toString(),
                style: Theme.of(context).textTheme.bodyText1,
              ),
              trailing: !isConnctedWifi
                  ? TextButton(
                      onPressed: () {
                        showDialogBox(network.ssid.toString());
                      },
                      child: Text(
                        'Connect',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    )
                  : Text(
                      'Connected',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
            ),
          );
        } else
          return Center(
            child: Text('No wifi found'),
          );
      },
      itemCount: _htResultNetwork.length,
      shrinkWrap: true,
    );
  }

  List<Widget> getButtonWidgetsForAndroid(context) {
    List<Widget> htPrimaryWidgets = [];
    WiFiForIoTPlugin.isEnabled().then((val) => setState(() {
          _isEnabled = val;
        }));
    htPrimaryWidgets.addAll({getList(context)});
    if (_isEnabled) {
      WiFiForIoTPlugin.isConnected().then((val) {
        if (val != null) {
          setState(() {
            _isConnected = val;
          });
        }
      });
    }
    return htPrimaryWidgets;
  }

  Widget getWidgets(context) {
    WiFiForIoTPlugin.isConnected().then((val) => setState(() {
          _isConnected = val;
        }));

    return SingleChildScrollView(
      child: Column(
        children: getButtonWidgetsForAndroid(context),
      ),
    );
  }

  Future<List<WifiNetwork>> loadWifiList() async {
    List<WifiNetwork> htResultNetwork;
    try {
      htResultNetwork = await WiFiForIoTPlugin.loadWifiList();
    } on PlatformException {
      htResultNetwork = <WifiNetwork>[];
    }

    return htResultNetwork;
  }

  getWifis() async {
    _isEnabled = await WiFiForIoTPlugin.isEnabled();
    _isConnected = await WiFiForIoTPlugin.isConnected();
    _htResultNetwork = await loadWifiList();
    _htResultNetwork = _htResultNetwork
        .where((i) => !i.ssid!.contains(nameStartWith))
        .toList();
    // _htResultNetwork.where((i) => i.ssid!.contains(nameStartWith)).toList();
    setState(() {});
    if (_isConnected) {
      WiFiForIoTPlugin.getSSID().then((value) => setState(() {
            ssid = value.toString();
          }));
    }
  }

  @override
  Widget build(BuildContext poContext) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(
            color: color.AppColor.pageIconFirstColor, //change your color here
          ),
          backgroundColor: color.AppColor.pageBackground,
          title: const Text('Select Device'),
          actions: [
            Switch(
                value: _isEnabled,
                onChanged: (v) {
                  if (_isEnabled) {
                    WiFiForIoTPlugin.setEnabled(false);
                    _htResultNetwork.clear();
                  } else {
                    WiFiForIoTPlugin.setEnabled(true);
                    getWifis();
                  }
                  setState(() {});
                }),
          ]),
      body: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              color.AppColor.gradientFirst,
              color.AppColor.gradientSecond
            ],
          )),
          child: getWidgets(poContext)),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            getWifis();
          },
          backgroundColor: color.AppColor.pageBackground,
          child: IconTheme(
            data: IconThemeData(color: color.AppColor.pageIconFirstColor),
            child: const Icon(Icons.refresh),
          )),
    );
  }
}

class PopupCommand {
  String command;
  String argument;

  PopupCommand(this.command, this.argument);
}
