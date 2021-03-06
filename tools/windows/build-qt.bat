set PERLIO=:raw
perl -i -pe "s, stl exceptions,," qt5\qtbase\src\angle\src\config.pri || exit /b
perl -i -pe "s,_HAS_EXCEPTIONS=0 ,," qt5\qtbase\src\angle\src\config.pri || exit /b
perl -i -pe "s, WIN32 , WIN32 _HAS_EXCEPTIONS=0 ," qt5\qtbase\mkspecs\common\msvc-desktop.conf || exit /b
set PERLIO=

mkdir qt-build || exit /b
cd qt-build
call ..\qt5\configure ^
    -opensource -confirm-license ^
    -prefix %CRYPTOSHARK_PREFIX% ^
    -feature-relocatable ^
    -release ^
    -optimize-size ^
    -ltcg ^
    -static ^
    -static-runtime ^
    -mp ^
    -no-sql-db2 -no-sql-ibase -no-sql-mysql -no-sql-oci -no-sql-odbc -no-sql-psql -no-sql-tds ^
    -nomake examples ^
    -nomake tests ^
    -opengl es2 -angle ^
    -qt-zlib -qt-libpng -qt-libjpeg ^
    -no-openssl -schannel ^
    -no-icu ^
    -no-dbus ^
    -no-feature-qml-debug ^
    || exit /b
nmake || exit /b
