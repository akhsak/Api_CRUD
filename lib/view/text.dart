import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

Widget ButtonLabel(BuildContext context, {required String text, Color? color}) {
  return Text(
    text,
    maxLines: 2,
    overflow: TextOverflow.ellipsis,
    style: GoogleFonts.montserrat(
      color: color ?? Colors.white,
      fontSize: MediaQuery.of(context).size.width * 0.04,
      fontWeight: FontWeight.bold,
    ),
  );
}

Widget textPoppins({name, color, fontweight, double? fontsize}) {
  return Text(name,
      style: GoogleFonts.poppins(
          color: color, fontWeight: fontweight, fontSize: fontsize));
}

Widget textAbel({name, color, fontweight, double? fontsize}) {
  return Text(name,
      style: GoogleFonts.abel(
          color: color, fontWeight: fontweight, fontSize: fontsize));
}

class SnackBarWidget {
  void showSuccessSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.teal,
      ),
    );
  }

  void showErrorSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }
}
alertSheet(BuildContext context,
    {onPressed, alertMessage, confirmButtonLabel}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Column(
          children: [
            textPoppins(
                name: alertMessage, fontweight: FontWeight.w600, fontsize: 15),
          ],
        ),
        actions: [
          ElevatedButton(
              style: const ButtonStyle(
                backgroundColor:
                    MaterialStatePropertyAll(Color.fromARGB(255, 4, 5, 5)),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: textPoppins(name: 'CANCEL', color: Colors.white)),
          ElevatedButton(
              style: const ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll(Color.fromARGB(255, 1, 1, 1))),
              onPressed: onPressed,
              child:
                  textPoppins(name: confirmButtonLabel, color: Colors.white)),
        ],
      );
    },
  );
}