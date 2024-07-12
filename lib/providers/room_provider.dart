import 'package:flutter/material.dart';
import 'package:pocket_swap_fisi/domain/entities/chat/chat.dart';
import 'package:pocket_swap_fisi/domain/entities/chat/create_room.dart';
import 'package:pocket_swap_fisi/domain/entities/chat/get_chat.dart';
import 'package:pocket_swap_fisi/domain/entities/chat/room.dart';
import 'package:pocket_swap_fisi/domain/usecases/room_usecase.dart';

class RoomProvider extends ChangeNotifier {
  List<Room> _rooms = [];
  List<Room> get rooms => _rooms;

  Chat _chats = Chat(users: [], messages: []);
  Chat get chats => _chats;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final RoomUsecase _roomUsecase;

  RoomProvider(this._roomUsecase);

  void addRoom(CreateRoom room) async {
    _isLoading = true;
    await _roomUsecase.createRoom(room);
    notifyListeners();
    _isLoading = false;
  }

  void getRooms() async {
    if (_rooms.isNotEmpty) return;
    _isLoading = true;
    final allRooms = await _roomUsecase.getRooms();
    _rooms = allRooms;
    notifyListeners();
    _isLoading = false;
  }

  void getChats(String roomId, GetChat chat) async {            
    final chats = await _roomUsecase.getChats(roomId, chat);
    _chats = chats;
    notifyListeners();    
  }
}
