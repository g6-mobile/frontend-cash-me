import 'package:pocket_swap_fisi/domain/entities/chat/chat.dart';
import 'package:pocket_swap_fisi/domain/entities/chat/create_room.dart';
import 'package:pocket_swap_fisi/domain/entities/chat/get_chat.dart';
import 'package:pocket_swap_fisi/domain/entities/chat/room.dart';
import 'package:pocket_swap_fisi/domain/services/room_service.dart';

class RoomUsecase {
  final RoomService _roomService;

  RoomUsecase(this._roomService);

  Future<void> createRoom(CreateRoom roomDto) async {
    final room = await _roomService.createRoom(roomDto);
    return room;
  }

  Future<List<Room>> getRooms() async {
    final rooms = await _roomService.getRooms();
    return rooms;
  }

  Future<Chat> getChats(String roomId, GetChat chat) async {
    final chats = await _roomService.getChats(roomId, chat);
    return chats;
  }
}
