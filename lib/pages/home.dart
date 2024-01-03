// pages/home.dart

import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class Home extends StatelessWidget {
  const Home({super.key});

  Future<Map<String, dynamic>> fetchData() async {
    final response =
        await http.get(Uri.parse("https://dummyjson.com/products"));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load data");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.only(top: 20),
              child: header(),
            ),
            filter(),
            popular(context),
            Padding(
              padding: const EdgeInsetsDirectional.only(bottom: 20),
              child: recommendation(context),
            ),
          ].divide(const SizedBox(height: 30)),
        ),
      ),
    ));
  }

  Widget recommendation(context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: fetchData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        } else {
          final List<dynamic> courses = snapshot.data?['products'];
          return Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'All Courses',
                    style: GoogleFonts.getFont(
                      'Poppins',
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    'See more',
                    style: GoogleFonts.getFont(
                      'Poppins',
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  for (var courses in courses)
                    reCard(
                      context,
                      courses['id'], //id
                      courses['thumbnail'], //image
                      courses['title'], //courseName
                      courses['description'], //description
                      courses['price'], //price
                      courses['stock'], //video
                      courses['id'], //quiz
                    ),
                ].divide(const SizedBox(height: 15)),
              ),
            ].divide(const SizedBox(height: 10)),
          );
        }
      },
    );
  }

  Widget reCard(BuildContext context, int id, String image, String courseName,
      String description, double price, int videos, int quizzez) {
    final num = NumberFormat('#,###');
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/detail',
          arguments: {
            'id': id,
            'image': image,
            'courseName': courseName,
            'description': description,
            'price': price,
            'videos': videos,
            'quizzez': quizzez,
          },
        );
      },
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              image,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                courseName,
                style: GoogleFonts.getFont(
                  'Poppins',
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              Text(
                'Rp ${num.format(price)}',
                style: GoogleFonts.getFont(
                  'Poppins',
                  color: const Color(0xFF459CFE),
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Icon(
                        Icons.video_collection,
                        color: Color(0x68000000),
                        size: 20,
                      ),
                      Text(
                        '$videos Videos',
                        style: GoogleFonts.getFont(
                          'Poppins',
                          color: const Color(0x68000000),
                          fontSize: 14,
                        ),
                      ),
                    ].divide(const SizedBox(width: 10)),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.quiz,
                        color: Color(0x68000000),
                        size: 20,
                      ),
                      Text(
                        '$quizzez Quizzez',
                        style: GoogleFonts.getFont(
                          'Poppins',
                          color: const Color(0x68000000),
                          fontSize: 14,
                        ),
                      ),
                    ].divide(const SizedBox(width: 10)),
                  ),
                ].divide(const SizedBox(width: 20)),
              ),
            ].divide(const SizedBox(height: 10)),
          ),
        ].divide(const SizedBox(width: 15)),
      ),
    );
  }

  Widget popular(context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Populer',
              style: GoogleFonts.getFont(
                'Poppins',
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
            Text(
              'See more',
              style: GoogleFonts.getFont(
                'Poppins',
                color: Colors.black,
                fontWeight: FontWeight.w300,
                fontSize: 14,
              ),
            ),
          ],
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              popCard(
                  context,
                  'https://images.unsplash.com/photo-1600087626014-e652e18bbff2?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwyMXx8YW5kcm9pZHxlbnwwfHx8fDE2OTk2MjQxOTh8MA&ixlib=rb-4.0.3&q=80&w=400',
                  'Flutter Dasar',
                  'Course untuk pemula'),
              popCard(
                  context,
                  'https://images.unsplash.com/photo-1557774058-c9148bc6e481?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwxOHx8YW5kcm9pZHxlbnwwfHx8fDE2OTk2MjQxOTh8MA&ixlib=rb-4.0.3&q=80&w=400',
                  'Flutter Lanjutan',
                  'Course untuk menengah'),
              popCard(
                  context,
                  'https://images.unsplash.com/photo-1607027340690-37e80b0f1b31?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwxN3x8YW5kcm9pZHxlbnwwfHx8fDE2OTk2MjQxOTh8MA&ixlib=rb-4.0.3&q=80&w=400',
                  'Flutter Akhir',
                  'Course untuk professional'),
            ].divide(const SizedBox(width: 15)),
          ),
        ),
      ].divide(const SizedBox(height: 10)),
    );
  }

  Widget popCard(BuildContext context, String image, String courseName,
      String courseDesc) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/detail');
      },
      child: Container(
        width: 250,
        height: 300,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: Image.network(
              image,
            ).image,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(15, 0, 0, 15),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    courseName,
                    style: GoogleFonts.getFont(
                      'Poppins',
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    courseDesc,
                    style: GoogleFonts.getFont(
                      'Poppins',
                      color: Colors.white,
                      fontWeight: FontWeight.w200,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget filter() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 20, 0),
                child: TextField(
                  obscureText: false,
                  decoration: InputDecoration(
                    labelText: 'Cari course',
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
                      Icons.search_sharp,
                      color: Colors.black,
                    ),
                  ),
                  style: GoogleFonts.getFont(
                    'Poppins',
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.start,
                  maxLines: null,
                ),
              ),
            ),
            FlutterFlowIconButton(
              borderRadius: 10,
              buttonSize: 55,
              fillColor: const Color(0xFF38A5E3),
              icon: const FaIcon(
                FontAwesomeIcons.sliders,
                color: Colors.white,
                size: 25,
              ),
              onPressed: () {},
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                categoriesBtn('Flutter', true),
                categoriesBtn('React', false),
                categoriesBtn('Laravel', false),
                categoriesBtn('Golang', false),
              ].divide(const SizedBox(width: 15)),
            ),
          ),
        ),
      ].divide(const SizedBox(height: 20)),
    );
  }

  Widget categoriesBtn(String text, bool selected) {
    var select = selected;
    return FFButtonWidget(
      onPressed: () {
        select = !select;
      },
      text: text,
      options: FFButtonOptions(
        height: 40,
        padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
        iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
        color: select ? const Color(0xFF38A5E3) : const Color(0xFFEDEDED),
        textStyle: GoogleFonts.getFont(
          'Poppins',
          color: select ? Colors.white : Colors.black,
          fontSize: 15,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      showLoadingIndicator: false,
    );
  }

  Widget header() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Kategori',
              style: GoogleFonts.getFont(
                'Poppins',
                color: Colors.black,
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'Programming',
                  style: GoogleFonts.getFont(
                    'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
                const FaIcon(
                  FontAwesomeIcons.chevronDown,
                  color: Color(0xFF5C6063),
                  size: 18,
                ),
              ].divide(const SizedBox(width: 10)),
            ),
          ].divide(const SizedBox(height: 5)),
        ),
        FlutterFlowIconButton(
          borderRadius: 20,
          borderWidth: 1,
          buttonSize: 50,
          icon: const Icon(
            Icons.notifications_none,
            color: Colors.black,
            size: 25,
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}
