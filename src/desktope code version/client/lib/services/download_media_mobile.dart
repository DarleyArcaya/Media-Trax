import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gal/gal.dart';
import 'package:path_provider/path_provider.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';


class DownloadVideo{
  Future<void> descargarVideoAGaleria(String urlOId, context) async {

    final yt = YoutubeExplode();

    final video = await yt.videos.get(urlOId);

    final manifest = await yt.videos.streams.getManifest(video.id);

    final streamInfo = manifest.muxed.withHighestBitrate();

    // 1. Primero descargamos a una carpeta temporal propia de la app
    // (gal necesita un archivo ya existente en disco, no un stream)
    final tempDir = await getTemporaryDirectory();

    final rutaTemporal = '${tempDir.path}/${video.id}.${streamInfo.container.name}';

    final archivoTemp = File(rutaTemporal);

    final fileStream = archivoTemp.openWrite();

    final stream = yt.videos.streams.get(streamInfo);

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
          backgroundColor: Colors.grey[900],
          title: Text('Download Successful'),
          content: Text('Your Video is located in Galeria'),
          actions: [
            TextButton(
              onPressed:() {
                Navigator.of(context).pop();
              },
              child: Text('OK')
            )       
          ],
        );
      }
    );
  }

}
