using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;
using System.IO;

public class LuaZip
{
    [MenuItem("Asset/CopyLua")]
    public static void ZipLua()
    {
        string sourcePath = Directory.GetCurrentDirectory() + "/Lua/";
        string targetPath = Path.Combine(Application.streamingAssetsPath, "Lua");
        string[] files = Directory.GetFiles(sourcePath);

        if (!Directory.Exists(targetPath))
            Directory.CreateDirectory(targetPath);

        // Copy the files and overwrite destination files if they already exist.
        foreach (string s in files)
        {
            // Use static Path methods to extract only the file name from the path.
            string fileName = Path.GetFileName(s);
            string destFile = Path.Combine(targetPath, fileName);
            File.Copy(s, destFile, true);
        }
    }
}
