// pages/home.dart

import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _searchController = TextEditingController();

  String _searchQuery = '';

  void updateSearchQuery(String query) {
    setState(() {
      _searchQuery = query;
    });
  }

  Future<Map<String, dynamic>> fetchCourses({String query = ''}) async {
    var url = Uri.parse(
        "http://si-sdm.id/ecourse/api/web/v1/courses/search-by-name?name=$query");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load courses.");
    }
  }

  Future<Map<String, dynamic>> fetchCategories() async {
    var url =
        Uri.parse("http://si-sdm.id/ecourse/api/web/v1/course-categories/all");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load categories.");
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
            Padding(
              padding: const EdgeInsetsDirectional.only(bottom: 20),
              child: allCourses(context),
            ),
          ].divide(const SizedBox(height: 30)),
        ),
      ),
    ));
  }

  Widget allCourses(context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: fetchCourses(query: _searchQuery),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        } else {
          final List<dynamic> courses = snapshot.data?['items'];
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
                  for (var course in courses)
                    courseCard(
                      context,
                      course['id'], //id
                      'https://cdn.pixabay.com/photo/2021/08/04/13/06/software-developer-6521720_1280.jpg', //image
                      course['course_name'], //courseName
                      course['harga'], //price
                      course['durasi'], //video
                      course['durasi'], //quiz
                    ),
                ].divide(const SizedBox(height: 15)),
              ),
            ].divide(const SizedBox(height: 10)),
          );
        }
      },
    );
  }

  Widget courseCard(BuildContext context, int id, String image,
      String courseName, double price, int videos, int quizzez) {
    final num = NumberFormat('#,###');
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/detail',
          arguments: id,
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
          Expanded(
            child: Column(
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
          ),
        ].divide(const SizedBox(width: 15)),
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
                  controller: _searchController,
                  onChanged: updateSearchQuery,
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
        FutureBuilder<Map<String, dynamic>>(
          future: fetchCategories(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            } else {
              final categories = snapshot.data?['items'];
              return Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      for (var c in categories)
                        categoriesBtn(c['category'], c['id']),
                    ].divide(const SizedBox(width: 15)),
                  ),
                ),
              );
            }
          },
        ),
      ].divide(const SizedBox(height: 20)),
    );
  }

  Widget categoriesBtn(String category, int id) {
    return FFButtonWidget(
      onPressed: () {
        Navigator.pushNamed(
          context,
          '/category',
          arguments: [category, id],
        );
      },
      text: category,
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
