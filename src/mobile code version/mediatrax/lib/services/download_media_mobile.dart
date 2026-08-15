import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gal/gal.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class DownloadVideo{
  Future<void> downloadVideo(String urlOId, context) async {

    final yt = YoutubeExplode();

    final id = extractVideoId(urlOId);
    final video = await yt.videos.get(id);

    final manifest = await yt.videos.streams.getManifest(video.id);

    final streamInfo = manifest.muxed.withHighestBitrate();

    // 1. Primero descargamos a una carpeta temporal propia de la app
    // (gal necesita un archivo ya existente en disco, no un stream)
    final tempDir = await getTemporaryDirectory();

    final rutaTemporal = '${tempDir.path}/${video.id}.${streamInfo.container.name}';

    final archivoTemp = File(rutaTemporal);

    final fileStream = archivoTemp.openWrite();

    final stream = yt.videos.streams.get(streamInfo);

    final stopwatch = Stopwatch()..start();
    var bytesDonwloaded = 0;
    final totalBytes = streamInfo.size.totalBytes;

    await for (final chunk in stream) {
      bytesDonwloaded +=  chunk.length;
      fileStream.add(chunk);

      final mbDownloaded = bytesDonwloaded / (1024 * 1024);
      final mbTotal = totalBytes / (1024 * 1024);

      onProgress?.call(mbDownloaded, mbTotal, stopwatch.elapsed);
    }

    
    await stream.pipe(fileStream);

    await fileStream.flush();

    await fileStream.close();
    yt.close();
    // 2. gal copia ese archivo temporal hacia la Galería del sistema
    await Gal.putVideo(rutaTemporal);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          elevation: 8.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(12.0)
          ),
          backgroundColor: Colors.grey[900],
          title: Text('Download Successful', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          content: Text('Your Video is located in Galeria'),
          actions: [
            TextButton(
              onPressed:() {
                Navigator.of(context).pop();
              },
              child: Text('OK',style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),)
            )       
          ],
        );
      }
    );
  }


  Future <void> downloadAudio(String urlOId, context) async {
    final youtube = YoutubeExplode();

    final id = extractAudioId(urlOId);
    final video = await youtube.videos.get(id);
    
    final manifest = await youtube.videos.streams.getManifest(video.id);

    final streamInfo = manifest.audioOnly.withHighestBitrate();
    
    // Download a temp folder
    final tempDir = await getTemporaryDirectory();
    final tempRoute = '${tempDir.path}/${video.id}.${streamInfo.container.name}';
    final tempFile = File(tempRoute);

    final fileStream = tempFile.openWrite();
    final stream = youtube.videos.streams.get(streamInfo);
    await stream.pipe(fileStream);
    await fileStream.flush();
    await fileStream.close();
    youtube.close();

    await SharePlus.instance.share(
  ShareParams(
    files: [XFile(tempRoute)],
    text: video.title,
  ),
);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          elevation: 8.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(12.0)
          ),
          contentPadding: EdgeInsets.all(24.0),
          backgroundColor: Colors.grey[900],
          title: Text('Download Successful', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          content: Text('Select where to save it'),
          actions: [
            TextButton(
              onPressed:() {
                Navigator.of(context).pop();
              },
              child: Text('OK', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),)
            )       
          ],
        );
      }
    );

  }
  /// Extrae el ID del video sin importar el formato de la URL
/// (soporta: watch?v=, youtu.be/, shorts/, o el ID solo)
String extractVideoId(String urlOId) {
  final regex = RegExp(
    r'(?:youtube\.com\/(?:watch\?v=|shorts\/)|youtu\.be\/)([a-zA-Z0-9_-]{11})',
  );
  final match = regex.firstMatch(urlOId);
  if (match != null) {
    return match.group(1)!;
  }
  // Si no matchea ningún patrón, asumimos que ya es un ID de 11 caracteres
  return urlOId;
}

String extractAudioId(String urlOId) {
  final regex = RegExp(
    r'(?:youtube\.com\/(?:watch\?v=|shorts\/)|youtu\.be\/)([a-zA-Z0-9_-]{11})',
  );
  final match = regex.firstMatch(urlOId);
  if (match != null) {
    return match.group(1)!;
  }
  // Si no matchea ningún patrón, asumimos que ya es un ID de 11 caracteres
  return urlOId;
}
}
