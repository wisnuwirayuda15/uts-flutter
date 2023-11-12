import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:google_fonts/google_fonts.dart';

class Checkout extends StatefulWidget {
  const Checkout({super.key});

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  final _jumlahPaket = TextEditingController();
  final _voucherCode = TextEditingController();

  final num = NumberFormat('#,###');

  final String _validCode = "WISNU1202200244";
  final int _harga = 250000;
  double _totalPrice = 0;
  String _voucher = 'Masukan code';
  String _voucherStatus = '';
  String _jumlah = 'Masukan jumlah paket';
  bool _valid = false;

  void _countPrice(jumlahPaket) {
    double paket = double.tryParse(jumlahPaket) ?? 0;

    setState(() {
      _totalPrice = _harga * paket;
      _valid ? _totalPrice = _totalPrice * 0.5 : null;
      _jumlah = jumlahPaket;
    });
  }

  void _voucherCheck() {
    if (_voucherCode.text == _validCode) {
      _valid = true;
      _voucherStatus = "50% OFF";
    } else {
      _valid = false;
      _voucherStatus = "VOUCHER NOT FOUND";
    }

    _countPrice(_jumlahPaket.text);

    setState(() {
      _voucher = _voucherCode.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBar(context),
        body: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(15, 20, 15, 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                info(),
                form(),
                total(),
                action(),
              ].divide(const SizedBox(height: 30)),
            ),
          ),
        ),
      ),
    );
  }

  Widget action() {
    return Align(
      alignment: const AlignmentDirectional(0.00, -1.00),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0, 30, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FFButtonWidget(
              onPressed: () {
                _countPrice(_jumlahPaket.text);
              },
              text: 'Hitung',
              options: FFButtonOptions(
                height: 40,
                padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                color: const Color(0x21747474),
                textStyle: GoogleFonts.getFont(
                  'Poppins',
                  color: Colors.black,
                  fontSize: 15,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              showLoadingIndicator: false,
            ),
            FFButtonWidget(
              onPressed: () {},
              text: 'Checkout',
              options: FFButtonOptions(
                height: 40,
                padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                color: const Color(0xFF38A5E3),
                textStyle: GoogleFonts.getFont(
                  'Poppins',
                  color: Colors.white,
                  fontSize: 15,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              showLoadingIndicator: false,
            ),
          ],
        ),
      ),
    );
  }

  Widget total() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Jumlah paket: $_jumlah',
          style: GoogleFonts.getFont(
            'Poppins',
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 15,
          ),
        ),
        Text(
          'Voucer code: $_voucher \nInfo: $_voucherStatus',
          style: GoogleFonts.getFont(
            'Poppins',
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 15,
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
          child: Text(
            'Total Pembayaran',
            style: GoogleFonts.getFont(
              'Poppins',
              color: const Color(0xFF717171),
              fontWeight: FontWeight.normal,
              fontSize: 14,
            ),
          ),
        ),
        Text(
          'Rp ${num.format(_totalPrice)}',
          style: GoogleFonts.getFont(
            'Poppins',
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Text(
            'Gunakan voucer "WISNU1202200244" untuk mendapatkan diskon 50% !!',
            style: GoogleFonts.getFont(
              'Poppins',
              color: Colors.black,
              fontWeight: FontWeight.normal,
              fontSize: 14,
            ),
          ),
        ),
      ].divide(const SizedBox(height: 5)),
    );
  }

  Widget form() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextField(
          controller: _jumlahPaket,
          keyboardType: TextInputType.number,
          obscureText: false,
          decoration: InputDecoration(
            labelText: 'Jumlah Paket',
            alignLabelWithHint: false,
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color(0x00000000),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color(0x00000000),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color(0x00000000),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color(0x00000000),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            filled: true,
            fillColor: const Color(0x21747474),
            prefixIcon: const Icon(
              Icons.shopping_cart_rounded,
            ),
          ),
          style: GoogleFonts.getFont(
            'Poppins',
            color: Colors.black,
          ),
          maxLines: null,
        ),
        TextField(
          controller: _voucherCode,
          obscureText: false,
          decoration: InputDecoration(
            labelText: 'Voucher Code',
            alignLabelWithHint: false,
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color(0x00000000),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color(0x00000000),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color(0x00000000),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color(0x00000000),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            filled: true,
            fillColor: const Color(0x21747474),
            prefixIcon: const Icon(
              Icons.discount,
            ),
          ),
          style: GoogleFonts.getFont(
            'Poppins',
            color: Colors.black,
          ),
          maxLines: null,
        ),
        FFButtonWidget(
          onPressed: () {
            _voucherCheck();
          },
          text: 'Cek Voucher',
          options: FFButtonOptions(
            height: 40,
            padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
            iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
            color: const Color.fromARGB(255, 15, 203, 109),
            textStyle: GoogleFonts.getFont(
              'Poppins',
              color: Colors.black,
              fontSize: 15,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          showLoadingIndicator: false,
        ),
      ].divide(const SizedBox(height: 20)),
    );
  }

  Widget info() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
          child: Text(
            'Flutter Dasar',
            style: GoogleFonts.getFont(
              'Poppins',
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        Text(
          'Harga',
          style: GoogleFonts.getFont(
            'Poppins',
            color: const Color(0xFF717171),
            fontWeight: FontWeight.normal,
            fontSize: 14,
          ),
        ),
        Text(
          'Rp ${num.format(_harga)} / paket',
          style: GoogleFonts.getFont(
            'Poppins',
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 15,
          ),
        ),
      ],
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      leading: FlutterFlowIconButton(
        borderColor: Colors.transparent,
        borderRadius: 30,
        borderWidth: 1,
        buttonSize: 60,
        icon: const Icon(
          Icons.chevron_left_rounded,
          color: Colors.black,
          size: 30,
        ),
        onPressed: () async {
          Navigator.of(context).pop();
        },
      ),
      title: Text(
        'Checkout',
        style: GoogleFonts.getFont(
          'Poppins',
          color: Colors.black,
          fontWeight: FontWeight.w500,
          fontSize: 22,
        ),
      ),
      centerTitle: true,
      elevation: 0,
    );
  }
}
