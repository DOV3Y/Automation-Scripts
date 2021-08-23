$URLListFile = Read-Host "Enter the path for list of sites"
$URLList = Get-Content $URLListFile -ErrorAction SilentlyContinue
  $rdSites = @()
  Foreach($Uri in $URLList) {
  try{
  $request = $null
  $result1 = Measure-Command {$webrequest = Invoke-WebRequest -Uri $uri }
  $result1.TotalMilliseconds
  } 
  catch
  {
   #pull status code if error is encountered
   $webrequest = $_.Exception.Response
   $time = -1
  } 
$url = "http://$uri"
$request = [System.Net.WebRequest]::Create($url)
$request.AllowAutoRedirect=$true

$redirect = try{
$response=$request.GetResponse()
$response.ResponseUri.AbsoluteUri
$response.Close()
}
catch{
“$_ (Possible Dead Server)”
}

#check DNS Lookup for URL
$DNS = [Net.DNS]::GetHostEntry("$uri")


$redirectTest = ([System.Uri]$redirect).Host -replace '^www\.'


$RedirectCheck = $redirectTest -ne $Uri 
  #All the above results are stored in an array
  $rdSites += [PSCustomObject] @{
    Uri = $uri;
    DNSLookup = $DNS.AddressList.IPAddressToString
  }
}
$rdSites
