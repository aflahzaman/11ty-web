# pyftsubset "BenchNine-Bold.ttf" --output-file="BenchNine-Bold-kern-latin.woff2" --flavor=woff2 --layout-features=ccmp,locl,mark,mkmk,kern --no-hinting --desubroutinize --unicodes=U+20,U+45,U+61,U+63,U+65,U+67,U+69,U+6C-70,U+72-74,U+76,U+79

# npm install datauri-cli -g
# datauri BenchNine-Bold-kern-latin.woff2 --copy

pyftsubset "BenchNine-Bold.ttf" --output-file="BenchNine-Bold-kern-latin.woff2" --flavor=woff2 --layout-features=ccmp,locl,mark,mkmk,kern --no-hinting --desubroutinize --unicodes=U+20-7E,U+D6,U+D8,U+E9,U+F4,U+F6,U+F8,U+15A,U+200B,U+2014,U+2019,U+2026
pyftsubset "RobotoMono-Regular.ttf" --output-file="RobotoMono-Regular-kern-latin.woff2" --flavor=woff2 --layout-features=ccmp,locl,mark,mkmk,kern --no-hinting --desubroutinize --unicodes=U+0000-00FF,U+0131,U+0152-0153,U+02BB-02BC,U+02C6,U+02DA,U+02DC,U+0304,U+0308,U+0329,U+2000-206F,U+20AC,U+2122,U+2191,U+2193,U+2212,U+2215,U+FEFF,U+FFFD
pyftsubset "RobotoMono-Regular.ttf" --output-file="RobotoMono-Regular-kern-latinext.woff2" --flavor=woff2 --layout-features=ccmp,locl,mark,mkmk,kern --no-hinting --desubroutinize --unicodes=U+0100-02BA,U+02BD-02C5,U+02C7-02CC,U+02CE-02D7,U+02DD-02FF,U+0304,U+0308,U+0329,U+1D00-1DBF,U+1E00-1E9F,U+1EF2-1EFF,U+2020,U+20A0-20AB,U+20AD-20C0,U+2113,U+2C60-2C7F,U+A720-A7FF
