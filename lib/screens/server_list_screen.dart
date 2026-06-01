import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/server_model.dart';
import '../utils/constants.dart';
import 'webview_screen.dart';

class ServerListScreen extends StatefulWidget {
  const ServerListScreen({super.key});

  @override
  State<ServerListScreen> createState() => _ServerListScreenState();
}

class _ServerListScreenState extends State<ServerListScreen> {
  late List<ServerModel> servers;

  @override
  void initState() {
    super.initState();
    servers = List.from(ServerModel.defaultServers);
  }

  void _addNewServer() {
    final nameController = TextEditingController();
    final urlController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppConstants.primaryColor,
        title: const Text(
          '⚽ Add New Stadium',
          style: TextStyle(color: Color(0xFFFFD700), fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              style: const TextStyle(color: Color(0xFFFFD700)),
              decoration: InputDecoration(
                labelText: 'Stadium Name',
                labelStyle: const TextStyle(color: Color(0xFFFFD700)),
                hintText: 'My Stadium',
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xFFFFD700)),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xFFFFD700), width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: AppConstants.backgroundColor,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: urlController,
              style: const TextStyle(color: Color(0xFFFFD700)),
              keyboardType: TextInputType.url,
              decoration: InputDecoration(
                labelText: 'Server URL',
                labelStyle: const TextStyle(color: Color(0xFFFFD700)),
                hintText: 'http://192.168.1.100',
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xFFFFD700)),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xFFFFD700), width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: AppConstants.backgroundColor,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.isNotEmpty &&
                  urlController.text.isNotEmpty) {
                setState(() {
                  servers.add(ServerModel(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    name: nameController.text,
                    url: urlController.text,
                  ));
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('⚽ ${nameController.text} added!'),
                    backgroundColor: const Color(0xFF1B5E20),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppConstants.accentText,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Add Stadium',
              style: TextStyle(color: Color(0xFF1B5E20), fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '⚽ Stadium Streams',
          style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFFFD700)),
        ),
        centerTitle: true,
        backgroundColor: AppConstants.primaryColor,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppConstants.backgroundColor,
              AppConstants.primaryColor,
            ],
          ),
        ),
        child: servers.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.tv_off,
                        size: 80, color: Colors.grey.shade600),
                    const SizedBox(height: 16),
                    Text(
                      'No servers added',
                      style: TextStyle(
                        color: Colors.grey.shade400,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: servers.length,
                itemBuilder: (context, index) {
                  return _buildServerCard(servers[index], index);
                },
              ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addNewServer,
        icon: const Icon(Icons.add),
        label: const Text('Add Stadium'),
        backgroundColor: AppConstants.accentText,
        foregroundColor: AppConstants.primaryColor,
      ),
    );
  }

  Widget _buildServerCard(ServerModel server, int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      color: AppConstants.cardColor.withOpacity(0.8),
      child: InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WebViewScreen(
              url: server.url,
              name: server.name,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppConstants.primaryColor,
                    const Color(0xFF2E7D32),
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: AppConstants.accentText.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
                child: Center(
                  child: Text(
                    server.icon,
                    style: const TextStyle(fontSize: 28),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      server.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      server.url,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade400,
                        fontFamily: 'monospace',
                      ),
                    ),
                    if (server.description.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        server.description,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppConstants.accentText,
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.sports_soccer, color: Color(0xFF1B5E20), size: 18),
                    SizedBox(width: 4),
                    Text(
                      'Watch',
                      style: TextStyle(
                        color: Color(0xFF1B5E20),
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    )
        .animate()
        .fadeIn(
          delay: Duration(milliseconds: index * 100),
          duration: const Duration(milliseconds: 400),
        )
        .slideX(
          begin: 0.3,
          end: 0,
          delay: Duration(milliseconds: index * 100),
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOut,
        );
  }
}
