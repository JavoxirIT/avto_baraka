# Read the hex string from the file
$hexString = Get-Content cert.pem

# Объединить с именем пакета
$packageName = "com.autobaraka.auto_baraka"
$combinedString = $packageName + " " + $hexString

# Compute SHA-256 hash
$sha256 = [System.Security.Cryptography.SHA256]::Create()
$hashBytes = $sha256.ComputeHash([System.Text.Encoding]::UTF8.GetBytes($combinedString))

# Преобразовать хэш в шестнадцатеричный код и удалить все дефисы
$hashHex = [BitConverter]::ToString($hashBytes) -replace '-', ''

# Преобразовать шестнадцатеричный в двоичный
$binaryHash = for ($i = 0; $i -lt $hashHex.Length; $i += 2) { [Convert]::ToByte($hashHex.Substring($i, 2), 16) }

# Кодируем в Base64 и берем первые 11 символов
$base64Hash = [Convert]::ToBase64String($binaryHash)
$shortHash = $base64Hash.Substring(0, 11)

# Вывести результат
$shortHash
