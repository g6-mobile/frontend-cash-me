import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pocket_swap_fisi/domain/entities/chat/chat.dart';
import 'package:pocket_swap_fisi/domain/entities/chat/create_room.dart';
import 'package:pocket_swap_fisi/domain/entities/chat/get_chat.dart';
import 'package:pocket_swap_fisi/domain/entities/chat/room.dart';
import 'package:pocket_swap_fisi/utils/constants/api_constants.dart';
import 'package:pocket_swap_fisi/utils/providers/dio_provider.dart';

class RoomService {
  final Dio dio;

  RoomService() : dio = createDio();

  Future<void> createRoom(CreateRoom room) async {
    const storage = FlutterSecureStorage();
    final accessToken = await storage.read(key: 'accessToken');
    try {
      final response = await dio.post('${ApiConstants.baseURL}/rooms',
          data: {'name': room.name, 'members': room.members, 'type': room.type},
          options: Options(headers: {'Authorization': 'Bearer $accessToken'}));

      if (response.statusCode != 201) {
        throw Exception('Failed to create room');
      }
    } on DioException catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Room>> getRooms() async {
    const storage = FlutterSecureStorage();
    final accessToken = await storage.read(key: 'accessToken');
    try {
      final response = await dio.get('${ApiConstants.baseURL}/rooms',
          options: Options(headers: {'Authorization': 'Bearer $accessToken'}));

      if (response.statusCode != 200) {
        throw Exception('Failed to get rooms');
      }

      return (response.data as List)
          .map((room) => Room.fromJson(room))
          .toList();
    } on DioException catch (e) {
      throw Exception(e);
    }
  }

  Future<Chat> getChats(String roomId, GetChat chat) async {
    const storage = FlutterSecureStorage();
    final accessToken = await storage.read(key: 'accessToken');
    try {
      String url = '${ApiConstants.baseURL}/rooms/$roomId/chats';

      if (chat.lastId != null) {
        url += '?lastId=${chat.lastId}';
        url += '&limit=${chat.limit}';
      } else {
        url += '?limit=${chat.limit}';
      }

      final response = await dio.get(
        url,
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}));

      if (response.statusCode != 200) {
        throw Exception('Failed to get chats');
      }

      return Chat.fromJson(response.data);      
    } on DioException catch (e) {
        throw Exception(e);
    }
  }
}
