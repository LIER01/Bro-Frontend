import 'package:bro/models/resource.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class PDFList extends StatelessWidget {
  const PDFList({
    Key? key,
    this.pdfPaths,
  }) : super(key: key);

  final List<Documents>? pdfPaths;

  @override
  Widget build(BuildContext context) {
    return pdfPaths != null
        ? pdfPaths!.isNotEmpty
            ? Column(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Text('Dokumenter',
                        style: Theme.of(context).textTheme.headline6),
                  ),
                  Container(
                      height: MediaQuery.of(context).size.height * 0.25,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: PageScrollPhysics(),
                          itemCount: pdfPaths!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return PDFCard(
                              pdfPath: pdfPaths![index].documentFile.url,
                              pdfName: pdfPaths![index].documentName,
                            );
                          })),
                ],
              )
            : Container()
        : Container();
  }
}

class PDFCard extends StatelessWidget {
  final String pdfPath;
  final String pdfName;

  PDFCard({Key? key, required this.pdfPath, required this.pdfName});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.height * 0.01),
      child: GestureDetector(
        onTap: () => {
          print('quepasa'),
          launch(pdfPath),
        },
        child: Column(
          children: [
            Container(
                width: MediaQuery.of(context).size.height * 0.10,
                height: MediaQuery.of(context).size.height * 0.15,
                child: Stack(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(5)))),
                    Align(
                      alignment: Alignment.center,
                      child: FaIcon(
                        FontAwesomeIcons.filePdf,
                        size: MediaQuery.of(context).size.width * 0.15,
                      ),
                    )
                  ],
                )),
            Container(
                width: MediaQuery.of(context).size.height * 0.10,
                child:
                    Text(pdfName, style: Theme.of(context).textTheme.bodyText2))
          ],
        ),
      ),
    );
  }
}
