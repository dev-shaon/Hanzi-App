import 'package:flutter/material.dart';
import '../features/fan_side/message/model/inbox_response_model.dart';

class ChatProvider extends ChangeNotifier {
  List<Message> _cList = [];

  List<Message> get cList => _cList;

  void setMessages(List<Message> messages) {
    _cList = List.from(messages);
    notifyListeners();
  }

  void addMessage(Message message) {
    _cList.insert(0, message);
    notifyListeners();
  }

  void removeMessage(Message message) {
    _cList.remove(message);
    notifyListeners();
  }

  void clearMessages() {
    _cList.clear();
    notifyListeners();
  }

  void replaceOptimisticMedia(Message incoming) {
    final idx = _cList.indexWhere(
      (m) =>
          m.sender?.id == incoming.sender?.id &&
          m.file != null &&
          !m.file!.startsWith('http'),
    );
    if (idx != -1) {
      _cList[idx] = incoming;
    } else {
      _cList.insert(0, incoming);
    }
    notifyListeners();
  }

  // ✅ metadata.rating set করো যাতে effectiveRating কাজ করে
  void setReviewRating(int messageId, int rating) {
    if (messageId == 0) return;

    final idx = _cList.indexWhere((m) => m.id == messageId);
    if (idx != -1) {
      final old = _cList[idx];
      _cList[idx] = old.copyWith(
        rating: rating,
        metadata: (old.metadata ?? MessageMetadata()).copyWith(
          submitted: true,
          rating: rating, // ✅ metadata তেও rating save
        ),
      );
      notifyListeners();
    }
  }

  // ✅ Download key accept এর পর order status locally update
  void updateMessageOrderStatus(int messageId, String status) {
    final idx = _cList.indexWhere((m) => m.id == messageId);
    if (idx != -1) {
      final old = _cList[idx];
      _cList[idx] = old.copyWith(
        order: old.order?.copyWith(status: status) ?? Order(status: status),
      );
      notifyListeners();
    }
  }
}
