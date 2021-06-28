import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_qr_bar_scanner/qr_bar_scanner_camera.dart';
import 'package:flutter_riverpod/all.dart';

import '../../../../core/providers/viewmodel_providers.dart';

class ScanPage extends StatefulWidget {
  ScanPage({Key key}) : super(key: key);

  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).scanTitle),
      ),
      body: SafeArea(
        child: _body(),
      ),
    );
  }

  Widget _body() {
    final bodywidth = MediaQuery.of(context).size.width;
    final size = bodywidth * 0.9;
    return Column(
      children: [
        Expanded(
          child: Center(
            child: SizedBox(
              height: size,
              width: size,
              child: QRBarScannerCamera(
                fit: BoxFit.fill,
                onError: (context, error) => Text(
                  error.toString(),
                  style: TextStyle(color: Colors.red),
                ),
                qrCodeCallback: (code) {
                  context.read(ViewModelProviders.scanViewModel).setSeed(code);
                },
              ),
            ),
          ),
        ),
        _buildInfoBox()
      ],
    );
  }

  Widget _buildInfoBox() {
    return Consumer(
      builder: (context, watch, child) {
        final viewModel = watch(ViewModelProviders.scanViewModel);
        if (viewModel.isLoading) {
          return _buildLoading();
        }
        return Container(
          height: 100,
          padding: EdgeInsets.all(10),
          child: Text(
            viewModel.message,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18.0,
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoading() {
    return Center(
      child: Container(
        child: CircularProgressIndicator(),
        margin: EdgeInsets.all(10),
      ),
    );
  }
}
