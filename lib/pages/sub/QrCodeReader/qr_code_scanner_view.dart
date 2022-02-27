import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'first_page_view.dart';
import '../../DarkModeColor.dart';

@immutable
class ConfirmViewArguments {
  const ConfirmViewArguments({required this.type, required this.data});
  final String type;
  final String data;
}

class QRCodeScannerView extends StatefulWidget {
  @override
  _QRCodeScannerViewState createState() => _QRCodeScannerViewState();
}

class _QRCodeScannerViewState extends State<QRCodeScannerView> {
  QRViewController? _qrController;
  final GlobalKey _qrKey = GlobalKey(debugLabel: 'QR');
  bool _isQRScanned = false;

  // ホットリロードを機能させるには、プラットフォームがAndroidの場合はカメラを一時停止するか、
  // プラットフォームがiOSの場合はカメラを再開する必要がある
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      _qrController?.pauseCamera();
    }
    _qrController?.resumeCamera();
  }

  @override
  void dispose() {
    _qrController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    isDarkMode = true;
    // _checkPermissionState();
    return CupertinoPageScaffold(
      backgroundColor: isDarkMode ? darkModeBackColor : backColor,
      navigationBar: CupertinoNavigationBar(
        middle: Text("Scan the QR code", style: _buildTextStyle()),
        backgroundColor: isDarkMode ? darkModeBackColor : backColor,
      ),
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 4,
            // child: _buildPermissionState(context),
            child: _buildQRView(context),
          ),
          Expanded(
            flex: 1,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text('Scan a code', style: _buildTextStyle()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: CupertinoButton(
                          onPressed: () async {
                            await _qrController?.toggleFlash();
                            setState(() {});
                          },
                          child: FutureBuilder(
                            future: _qrController?.getFlashStatus(),
                            builder: (context, snapshot) =>
                                Text('Flash: ${snapshot.data}',style: _buttonTextStyleNoBackground),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: CupertinoButton(
                          onPressed: () async {
                            await _qrController?.flipCamera();
                            setState(() {});
                          },
                          child: FutureBuilder(
                            future: _qrController?.getCameraInfo(),
                            builder: (context, snapshot) => snapshot.data !=
                                    null
                                ? Text(
                                    'Camera facing ${describeEnum(snapshot.data!)}',
                                    style: _buttonTextStyleNoBackground)
                                : Text('loading',
                                             style: _buttonTextStyleNoBackground),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: CupertinoButton(
                          onPressed: () async {
                            await _qrController?.pauseCamera();
                          },
                          child: Text(
                            'pause',
                            style: _buttonTextStyleNoBackground,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: CupertinoButton(
                          onPressed: () async {
                            await _qrController?.resumeCamera();
                          },
                          child: Text(
                            'resume',
                            style: _buttonTextStyleNoBackground,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQRView(BuildContext context) {
    return QRView(
      key: _qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: Colors.green,
        borderRadius: 16,
        borderLength: 24,
        borderWidth: 8,
        // cutOutSize: scanArea,
      ),
    );
  }

  void _onQRViewCreated(QRViewController qrController) {
    setState(() {
      _qrController = qrController;
    });
    // QRを読み込みをlistenする
    qrController.scannedDataStream.listen((scanData) {
      // QRのデータが取得出来ない場合SnackBar表示
      if (scanData.code == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('QR code data does not exist'),
          ),
        );
      }
      // 次の画面へ遷移
      _transitionToNextScreen(describeEnum(scanData.format), scanData.code!);
    });
  }

  Future<void> _transitionToNextScreen(String type, String data) async {
    if (!_isQRScanned) {
      // カメラを一時停止
      _qrController?.pauseCamera();
      _isQRScanned = true;
      // 次の画面へ遷移
      await Navigator.pushNamed(
        context,
        Const.routeConfirm,
        arguments: ConfirmViewArguments(type: type, data: data),
      ).then(
        // 遷移先画面から戻った場合カメラを再開
        (value) {
          _qrController?.resumeCamera();
          _isQRScanned = false;
        },
      );
    }
  }
}

var myTextStyle = new TextStyle();
TextStyle _buildTextStyle() {
  return myTextStyle = new TextStyle(
  fontWeight: FontWeight.w100,
  decoration: TextDecoration.none,
  fontSize: 16,
  color: isDarkMode ? darkModeForeColor : foreColor,
  );
}

TextStyle  _buttonTextStyleNoBackground = new TextStyle(
  fontWeight: FontWeight.w300,
  decoration: TextDecoration.none,
  fontSize: 16,
  color: CupertinoColors.activeBlue,
);
