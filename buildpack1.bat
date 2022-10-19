ECHO ON
SETLOCAL
SET VERSION="4.0.0-beta"

rmdir obj /s /q
rmdir Release /s /q
dotnet build .\tools\versionupdater\versionupdater.csproj /p:Configuration=Release /p:OutputPath=..\bin || exit /B 1
tools\bin\versionupdater -v %VERSION% || exit /B 1

dotnet build /p:RestorePackages=true /p:Configuration=Release Mapsui/Mapsui.csproj
dotnet build /p:RestorePackages=true /p:Configuration=Release Mapsui.Rendering.Skia/Mapsui.Rendering.Skia.csproj
dotnet build /p:RestorePackages=true /p:Configuration=Release Mapsui.Tiling/Mapsui.Tiling.csproj
dotnet build /p:RestorePackages=true /p:Configuration=Release Mapsui.Nts/Mapsui.Nts.csproj

nuget pack .\NuSpec\Mapsui.nuspec -Version %VERSION% -outputdirectory Artifacts  || exit /B 1

dotnet build /p:RestorePackages=true /p:Configuration=Release Mapsui.ArcGIS/Mapsui.ArcGIS.csproj
nuget pack .\NuSpec\Mapsui.ArcGIS.nuspec -Version %VERSION%  -outputdirectory Artifacts || exit /B 1

dotnet build /p:RestorePackages=true /p:Configuration=Release Mapsui.Extensions/Mapsui.Extensions.csproj
nuget pack .\NuSpec\Mapsui.Extensions.nuspec -Version %VERSION% -outputdirectory Artifacts   || exit /B 1


dotnet build /p:RestorePackages=true /p:Configuration=Release Mapsui.UI.Avalonia/Mapsui.UI.Avalonia.csproj
nuget pack NuSpec\Mapsui.Avalonia.nuspec -Version %VERSION% -outputdirectory Artifacts   || exit /B 1






