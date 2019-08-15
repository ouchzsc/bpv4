using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;
using System.IO;
using System;

public class LuaZip
{
    [MenuItem("Assets/CopyLua")]
    public static void ZipLua()
    {
        string sourcePath = Directory.GetCurrentDirectory() + "/Lua/";
        string targetPath = Path.Combine(Application.streamingAssetsPath, "Lua");
    
        if (!Directory.Exists(targetPath))
            Directory.CreateDirectory(targetPath);

        directoryCopy(sourcePath, targetPath);
    }

    public static void directoryCopy(string sourceDirectory, string targetDirectory)
    {
        try
        {
            DirectoryInfo dir = new DirectoryInfo(sourceDirectory);
            //获取目录下（不包含子目录）的文件和子目录
            FileSystemInfo[] fileinfo = dir.GetFileSystemInfos();
            foreach (FileSystemInfo i in fileinfo)
            {
                if (i is DirectoryInfo)     //判断是否文件夹
                {
                    if (!Directory.Exists(targetDirectory + "\\" + i.Name))
                    {
                        //目标目录下不存在此文件夹即创建子文件夹
                        Directory.CreateDirectory(targetDirectory + "\\" + i.Name);
                    }
                    //递归调用复制子文件夹
                    directoryCopy(i.FullName, targetDirectory + "\\" + i.Name);
                }
                else
                {
                    //不是文件夹即复制文件，true表示可以覆盖同名文件
                    File.Copy(i.FullName, targetDirectory + "\\" + i.Name, true);
                }
            }
        }
        catch (Exception ex)
        {
            
        }
    }
}
