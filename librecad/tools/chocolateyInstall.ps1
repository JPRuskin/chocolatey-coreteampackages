﻿$packageName = '{{PackageName}}'
$fileType = 'exe'
$silentArgs = '/S'
$version = '{{PackageVersion}}'
$url = "http://sourceforge.net/projects/librecad/files/Windows/${version}/LibreCAD-Installer-${version}.exe/download"

Install-ChocolateyPackage $packageName $fileType $silentArgs $url