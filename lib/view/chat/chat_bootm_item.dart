// import 'package:avto_baraka/bloc/web_socet_bloc/web_socket_bloc.dart';
// ignore_for_file: use_build_context_synchronously

import 'package:avto_baraka/api/models/chat__one_room_data_models.dart';
import 'package:avto_baraka/provider/image_provider/pick_image.dart';
import 'package:avto_baraka/screen/imports/imports_announcement.dart';
import 'package:avto_baraka/screen/imports/imports_cabinet.dart';
import 'package:avto_baraka/view/chat/import/import_chat_bottom_item.dart';

Container chatBottomItItem(
    BuildContext context,
    state,
    OutlineInputBorder borderStyle,
    textController,
    onFieldSubmitted,
    int currentUserId,
    int roomId,
    int recipientId) {
  PickImage pickImage = PickImage(context: context);

  List<XFile> imageFileList = [];

  // ChatOneRoomModels? sortedMessages;

  // if (state is OneRoomsLoadState) {
  //   if (state.listMessage.isNotEmpty) {
  //     sortedMessages = state.listMessage.firstWhere(
  //       (a) => a.userId != currentUserId,
  //     );
  //   }
  // }

  return Container(
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          spreadRadius: 3,
          blurRadius: 5,
          offset: const Offset(-1, 0),
        ),
      ],
      color: Colors.white,
    ),
    padding: const EdgeInsets.all(7.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        OutlinedButton(
          onPressed: () {
            dialogBuilder(
              context,
              S.of(context).qayerdanOlamiz,
              Row(
                children: [
                  ElevatedButton(
                    style: elevatedButton,
                    onPressed: () async {
                      imageFileList = await pickImage.gallery();
                      try {
                        if (imageFileList.isNotEmpty) {
                          BlocProvider.of<OneRoomBloc>(context).add(
                            OneRoomEventUpdate(
                              userId: recipientId,
                              imageFileList: imageFileList,
                              currentUserId: currentUserId,
                              roomId: roomId,
                            ),
                          );
                        }
                      } catch (e) {
                        debugPrint('Error add image: $e');
                      }
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      S.of(context).gallereyadanTanlash,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  ElevatedButton(
                    style: elevationButtonWhite,
                    onPressed: () async {
                      imageFileList = await pickImage.camera();

                      if (imageFileList.isNotEmpty) {
                        BlocProvider.of<OneRoomBloc>(context).add(
                          OneRoomEventUpdate(
                            userId: recipientId,
                            imageFileList: imageFileList,
                            currentUserId: currentUserId,
                            roomId: roomId,
                          ),
                        );
                      }

                      Navigator.of(context).pop();
                    },
                    child: Text(
                      S.of(context).rasimgaOlish,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
            );
          },
          style: elevatedButtonChat,
          child: const Icon(Icons.attachment_outlined),
        ),
        const SizedBox(
          width: 5.0,
        ),
        Expanded(
          child: TextFormField(
            controller: textController,
            maxLines: null,
            keyboardType: TextInputType.multiline,
            minLines: 1,
            decoration: InputDecoration(
              hintText: S.of(context).habar,
              hintStyle: const TextStyle(color: Colors.black12),
              focusedBorder: borderStyle,
              enabledBorder: borderStyle,
              contentPadding: const EdgeInsets.only(
                  left: 18.0, right: 18.0, bottom: 2.0, top: 2.0),
            ),
          ),
        ),
        const SizedBox(
          width: 5.0,
        ),
        OutlinedButton(
          onPressed: () {
            BlocProvider.of<OneRoomBloc>(context).add(
              OneRoomEventUpdate(
                userId: recipientId,
                message: textController.text,
                currentUserId: currentUserId,
                roomId: roomId,
              ),
            );
            // onFieldSubmitted();
            textController.clear();
          },
          style: elevatedButtonChat,
          child: const Icon(Icons.send),
        ),
      ],
    ),
  );
}
