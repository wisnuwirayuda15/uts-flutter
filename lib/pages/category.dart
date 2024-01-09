// pages/category.dart

import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class Category extends StatelessWidget {
  const Category({super.key});
  @override
  Widget build(BuildContext context) {
    dynamic category = ModalRoute.of(context)!.settings.arguments ?? [];
    if (category.length == 0) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: Center(
          child: Column(children: [
            const Text('Please select the category from the homepage.'),
            FFButtonWidget(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/home',
                );
              },
              text: 'Go to homepage',
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
          ]),
        ),
      );
    }

    Future<Map<String, dynamic>> fetchCoursesByCategory() async {
      var url = Uri.parse(
          "http://si-sdm.id/ecourse/api/web/v1/courses/all-filter-by-category?id_category=${category[1]}");
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception("Failed to load courses");
      }
    }

    return Scaffold(
        appBar: appBar(context, category[0]),
        body: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.only(bottom: 20),
                  child: courses(context, fetchCoursesByCategory()),
                ),
              ].divide(const SizedBox(height: 30)),
            ),
          ),
        ));
  }

  Widget courses(context, Future<Map<String, dynamic>> courses) {
    return FutureBuilder<Map<String, dynamic>>(
      future: courses,
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

  AppBar appBar(BuildContext context, String title) {
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
        title,
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
