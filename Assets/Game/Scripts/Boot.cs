using System.Collections;
using System.Collections.Generic;
using System.IO;
using XLua;
using UnityEngine;
using Res;

public class Boot : MonoBehaviour
{
    public bool useLuaZip = false;

    LuaTable mainLuaTable = null;
    LuaFunction updateFunc = null;
    LuaFunction fixedUpdateFunc = null;
    LuaFunction lateUpdateFunc = null;
    void Start()
    {
        //启动lua
        LuaEnv env = new LuaEnv();
        env.AddLoader(myLuaLoader);
        mainLuaTable = env.DoString("return require 'main'")[0] as LuaTable;
        LuaFunction startFunc = mainLuaTable.GetInPath<LuaFunction>("start") as LuaFunction;
        updateFunc = mainLuaTable.GetInPath<LuaFunction>("update") as LuaFunction;
        fixedUpdateFunc = mainLuaTable.GetInPath<LuaFunction>("fixedUpdate") as LuaFunction;
        lateUpdateFunc = mainLuaTable.GetInPath<LuaFunction>("lateUpdate") as LuaFunction;
        startFunc.Call();
    }

    private void Update()
    {
        updateFunc.Call();
    }

    private void FixedUpdate()
    {
        fixedUpdateFunc.Call();
    }

    private void LateUpdate()
    {
        lateUpdateFunc.Call();
    }

    byte[] myLuaLoader(ref string fileName)
    {
        if (useLuaZip)
        {
            string filePath = Path.Combine(Application.streamingAssetsPath, "Lua", fileName);
            filePath = filePath.Replace(".", "/") + ".lua";
            return File.ReadAllBytes(filePath);
        }
        else
        {
            string filePath = Path.Combine(Directory.GetCurrentDirectory(), "Lua", fileName);
            filePath = filePath.Replace(".", "/") + ".lua";
            return File.ReadAllBytes(filePath);
        }
    }
}