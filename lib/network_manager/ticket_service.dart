import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

// Main TicketService class
class TicketService {
  late final TawkToApiService _apiService;
  static TicketService? _instance;

  // Singleton pattern
  TicketService._internal() {
    _apiService = TawkToApiService(
      apiKey: 'YOUR_API_KEY', // Replace with your actual API key
      propertyId: 'YOUR_PROPERTY_ID', // Replace with your property ID
    );
  }

  factory TicketService() {
    _instance ??= TicketService._internal();
    return _instance!;
  }

  // Initialize with custom credentials
  static void initialize({
    required String apiKey,
    required String propertyId,
  }) {
    _instance = TicketService._internal();
    _instance!._apiService = TawkToApiService(
      apiKey: apiKey,
      propertyId: propertyId,
    );
  }

  /// Create a new support ticket
  Future<TicketResult> createSupportTicket({
    required String userEmail,
    required String userName,
    required String subject,
    required String description,
    String priority = 'normal',
    Map<String, dynamic>? customFields,
    List<File>? attachments,
  }) async {
    try {
      // Validate input
      if (userEmail.isEmpty || userName.isEmpty || subject.isEmpty || description.isEmpty) {
        return TicketResult.error('All required fields must be provided');
      }

      if (!_isValidEmail(userEmail)) {
        return TicketResult.error('Please provide a valid email address');
      }

      final result = await _apiService.createTicket(
        subject: subject,
        message: description,
        customerEmail: userEmail,
        customerName: userName,
        priority: priority,
        customFields: customFields,
      );

      if (result != null && result['id'] != null) {
        final ticket = TawkToTicket.fromJson(result);

        // Handle attachments if provided
        if (attachments != null && attachments.isNotEmpty) {
          await _uploadAttachments(ticket.id, attachments);
        }

        return TicketResult.success(ticket);
      } else {
        return TicketResult.error('Failed to create ticket. Please try again.');
      }
    } catch (e) {
      return TicketResult.error('Error creating ticket: ${e.toString()}');
    }
  }

  /// Get all tickets for a specific user
  Future<List<TawkToTicket>> getUserTickets(String userEmail) async {
    try {
      if (!_isValidEmail(userEmail)) {
        throw Exception('Invalid email address');
      }

      final ticketsData = await _apiService.getCustomerTickets(userEmail);
      return ticketsData.map((data) => TawkToTicket.fromJson(data)).toList()
        ..sort((a, b) => b.createdAt.compareTo(a.createdAt)); // Sort by newest first
    } catch (e) {
      print('Error getting user tickets: $e');
      return [];
    }
  }

  /// Get a specific ticket by ID
  Future<TawkToTicket?> getTicketById(String ticketId) async {
    try {
      final ticketData = await _apiService.getTicket(ticketId);
      if (ticketData != null) {
        return TawkToTicket.fromJson(ticketData);
      }
      return null;
    } catch (e) {
      print('Error getting ticket: $e');
      return null;
    }
  }

  /// Update ticket status
  Future<bool> updateTicketStatus({
    required String ticketId,
    required String status,
  }) async {
    try {
      final validStatuses = ['open', 'pending', 'resolved', 'closed'];
      if (!validStatuses.contains(status.toLowerCase())) {
        throw Exception('Invalid status. Must be one of: ${validStatuses.join(', ')}');
      }

      final result = await _apiService.updateTicket(
        ticketId: ticketId,
        status: status.toLowerCase(),
      );
      return result != null;
    } catch (e) {
      print('Error updating ticket status: $e');
      return false;
    }
  }

  /// Update ticket priority
  Future<bool> updateTicketPriority({
    required String ticketId,
    required String priority,
  }) async {
    try {
      final validPriorities = ['low', 'normal', 'high', 'urgent'];
      if (!validPriorities.contains(priority.toLowerCase())) {
        throw Exception('Invalid priority. Must be one of: ${validPriorities.join(', ')}');
      }

      final result = await _apiService.updateTicket(
        ticketId: ticketId,
        priority: priority.toLowerCase(),
      );
      return result != null;
    } catch (e) {
      print('Error updating ticket priority: $e');
      return false;
    }
  }

  /// Add a reply to a ticket
  Future<bool> addTicketReply({
    required String ticketId,
    required String message,
    bool isPrivate = false,
  }) async {
    try {
      if (message.trim().isEmpty) {
        throw Exception('Message cannot be empty');
      }

      return await _apiService.addMessageToTicket(
        ticketId: ticketId,
        message: message.trim(),
        isPrivate: isPrivate,
      );
    } catch (e) {
      print('Error adding ticket reply: $e');
      return false;
    }
  }

  /// Close a ticket
  Future<bool> closeTicket(String ticketId) async {
    return await updateTicketStatus(ticketId: ticketId, status: 'closed');
  }

  /// Reopen a ticket
  Future<bool> reopenTicket(String ticketId) async {
    return await updateTicketStatus(ticketId: ticketId, status: 'open');
  }

  /// Get tickets by status
  Future<List<TawkToTicket>> getTicketsByStatus({
    required String userEmail,
    required String status,
  }) async {
    try {
      final allTickets = await getUserTickets(userEmail);
      return allTickets.where((ticket) =>
      ticket.status.toLowerCase() == status.toLowerCase()
      ).toList();
    } catch (e) {
      print('Error getting tickets by status: $e');
      return [];
    }
  }

  /// Get ticket statistics for a user
  Future<TicketStats> getTicketStats(String userEmail) async {
    try {
      final tickets = await getUserTickets(userEmail);

      final stats = TicketStats(
        total: tickets.length,
        open: tickets.where((t) => t.status.toLowerCase() == 'open').length,
        pending: tickets.where((t) => t.status.toLowerCase() == 'pending').length,
        resolved: tickets.where((t) => t.status.toLowerCase() == 'resolved').length,
        closed: tickets.where((t) => t.status.toLowerCase() == 'closed').length,
      );

      return stats;
    } catch (e) {
      print('Error getting ticket stats: $e');
      return TicketStats(total: 0, open: 0, pending: 0, resolved: 0, closed: 0);
    }
  }

  /// Search tickets by keyword
  Future<List<TawkToTicket>> searchTickets({
    required String userEmail,
    required String keyword,
  }) async {
    try {
      final allTickets = await getUserTickets(userEmail);
      final lowercaseKeyword = keyword.toLowerCase();

      return allTickets.where((ticket) =>
      ticket.subject.toLowerCase().contains(lowercaseKeyword) ||
          ticket.messages.any((message) =>
              message.content.toLowerCase().contains(lowercaseKeyword))
      ).toList();
    } catch (e) {
      print('Error searching tickets: $e');
      return [];
    }
  }

  /// Upload attachments to a ticket
  Future<bool> _uploadAttachments(String ticketId, List<File> attachments) async {
    try {
      for (final file in attachments) {
        if (await file.exists()) {
          // Implementation depends on tawk.to's attachment API
          // This is a placeholder for the actual implementation
          await _apiService.uploadAttachment(ticketId, file);
        }
      }
      return true;
    } catch (e) {
      print('Error uploading attachments: $e');
      return false;
    }
  }

  /// Validate email format
  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  /// Get available priorities
  List<String> getAvailablePriorities() {
    return ['low', 'normal', 'high', 'urgent'];
  }

  /// Get available statuses
  List<String> getAvailableStatuses() {
    return ['open', 'pending', 'resolved', 'closed'];
  }
}

// Enhanced TawkToApiService with additional methods
class TawkToApiService {
  final String baseUrl = 'https://api.tawk.to/v3';
  final String apiKey;
  final String propertyId;

  TawkToApiService({
    required this.apiKey,
    required this.propertyId,
  });

  Map<String, String> get _headers => {
    'Authorization': 'Bearer $apiKey',
    'Content-Type': 'application/json',
  };

  /// Create a new ticket
  Future<Map<String, dynamic>?> createTicket({
    required String subject,
    required String message,
    required String customerEmail,
    required String customerName,
    String priority = 'normal',
    Map<String, dynamic>? customFields,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/tickets'),
        headers: _headers,
        body: jsonEncode({
          'propertyId': propertyId,
          'subject': subject,
          'message': message,
          'requester': {
            'name': customerName,
            'email': customerEmail,
          },
          'priority': priority,
          'customFields': customFields ?? {},
        }),
      );

      if (response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        print('Error creating ticket: ${response.statusCode} - ${response.body}');
        return null;
      }
    } catch (e) {
      print('Exception creating ticket: $e');
      return null;
    }
  }

  /// Get ticket details
  Future<Map<String, dynamic>?> getTicket(String ticketId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/tickets/$ticketId'),
        headers: _headers,
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print('Error getting ticket: ${response.statusCode} - ${response.body}');
        return null;
      }
    } catch (e) {
      print('Exception getting ticket: $e');
      return null;
    }
  }

  /// Update ticket
  Future<Map<String, dynamic>?> updateTicket({
    required String ticketId,
    String? status,
    String? priority,
    String? subject,
  }) async {
    try {
      final Map<String, dynamic> updateData = {};
      if (status != null) updateData['status'] = status;
      if (priority != null) updateData['priority'] = priority;
      if (subject != null) updateData['subject'] = subject;

      final response = await http.put(
        Uri.parse('$baseUrl/tickets/$ticketId'),
        headers: _headers,
        body: jsonEncode(updateData),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print('Error updating ticket: ${response.statusCode} - ${response.body}');
        return null;
      }
    } catch (e) {
      print('Exception updating ticket: $e');
      return null;
    }
  }

  /// Add message to ticket
  Future<bool> addMessageToTicket({
    required String ticketId,
    required String message,
    bool isPrivate = false,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/tickets/$ticketId/messages'),
        headers: _headers,
        body: jsonEncode({
          'message': message,
          'isPrivate': isPrivate,
        }),
      );

      return response.statusCode == 201;
    } catch (e) {
      print('Exception adding message: $e');
      return false;
    }
  }

  /// Get all tickets for a customer
  Future<List<Map<String, dynamic>>> getCustomerTickets(String customerEmail) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/tickets?customerEmail=$customerEmail'),
        headers: _headers,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return List<Map<String, dynamic>>.from(data['tickets'] ?? []);
      } else {
        print('Error getting customer tickets: ${response.statusCode} - ${response.body}');
        return [];
      }
    } catch (e) {
      print('Exception getting customer tickets: $e');
      return [];
    }
  }

  /// Upload attachment to ticket
  Future<bool> uploadAttachment(String ticketId, File file) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/tickets/$ticketId/attachments'),
      );

      request.headers.addAll({
        'Authorization': 'Bearer $apiKey',
      });

      request.files.add(
        await http.MultipartFile.fromPath('file', file.path),
      );

      final response = await request.send();
      return response.statusCode == 201;
    } catch (e) {
      print('Exception uploading attachment: $e');
      return false;
    }
  }
}

// Result wrapper for better error handling
class TicketResult {
  final bool isSuccess;
  final TawkToTicket? ticket;
  final String? error;

  TicketResult.success(this.ticket) : isSuccess = true, error = null;
  TicketResult.error(this.error) : isSuccess = false, ticket = null;
}

// Ticket statistics model
class TicketStats {
  final int total;
  final int open;
  final int pending;
  final int resolved;
  final int closed;

  TicketStats({
    required this.total,
    required this.open,
    required this.pending,
    required this.resolved,
    required this.closed,
  });

  Map<String, int> toMap() {
    return {
      'total': total,
      'open': open,
      'pending': pending,
      'resolved': resolved,
      'closed': closed,
    };
  }
}

// Enhanced ticket model
class TawkToTicket {
  final String id;
  final String subject;
  final String status;
  final String priority;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String customerName;
  final String customerEmail;
  final List<TawkToMessage> messages;
  final Map<String, dynamic> customFields;
  final List<String> tags;

  TawkToTicket({
    required this.id,
    required this.subject,
    required this.status,
    required this.priority,
    required this.createdAt,
    this.updatedAt,
    required this.customerName,
    required this.customerEmail,
    required this.messages,
    this.customFields = const {},
    this.tags = const [],
  });

  factory TawkToTicket.fromJson(Map<String, dynamic> json) {
    return TawkToTicket(
      id: json['id'] ?? '',
      subject: json['subject'] ?? '',
      status: json['status'] ?? '',
      priority: json['priority'] ?? '',
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      customerName: json['requester']?['name'] ?? '',
      customerEmail: json['requester']?['email'] ?? '',
      messages: (json['messages'] as List<dynamic>? ?? [])
          .map((m) => TawkToMessage.fromJson(m))
          .toList(),
      customFields: Map<String, dynamic>.from(json['customFields'] ?? {}),
      tags: List<String>.from(json['tags'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'subject': subject,
      'status': status,
      'priority': priority,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'requester': {
        'name': customerName,
        'email': customerEmail,
      },
      'messages': messages.map((m) => m.toJson()).toList(),
      'customFields': customFields,
      'tags': tags,
    };
  }

  // Helper methods
  bool get isOpen => status.toLowerCase() == 'open';
  bool get isPending => status.toLowerCase() == 'pending';
  bool get isResolved => status.toLowerCase() == 'resolved';
  bool get isClosed => status.toLowerCase() == 'closed';

  bool get isHighPriority => priority.toLowerCase() == 'high' || priority.toLowerCase() == 'urgent';

  TawkToMessage? get lastMessage => messages.isNotEmpty ? messages.last : null;

  int get messageCount => messages.length;
}

// Enhanced message model
class TawkToMessage {
  final String id;
  final String content;
  final String authorType; // customer, agent
  final String? authorName;
  final DateTime createdAt;
  final bool isPrivate;
  final List<String> attachments;

  TawkToMessage({
    required this.id,
    required this.content,
    required this.authorType,
    this.authorName,
    required this.createdAt,
    required this.isPrivate,
    this.attachments = const [],
  });

  factory TawkToMessage.fromJson(Map<String, dynamic> json) {
    return TawkToMessage(
      id: json['id'] ?? '',
      content: json['content'] ?? '',
      authorType: json['authorType'] ?? '',
      authorName: json['authorName'],
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      isPrivate: json['isPrivate'] ?? false,
      attachments: List<String>.from(json['attachments'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'authorType': authorType,
      'authorName': authorName,
      'createdAt': createdAt.toIso8601String(),
      'isPrivate': isPrivate,
      'attachments': attachments,
    };
  }

  bool get isFromCustomer => authorType.toLowerCase() == 'customer';
  bool get isFromAgent => authorType.toLowerCase() == 'agent';
  bool get hasAttachments => attachments.isNotEmpty;
}