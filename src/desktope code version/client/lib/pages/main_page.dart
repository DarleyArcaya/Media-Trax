import 'package:client/services/download_media_mobile.dart';
import 'package:flutter/material.dart';
import 'package:client/services/api_service.dart';


class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {


  final TextEditingController _urlAudioController = TextEditingController();
  final TextEditingController _urlVideoController = TextEditingController();

  final downloadVideo = DownloadVideo();
  void _downloadAudio(String url, BuildContext context) async {
    try {
      await ApiDownloadMedia.downloadAudio(url, context);
      setState(() {});
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error downloading audio: $e')),
      );
    }
  }

  void _downloadVideo(String url, BuildContext context) async {
    try {
      await ApiDownloadMedia.downloadVideo(url, context);
      setState(() {});
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error downloading video: $e')),
      );
    }
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MediaTrax", 
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)
        ),
        
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 600,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(16),
              ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Download Audio", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                TextField(
              controller: _urlAudioController,
              decoration: InputDecoration(
                hintText: 'Enter the URL',
                filled: true,
                fillColor: Colors.grey[800],
                contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                prefixIcon: Icon(Icons.link, color: Colors.teal),
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear, color: Colors.red),
                  onPressed: () {
                    _urlAudioController.clear();
                  }
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: Colors.teal, width: 2.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: Colors.teal, width: 2.0),
                ),
  
            )
          ),

          SizedBox(height: 16),

        Text('Download Video', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
         TextField(
          controller: _urlVideoController,
          decoration: InputDecoration(
            hintText: 'Enter the URl',
            filled: true,
            fillColor: Colors.grey[800],
            contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            prefixIcon: Icon(Icons.link, color: Colors.teal),
            suffixIcon: IconButton(
              icon: Icon(Icons.clear, color: Colors.red),
              onPressed: () {
                _urlVideoController.clear();
              }
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: Colors.teal, width: 2.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: Colors.teal, width: 2.0),
            ),
          )
         ),

          SizedBox(height: 16),


          ElevatedButton(
            onPressed:() {
              final audioUrl = _urlAudioController.text;
              final videoUrl = _urlVideoController.text;

              if (audioUrl.isEmpty && videoUrl.isEmpty){
                showDialog(
                  context: context,
                  builder:(context) {
                    return AlertDialog(
                      backgroundColor: Colors.grey[900],
                      title: Text('No URL Provided', style: TextStyle(color: Colors.lightBlue, fontWeight: FontWeight.bold, fontSize: 20)),
                      content: Text('Please enter a URL to download.', style: TextStyle(color: Colors.white)),
                      actions: [
                        TextButton(
                          onPressed:() {
                            Navigator.of(context).pop();
                          },
                          child: Text('OK', style: TextStyle(color: Colors.lightBlue, fontWeight: FontWeight.bold)),
                        
                        )
                      ]
                    );
                  },
                );
              } else {
                
                  if (audioUrl.isNotEmpty) {
                  _downloadAudio(audioUrl, context);
                }
                  if (videoUrl.isNotEmpty) {
                    _downloadVideo(videoUrl, context);
                  }
  
                
                
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              elevation: 2,
              padding: EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              

            ),
            child: Text('Download',
            style: TextStyle(fontSize: 24, 
            fontWeight: FontWeight.bold,
            color: Colors.white,
            )
            ),
            )
                ]
              )
            ),
          ]
        ),
      ),
    );
  }
}