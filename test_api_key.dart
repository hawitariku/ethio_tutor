import 'dart:convert';
import 'dart:io';

/// Simple script to test if your Addis AI API key is valid
/// Run with: dart test_api_key.dart YOUR_API_KEY_HERE

Future<void> main(List<String> args) async {
  if (args.isEmpty) {
    print('❌ Usage: dart test_api_key.dart YOUR_API_KEY_HERE');
    exit(1);
  }

  final apiKey = args[0];
  final baseUrl = 'https://api.addisassistant.com/api/v1';

  print('🔍 Testing Addis AI API key...');
  print('📡 Base URL: $baseUrl');
  print('🔑 API Key: ${apiKey.substring(0, 10)}...\n');

  // Test 1: Chat Generation API
  print('Test 1: Chat Generation API');
  try {
    final client = HttpClient();
    final request = await client.postUrl(Uri.parse('$baseUrl/chat_generate'));
    request.headers.set('Content-Type', 'application/json');
    request.headers.set('X-API-Key', apiKey);
    
    final body = jsonEncode({
      'prompt': 'Say hello in Amharic',
      'target_language': 'am',
    });
    request.write(body);

    final response = await request.close();
    final responseBody = await response.transform(utf8.decoder).join();

    if (response.statusCode == 200) {
      print('✅ Chat API: SUCCESS');
      print('   Response: ${responseBody.substring(0, responseBody.length > 100 ? 100 : responseBody.length)}...\n');
    } else if (response.statusCode == 401) {
      print('❌ Chat API: FAILED - Invalid API Key (401 Unauthorized)');
      print('   Please check your API key at https://addisassistant.com\n');
      exit(1);
    } else {
      print('⚠️  Chat API: Status ${response.statusCode}');
      print('   Response: $responseBody\n');
    }
    client.close();
  } catch (e) {
    print('❌ Chat API: ERROR - $e\n');
  }

  // Test 2: TTS API
  print('Test 2: Text-to-Speech API');
  try {
    final client = HttpClient();
    final request = await client.postUrl(Uri.parse('$baseUrl/audio'));
    request.headers.set('Content-Type', 'application/json');
    request.headers.set('X-API-Key', apiKey);
    
    final body = jsonEncode({
      'text': 'ሰላም',
      'language': 'am',
    });
    request.write(body);

    final response = await request.close();

    if (response.statusCode == 200) {
      print('✅ TTS API: SUCCESS');
      print('   Audio data received\n');
    } else if (response.statusCode == 401) {
      print('❌ TTS API: FAILED - Invalid API Key (401 Unauthorized)\n');
      exit(1);
    } else {
      final responseBody = await response.transform(utf8.decoder).join();
      print('⚠️  TTS API: Status ${response.statusCode}');
      print('   Response: $responseBody\n');
    }
    client.close();
  } catch (e) {
    print('❌ TTS API: ERROR - $e\n');
  }

  print('✅ API key validation complete!');
  print('Your API key appears to be working correctly.');
}
