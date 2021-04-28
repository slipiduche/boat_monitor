import 'package:boat_monitor/styles/colors.dart';
import 'package:flutter/material.dart';

void updating(BuildContext _context, String message) {
  showDialog(
      context: _context,
      barrierDismissible: false,
      builder: (_context) {
        //_updatingContext = _context;
        return Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 28),
          child: Container(
            //height: 200.0,
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: 50.0,
                ),
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(blue1),
                ),
                Text(
                  '$message...',
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(
                  height: 50.0,
                ),
              ],
            ),
          ),
        );
      });
}

void updated(BuildContext _context, String message) {
  BuildContext dialogContext;
  showDialog(
      context: _context,
      barrierDismissible: true,
      builder: (context) {
        dialogContext = _context;
        return Dialog(
          //scrollable: true,
          insetPadding: EdgeInsets.symmetric(horizontal: 28.0),
          child: Container(
            // height: 100.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: 10.0,
                ),
                Icon(
                  Icons.check,
                  size: 50.0,
                  color: blue1,
                ),
                Text(
                  message,
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 50.0,
                          child: submitButton('OK', () {
                            Navigator.of(dialogContext).pop();
                            ServerDataBloc().deleteData();
                            if (message == "Updated") {
                              ServerDataBloc().requestSongs();
                              Navigator.of(context)
                                  .pushReplacementNamed('listSongsPage');
                            } else if (message == "Deleted") {
                              ServerDataBloc().requestSongs();
                              Navigator.of(context)
                                  .pushReplacementNamed('listSongsPage');
                            } else if (message == "Added") {
                              Navigator.of(context)
                                  .pushReplacementNamed('tagPage');
                            } else if (message == "Tag updated") {
                              Navigator.of(context)
                                  .pushReplacementNamed('tagPage');
                            } else if (message == "Tag deleted") {
                              Navigator.of(context)
                                  .pushReplacementNamed('tagPage');
                            } else if (message == "Room added") {
                              Navigator.of(context)
                                  .pushReplacementNamed('roomsPage');
                            } else if (message == "Room updated") {
                              Navigator.of(context)
                                  .pushReplacementNamed('roomsPage');
                            } else if (message == "Room deleted") {
                              Navigator.of(context)
                                  .pushReplacementNamed('roomsPage');
                            } else if (message == "Default updated") {
                              Navigator.of(context)
                                  .pushReplacementNamed('changeDefaultPage');
                            } else if (message == "Playlist Created") {
                              Navigator.of(context)
                                  .pushReplacementNamed('listPlayListPage');
                            } else if (message == "Playlist deleted") {
                              Navigator.of(context)
                                  .pushReplacementNamed('listPlayListPage');
                            } else if (message == "Playlist updated") {
                              Navigator.of(context)
                                  .pushReplacementNamed('listPlayListPage');
                            } else if (message == "Song added to playlist") {
                              ServerDataBloc().requestSongs();
                              Navigator.of(context)
                                  .pushReplacementNamed('listSongsPage');
                            } else if (message == "Songs added to playlist") {
                              ServerDataBloc().requestSongs();
                              Navigator.of(context)
                                  .pushReplacementNamed('listPlayListPage');
                            } else if (message == "Songs deleted") {
                              Navigator.of(context)
                                  .pushReplacementNamed('listPlayListPage');
                            }
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
              ],
            ),
          ),
        );
      });
}
