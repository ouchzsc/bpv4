@echo off

java -XX:+UseG1GC -jar ../lib/configgen.jar -datadir . -gen lua,dir:../Lua,own:client

echo ---�����ɴ��뵽Lua/cfg���ǵõ����Ŀ¼���ϴ��Ķ���svnŶ---

pause