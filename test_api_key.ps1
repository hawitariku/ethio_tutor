# PowerShell script to test Addis AI API key
# Usage: .\test_api_key.ps1 YOUR_API_KEY_HERE

param(
    [Parameter(Mandatory=$true)]
    [string]$ApiKey
)

$baseUrl = "https://api.addisassistant.com/api/v1"

Write-Host "🔍 Testing Addis AI API key..." -ForegroundColor Cyan
Write-Host "📡 Base URL: $baseUrl" -ForegroundColor Gray
Write-Host "🔑 API Key: $($ApiKey.Substring(0, [Math]::Min(10, $ApiKey.Length)))...`n" -ForegroundColor Gray

# Test 1: Chat Generation API
Write-Host "Test 1: Chat Generation API" -ForegroundColor Yellow
try {
    $headers = @{
        "Content-Type" = "application/json"
        "X-API-Key" = $ApiKey
    }
    
    $body = @{
        prompt = "Say hello in Amharic"
        target_language = "am"
    } | ConvertTo-Json

    $response = Invoke-WebRequest -Uri "$baseUrl/chat_generate" -Method Post -Headers $headers -Body $body -ErrorAction Stop
    
    if ($response.StatusCode -eq 200) {
        Write-Host "✅ Chat API: SUCCESS" -ForegroundColor Green
        $content = $response.Content.Substring(0, [Math]::Min(100, $response.Content.Length))
        Write-Host "   Response: $content...`n" -ForegroundColor Gray
    }
} catch {
    if ($_.Exception.Response.StatusCode -eq 401) {
        Write-Host "❌ Chat API: FAILED - Invalid API Key (401 Unauthorized)" -ForegroundColor Red
        Write-Host "   Please check your API key at https://addisassistant.com`n" -ForegroundColor Red
        exit 1
    } else {
        Write-Host "❌ Chat API: ERROR - $($_.Exception.Message)`n" -ForegroundColor Red
    }
}

# Test 2: TTS API
Write-Host "Test 2: Text-to-Speech API" -ForegroundColor Yellow
try {
    $headers = @{
        "Content-Type" = "application/json"
        "X-API-Key" = $ApiKey
    }
    
    $body = @{
        text = "ሰላም"
        language = "am"
    } | ConvertTo-Json

    $response = Invoke-WebRequest -Uri "$baseUrl/audio" -Method Post -Headers $headers -Body $body -ErrorAction Stop
    
    if ($response.StatusCode -eq 200) {
        Write-Host "✅ TTS API: SUCCESS" -ForegroundColor Green
        Write-Host "   Audio data received`n" -ForegroundColor Gray
    }
} catch {
    if ($_.Exception.Response.StatusCode -eq 401) {
        Write-Host "❌ TTS API: FAILED - Invalid API Key (401 Unauthorized)`n" -ForegroundColor Red
        exit 1
    } else {
        Write-Host "❌ TTS API: ERROR - $($_.Exception.Message)`n" -ForegroundColor Red
    }
}

Write-Host "✅ API key validation complete!" -ForegroundColor Green
Write-Host "Your API key appears to be working correctly." -ForegroundColor Green
