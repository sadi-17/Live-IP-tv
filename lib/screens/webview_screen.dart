import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../utils/constants.dart';

class WebViewScreen extends StatefulWidget {
  final String url;
  final String name;

  const WebViewScreen({
    super.key,
    required this.url,
    required this.name,
  });

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late final WebViewController _controller;
  bool _isLoading = true;
  double _loadingProgress = 0;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _initializeWebView();
  }

  void _initializeWebView() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(AppConstants.backgroundColor)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            if (mounted) {
              setState(() {
                _loadingProgress = progress / 100.0;
                _isLoading = progress < 100;
              });
            }
          },
          onPageStarted: (String url) {
            if (mounted) {
              setState(() {
                _isLoading = true;
                _errorMessage = null;
              });
            }
          },
          onPageFinished: (String url) {
            if (mounted) {
              setState(() {
                _isLoading = false;
              });
            }
          },
          onWebResourceError: (WebResourceError error) {
            if (mounted) {
              setState(() {
                _isLoading = false;
                _errorMessage = 'Failed to load: ${error.description}';
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Connection error: ${error.description}'),
                  backgroundColor: Colors.red.shade700,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.name,
          style: const TextStyle(fontSize: 16, color: Color(0xFFFFD700), fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppConstants.primaryColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Color(0xFFFFD700)),
            onPressed: () => _controller.reload(),
          ),
          IconButton(
            icon: const Icon(Icons.home, color: Color(0xFFFFD700)),
            onPressed: () => _controller.loadRequest(Uri.parse(widget.url)),
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'reload':
                  _controller.reload();
                  break;
                case 'clear_cache':
                  _controller.clearCache();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('⚽ Cache cleared'),
                      backgroundColor: const Color(0xFF1B5E20),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                  break;
                case 'info':
                  _showServerInfo();
                  break;
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'reload',
                child: Row(
                  children: [
                    Icon(Icons.refresh, size: 20, color: AppConstants.accentText),
                    const SizedBox(width: 8),
                    const Text('Reload Page'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'clear_cache',
                child: Row(
                  children: [
                    Icon(Icons.cleaning_services, size: 20, color: AppConstants.accentText),
                    const SizedBox(width: 8),
                    const Text('Clear Cache'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'info',
                child: Row(
                  children: [
                    Icon(Icons.info_outline, size: 20, color: AppConstants.accentText),
                    const SizedBox(width: 8),
                    const Text('Stadium Info'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Stack(
        children: [
          // WebView
          WebViewWidget(controller: _controller),

          // Loading indicator
          if (_isLoading)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: LinearProgressIndicator(
                value: _loadingProgress,
                backgroundColor: AppConstants.cardColor,
                valueColor: const AlwaysStoppedAnimation<Color>(
                  Color(0xFFFFD700),
                ),
                minHeight: 3,
              ),
            ),

          // Error state
          if (_errorMessage != null)
            Center(
              child: Card(
                color: AppConstants.primaryColor,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 48,
                        color: Colors.red.shade400,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Connection Error',
                        style: TextStyle(
                          color: Colors.red.shade400,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _errorMessage!,
                        style: const TextStyle(
                          color: Color(0xFFFFD700),
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: () {
                          setState(() => _errorMessage = null);
                          _controller.reload();
                        },
                        icon: const Icon(Icons.refresh),
                        label: const Text('Retry'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppConstants.accentText,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () => _controller.reload(),
        backgroundColor: AppConstants.accentText,
        child: Icon(Icons.sports_soccer, color: AppConstants.primaryColor),
      ),
    );
  }

  void _showServerInfo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppConstants.primaryColor,
        title: const Text(
          '⚽ Stadium Information',
          style: TextStyle(color: Color(0xFFFFD700), fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow('Stadium Name', widget.name),
            const SizedBox(height: 12),
            _buildInfoRow('Stream URL', widget.url),
            const SizedBox(height: 12),
            _buildInfoRow('Status', _isLoading ? 'Loading...' : 'Connected ✓'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Close',
              style: TextStyle(color: Color(0xFFFFD700)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFFFFD700),
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
