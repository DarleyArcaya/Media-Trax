import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ApiDownloadMedia {
  static Future<void> downloadAudio(String url, BuildContext context) async {
    try {
      final response = await http.get(
        Uri.parse('http://127.0.0.1:8000/download_audio?url=${Uri.encodeComponent(url)}'),
      );

      if (response.statusCode == 200) {

        if (!context.mounted) return;

        showDialog(
          context: context,
          builder:(context) {
            return AlertDialog(
              backgroundColor: Colors.grey[900],
              title: Text('Download Successful', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)),
              content: Text('Your Audio is located in Download Folder.', style: TextStyle(color: Colors.white)),
              actions: [
                TextButton(
                  onPressed:() {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK', style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold)),
                
                )
              ]
            );
          },
        );
      }

      if (response.statusCode == 202) {
        if (!context.mounted) return;

        showDialog(
          context: context,
          builder:(context) {
            return AlertDialog(
              backgroundColor: Colors.grey[900],
              title: Text('Download in Progress', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)),
              content: Text('Your Audio is being downloaded. Please wait.', style: TextStyle(color: Colors.white)),
              actions: [
                TextButton(
                  onPressed:() {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK', style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold)),
                
                )
              ]
            );
          },
        );
      }

      if (response.statusCode == 400) {
        if (!context.mounted) return;

        showDialog(
          context: context,
          builder:(context) {
            return AlertDialog(
              backgroundColor: Colors.grey[900],
              title: Text('Invalid URL', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 20)),
              content: Text('Please enter a valid URL.', style: TextStyle(color: Colors.white)),
              actions: [
                TextButton(
                  onPressed:() {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                
                )
              ]
            );
          },
        );
      }

    } catch (e) {
      if (!context.mounted) return;

        showDialog(
          context: context,
          builder:(context) {
            return AlertDialog(
              backgroundColor: Colors.grey[900],
              title: Text('API Error: API NOT FOUND', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 20)),
              content: Text('$e', style: TextStyle(color: Colors.white)),
              actions: [
                TextButton(
                  onPressed:() {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                
                )
              ]
            );
          },
        );
    }
  } 

  static Future<void> downloadVideo(String url, context) async {
    try {
      final response = await http.get(Uri.parse('http://127.0.0.1:8000/download_video?url=${Uri.encodeComponent(url)}'));

      if (response.statusCode == 200) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: Colors.grey[900],
              title: Text('Download Successful', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)),
              content: Text('Your Video is located in Download Folder.', style: TextStyle(color: Colors.white)),
              actions: [
                TextButton(
                  onPressed:() {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK', style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold)),
                
                )
              ]
            );
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: Colors.grey[900],
              title: Text('Download Failed', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 20)),
              content: Text('Failed to download video. Please try again.', style: TextStyle(color: Colors.white)),
              actions: [
                TextButton(
                  onPressed:() {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                
                )
              ]
            );
          },
        );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.grey[900],
            title: Text('API Error', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 20)),
            content: Text('An error occurred while downloading the video.', style: TextStyle(color: Colors.white)),
            actions: [
              TextButton(
                onPressed:() {
                  Navigator.of(context).pop();
                },
                child: Text('OK', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
              
              )
            ]
          );
        },
      );
    }
  }
}