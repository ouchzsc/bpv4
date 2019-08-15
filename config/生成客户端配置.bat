@echo off

java -XX:+UseG1GC -jar ../lib/configgen.jar -datadir . -gen lua,dir:../Lua,own:client

echo ---已生成代码到Lua/cfg，记得到这个目录，上传改动到svn哦---

pause