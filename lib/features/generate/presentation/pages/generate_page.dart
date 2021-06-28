import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../core/providers/viewmodel_providers.dart';
import '../viewmodels/generate_viewmodel.dart';

class GeneratePage extends StatefulWidget {
  GeneratePage({Key key}) : super(key: key);

  @override
  _GeneratePageState createState() => _GeneratePageState();
}

class _GeneratePageState extends State<GeneratePage> {
  GlobalKey globalKey = new GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = context.read(ViewModelProviders.generateViewModel);
      viewModel.getSeed();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).qrCodeTitle),
      ),
      body: SafeArea(
        child: _body(),
      ),
    );
  }

  Widget _body() {
    return Consumer(
      builder: (context, watch, child) {
        final viewModel = watch(ViewModelProviders.generateViewModel);
        if (viewModel.isInitial) {
          return _buildInitial();
        }
        if (viewModel.isLoading) {
          return _buildLoading();
        }
        if (viewModel.succeeded) {
          return _buildSuccess(viewModel);
        }
        if (viewModel.failed) {
          return _buildError();
        }
        return Container();
      },
    );
  }

  Widget _buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildInitial() {
    return Container();
  }

  Widget _buildSuccess(GenerateViewModel viewModel) {
    final bodyHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).viewInsets.bottom;
    return Column(
      children: [
        Expanded(
          child: Center(
            child: RepaintBoundary(
              key: globalKey,
              child: QrImage(
                data: viewModel.seed.seed,
                size: 0.35 * bodyHeight,
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 25),
          padding: EdgeInsets.all(30),
          child: Text(
            viewModel.seconds,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30.0,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildError() {
    return Container();
  }
}
