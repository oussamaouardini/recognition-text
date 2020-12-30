import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_file_manager/flutter_file_manager.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';



class MyDocumentScreen extends StatefulWidget {
  @override
  _MyDocumentScreenState createState() => _MyDocumentScreenState();
}

class _MyDocumentScreenState extends State<MyDocumentScreen> {
  bool externalStoragePermissionOkay = false;

  initialisePermission() async {
    var status = await Permission.mediaLibrary.status;
    if(!status.isGranted){
      await Permission.mediaLibrary.request();
      status = await Permission.mediaLibrary.status;
      if(status.isGranted){
        setState(() {
          externalStoragePermissionOkay = true;
        });
      }
    }else{
      setState(() {
        externalStoragePermissionOkay = true;
      });
    }

  }

  var files; /// List of files

  Future initialise2() async{
    /// get the external storage directory of an Android device
    Directory extDir = await getExternalStorageDirectory();
    initialisePermission(); /// permissions

    ///async function to get list of files
    var fm = FileManager(root: Directory(extDir.path)); //
    files = await fm.filesTree(
      //  extensions: ["jpg"] //optional, to filter files, list only pdf files
    );
    setState(() {}); //update the UI
  }

  Future initialise() async{
    // get the external storage directory of an Android device
    Directory extDir = await getExternalStorageDirectory();
    initialisePermission();
   // _files = extDir.listSync(recursive: true, followLinks: false);
  }

  @override
  void initState() {
    initialise2();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
        child: files == null? Text("Searching Files"):
        ListView.builder(  //if file/folder list is grabbed, then show here
          itemCount: files?.length ?? 0,
          itemBuilder: (context, index) {
            return Card(
                child:ListTile(
                  title: Text(files[index].path.split('/').last),
                  leading: Icon(Icons.picture_as_pdf),
                  trailing: Icon(Icons.arrow_forward, color: Colors.redAccent,),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return ViewPDF(pathPDF:files[index].path.toString());
                      //open viewPDF page on click
                    }));
                  },
                )
            );
          },
        )
    );
  }
}

class ViewPDF extends StatelessWidget {
  String pathPDF = "";
  ViewPDF({this.pathPDF});

  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold( //view PDF
        appBar: AppBar(
          title: Text("Document"),
          backgroundColor: Colors.deepOrangeAccent,
        ),
        path: pathPDF
    );
  }
}
