import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class ChartPage extends StatefulWidget {
  final String groupName;
  const ChartPage({super.key, required this.groupName});

  @override
  State<ChartPage> createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: "https://in.tradingview.com/chart/?symbol=NSE%3A" + widget.groupName,
      withJavascript: true,
      withZoom: true,
      appBar: AppBar(
        title: Text("${widget.groupName}"),
        backgroundColor: Colors.black,
      ),
    );
  }
}
