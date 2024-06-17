import 'package:avto_baraka/view/chat/import/import_chat_content.dart';

Container chatContent(
    bool isMe, BuildContext context, ChatOneRoomModels mess, isTablet) {
  return Container(
    padding: const EdgeInsets.all(10.0),
    child: Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Stack(children: [
          // Rechteck mit abgerundeten Ecken
          Container(
            width: isTablet(context)
                ? MediaQuery.of(context).size.width * 0.4
                : 300.0,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            decoration: BoxDecoration(
              // color: isMe
              //     ? iconSelectedColor.withOpacity(0.1)
              //     : unselectedItemColor.withOpacity(0.1),
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: isMe
                      ? iconSelectedColor.withOpacity(0.1)
                      : unselectedItemColor.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment:
                  isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Text(
                  mess.message ?? '',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: const Color(0xFF000000)),
                  overflow: TextOverflow.visible,
                  softWrap: true,
                ),
                mess.imageList.isNotEmpty
                    ? SizedBox(
                        height: mess.imageList.length == 1
                            ? 200.0
                            : mess.imageList.length > 1
                                ? 50.0 * mess.imageList.length
                                : 200,
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: mess.imageList.length == 1
                                ? 1
                                : 2, // Change the number of columns as needed
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                          ),
                          itemCount: mess.imageList.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => Dialog(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Flexible(
                                          child: InteractiveViewer(
                                            boundaryMargin:
                                                const EdgeInsets.all(0),
                                            minScale: 0.1,
                                            maxScale: 3.0,
                                            child: SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  2,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Image.network(
                                                mess.imageList[index]['image']!,
                                                fit: BoxFit.scaleDown,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              child: Image.network(
                                mess.imageList[index]['image']!,
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                        ),
                      )
                    : const SizedBox(),
                Container(
                  margin: const EdgeInsets.only(bottom: 0.0, right: 0.0),
                  child: Text(
                    mess.date,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: const Color.fromARGB(255, 82, 82, 82),
                        ),
                    overflow: TextOverflow.fade,
                    softWrap: false,
                  ),
                ),
              ],
            ),
          ),
          // Kleines Dreieck an die ChatBubble ansetzen. Je nach Richtung der Chat-Message
          // links oder rechts
          // isMe
          //     ? Positioned(
          //         top: 0,
          //         right: 0,
          //         child: CustomPaint(
          //           painter: ChatBubbleTriangle(isMe, iconSelectedColor),
          //         ))
          //     : Positioned(
          //         top: 0,
          //         left: 0,
          //         child: CustomPaint(
          //           painter: ChatBubbleTriangle(isMe, unselectedItemColor),
          //         ))
        ]),
      ],
    ),
  );
}
