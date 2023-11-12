import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:google_fonts/google_fonts.dart';

class Detail extends StatelessWidget {
  const Detail({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.only(top: 20),
                  child: detail(context),
                ),
                description(),
                profile(),
                gallery(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: price(context),
                ),
              ].divide(const SizedBox(height: 30)),
            ),
          ),
        ),
      ),
    );
  }

  Widget price(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                'Rp 250,000 / paket',
                style: GoogleFonts.getFont(
                  'Poppins',
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          FFButtonWidget(
            onPressed: () {
              Navigator.pushNamed(context, '/checkout');
            },
            text: 'Ambil',
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
    );
  }

  Widget gallery() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Galeri',
          style: GoogleFonts.getFont(
            'Poppins',
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              galleryImage(
                  'https://images.unsplash.com/photo-1659813254494-fbf374803c7e?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwxfHxjYWxtaW5nJTIwbmF0dXJlfGVufDB8fHx8MTY5OTYzODExNXww&ixlib=rb-4.0.3&q=80&w=400'),
              galleryImage(
                  'https://images.unsplash.com/photo-1692864431050-165164becb51?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHw2fHxjYWxtaW5nJTIwbmF0dXJlfGVufDB8fHx8MTY5OTYzODExNXww&ixlib=rb-4.0.3&q=80&w=400'),
              galleryImage(
                  'https://images.unsplash.com/photo-1472214103451-9374bd1c798e?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHw3fHxuYXR1cmV8ZW58MHx8fHwxNjk5NzEyODYxfDA&ixlib=rb-4.0.3&q=80&w=400'),
              galleryImage(
                  'https://images.unsplash.com/photo-1682685797507-d44d838b0ac7?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MXwxfHNlYXJjaHwxfHxzdW5zZXR8ZW58MHx8fHwxNjk5NjY0NTAwfDA&ixlib=rb-4.0.3&q=80&w=400'),
            ].divide(const SizedBox(width: 10)),
          ),
        ),
      ].divide(const SizedBox(height: 5)),
    );
  }

  Widget galleryImage(String image) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.network(
        image,
        width: 120,
        height: 120,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget profile() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: 65,
              height: 65,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: Image.network(
                    'https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHw5fHxwZW9wbGV8ZW58MHx8fHwxNjk5NjQ2NjQzfDA&ixlib=rb-4.0.3&q=80&w=400',
                  ).image,
                ),
                shape: BoxShape.circle,
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Jack Smith',
                  style: GoogleFonts.getFont(
                    'Poppins',
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ),
                Text(
                  'Mentor',
                  style: GoogleFonts.getFont(
                    'Poppins',
                    color: const Color(0xFF717171),
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ].divide(const SizedBox(width: 10)),
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            FlutterFlowIconButton(
              borderColor: Colors.transparent,
              borderRadius: 10,
              buttonSize: 45,
              fillColor: const Color(0xFF38A5E3),
              icon: const Icon(
                Icons.phone_rounded,
                color: Colors.white,
                size: 20,
              ),
              onPressed: () {},
            ),
            FlutterFlowIconButton(
              borderColor: Colors.transparent,
              borderRadius: 10,
              buttonSize: 45,
              fillColor: const Color(0xFF38A5E3),
              icon: const Icon(
                Icons.chat_bubble,
                color: Colors.white,
                size: 20,
              ),
              onPressed: () {},
            ),
          ].divide(const SizedBox(width: 5)),
        ),
      ],
    );
  }

  Widget description() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Deskripsi',
          style: GoogleFonts.getFont(
            'Poppins',
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
        Text(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam suscipit tortor ipsum, eget imperdiet eros sodales volutpat.',
          style: GoogleFonts.getFont(
            'Poppins',
            color: const Color(0xFF717171),
            fontWeight: FontWeight.normal,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget detail(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: Image.network(
            'https://images.unsplash.com/photo-1525547719571-a2d4ac8945e2?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHw0fHxjb21wdXRlcnxlbnwwfHx8fDE2OTk3MDk1MjB8MA&ixlib=rb-4.0.3&q=80&w=400',
          ).image,
        ),
        borderRadius: BorderRadius.circular(20),
        shape: BoxShape.rectangle,
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(15, 15, 15, 15),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                  child: FlutterFlowIconButton(
                    borderRadius: 100,
                    borderWidth: 0,
                    buttonSize: 48,
                    fillColor: const Color(0x39DDDDDD),
                    icon: const Icon(
                      Icons.chevron_left_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed: () async {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                  child: FlutterFlowIconButton(
                    borderRadius: 100,
                    borderWidth: 0,
                    buttonSize: 48,
                    fillColor: const Color(0x39DDDDDD),
                    icon: const Icon(
                      Icons.bookmark_border,
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Flutter Dasar',
                  style: GoogleFonts.getFont(
                    'Poppins',
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 25,
                  ),
                ),
                Text(
                  'Course untuk pemula',
                  style: GoogleFonts.getFont(
                    'Poppins',
                    color: const Color(0xFFDBDBDB),
                    fontWeight: FontWeight.normal,
                    fontSize: 20,
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Icon(
                            Icons.video_collection,
                            color: Color(0xFFDBDBDB),
                            size: 20,
                          ),
                          Text(
                            '15 Videos',
                            style: GoogleFonts.getFont(
                              'Poppins',
                              color: const Color(0xFFDBDBDB),
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
                            color: Color(0xFFDBDBDB),
                            size: 20,
                          ),
                          Text(
                            '5 Quizzez',
                            style: GoogleFonts.getFont(
                              'Poppins',
                              color: const Color(0xFFDBDBDB),
                              fontSize: 14,
                            ),
                          ),
                        ].divide(const SizedBox(width: 10)),
                      ),
                    ].divide(const SizedBox(width: 40)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
