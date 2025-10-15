import 'dart:io';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';


class ScanQrScreen extends StatefulWidget {
  const ScanQrScreen({Key? key}) : super(key: key);

  @override
  State<ScanQrScreen> createState() => _ScanQrScreenState();
}

class _ScanQrScreenState extends State<ScanQrScreen> {
  final MobileScannerController _controller = MobileScannerController(
    facing: CameraFacing.back,
    torchEnabled: false,
    detectionSpeed: DetectionSpeed.noDuplicates,
  );

  bool _handlingResult = false;

  Future<void> _onDetect(BarcodeCapture capture) async {
    if (_handlingResult) return;
    final barcode = capture.barcodes.isNotEmpty ? capture.barcodes.first : null;
    final raw = barcode?.rawValue;
    if (raw == null) return;

    _handlingResult = true;
    try {
      // TODO: integrate your booking flow here using `raw`
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Detected: $raw')),
      );
    } finally {
      _handlingResult = false;
    }
  }

  Future<void> _pickImageAndScan() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked == null) return;

    final file = File(picked.path);
    try {
      await _controller.analyzeImage(file.path);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Analyzing selected image...')),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to analyze image: $e')),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Dimensions per request
    const double scanWidth = 250;
    const double scanHeight = 248;
    const double radius = 20;
    const double cornerW = 26; // top-right size provided 26*25, replicate on all sides
    const double cornerH = 25;
    const double cornerStroke = 4;
 const Color cornerColor = Color(0xFF074139);;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
            Positioned.fill(
              child: Image.asset(
                'assets/images/qrbgg.jpg',
                fit: BoxFit.cover,
                alignment: Alignment.center,
                
              ),
            ),
            SafeArea(
              child: Column(
                children: [
                  // Top bar with back and original title
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () => Navigator.of(context).maybePop(),
                        ),
                        const SizedBox(width: 8),
                        const Expanded(
                          child: Text(
                            'Scan QR Code',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              height: 1.0,
                            ),
                          ),
                        ),
                        // Spacer for symmetry with leading IconButton (~48px)
                        const SizedBox(width: 48),
                      ],
                    ),
                  ),

                  // Centered scanner area with bottom-aligned upload button
                  Expanded(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Centered scanner card
                        Container(
                          width: scanWidth + 24, // 12 padding on each side
                          height: scanHeight + 24,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.95),
                            borderRadius: BorderRadius.circular(radius + 8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.25),
                                blurRadius: 16,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: SizedBox(
                              width: scanWidth,
                              height: scanHeight,
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(radius),
                                    child: MobileScanner(
                                      controller: _controller,
                                      onDetect: _onDetect,
                                      fit: BoxFit.cover,
                                    ),
                                  ),

                                  // Four corner brackets 26x25 stacked
                                  const Positioned(
                                    top: 0,
                                    left: 0,
                                    child: _CornerBracket(
                                      width: cornerW,
                                      height: cornerH,
                                      stroke: cornerStroke,
                                      color: cornerColor,
                                      which: CornerWhich.topLeft,
                                      radius: 10,
                                    ),
                                  ),
                                  const Positioned(
                                    top: 0,
                                    right: 0,
                                    child: _CornerBracket(
                                      width: cornerW,
                                      height: cornerH,
                                      stroke: cornerStroke,
                                      color: cornerColor,
                                      which: CornerWhich.topRight,
                                      radius: 10,
                                    ),
                                  ),
                                  const Positioned(
                                    bottom: 0,
                                    left: 0,
                                    child: _CornerBracket(
                                      width: cornerW,
                                      height: cornerH,
                                      stroke: cornerStroke,
                                      color: cornerColor,
                                      which: CornerWhich.bottomLeft,
                                      radius: 10,
                                    ),
                                  ),
                                  const Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: _CornerBracket(
                                      width: cornerW,
                                      height: cornerH,
                                      stroke: cornerStroke,
                                      color: cornerColor,
                                      which: CornerWhich.bottomRight,
                                      radius: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        // Bottom-aligned upload button (269 x 44)
                        Positioned(
                          bottom: 24,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: SizedBox(
                              width: 269,
                              height: 44,
                              child: Material(
                                color: const Color(0xFF1976D2),
                                borderRadius: BorderRadius.circular(12),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(12),
                                  onTap: _pickImageAndScan,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 12),
                                    child: Row(
                                      children: [
                                        const Expanded(
                                          child: Text(
                                            'Upload from gallery',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Container(
                                          width: 28,
                                          height: 28,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                          child: const Icon(
                                            Icons.image_outlined,
                                            size: 18,
                                            color: Color(0xFF1976D2),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
        ],
      ),
    );
  }
}

enum CornerWhich { topLeft, topRight, bottomLeft, bottomRight }

class _CornerBracket extends StatelessWidget {
  final double width;
  final double height;
  final double stroke;
  final double radius;
  final Color color;
  final CornerWhich which;

  const _CornerBracket({
    super.key,
    required this.width,
    required this.height,
    required this.stroke,
    required this.color,
    required this.which,
    this.radius = 8,
  });

  @override
  Widget build(BuildContext context) {
    final side = BorderSide(color: color, width: stroke);
    switch (which) {
      case CornerWhich.topLeft:
        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            border: Border(top: side, left: side),
            borderRadius: BorderRadius.only(topLeft: Radius.circular(radius)),
          ),
        );
      case CornerWhich.topRight:
        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            border: Border(top: side, right: side),
            borderRadius: BorderRadius.only(topRight: Radius.circular(radius)),
          ),
        );
      case CornerWhich.bottomLeft:
        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            border: Border(bottom: side, left: side),
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(radius)),
          ),
        );
      case CornerWhich.bottomRight:
        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            border: Border(bottom: side, right: side),
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(radius)),
          ),
        );
    }
  }
}