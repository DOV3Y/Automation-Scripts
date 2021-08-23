$URLListFile = Read-Host "Enter wordlist file path here" #Enter path here i.e C:\Documents\test.txt
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
$redirectTest = ([System.Uri]$redirect).Host -replace '^www\.'
$RedirectCheck = $redirectTest -ne $Uri
  #All the above results are stored in an array
  $rdSites += [PSCustomObject] @{
    Time = Get-Date;
    Uri = $uri;
    Redirect = $redirect;
    Redirection = $RedirectCheck  
  }
}
$rdSites
