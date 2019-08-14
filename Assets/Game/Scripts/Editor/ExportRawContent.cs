using UnityEngine;
using UnityEditor;
using System.IO;
using System.Collections.Generic;

public class Tools
{
    /// <summary>
    /// 遍历文件夹下所有文件，导出animation、mat、texture
    /// </summary>
    [MenuItem("Assets/Export Raw Content")]
    static void ExportRaw()
    {
        string[] strs = Selection.assetGUIDs;
        foreach (var guid in strs)
        {
            string assetPath = AssetDatabase.GUIDToAssetPath(guid);
            if (AssetDatabase.IsValidFolder(assetPath))
            {
                ExtractRawAsset(assetPath);
            }
        }
    }

    static void ExtractRawAsset(string folder)
    {
        string animFolder = Path.Combine(folder, "Animations");
        if (!Directory.Exists(animFolder))
        {
            Directory.CreateDirectory(animFolder);
        }

        string texFolder = Path.Combine(folder, "Textures");
        if (!Directory.Exists(texFolder))
        {
            Directory.CreateDirectory(texFolder);
        }

        string matFolder = Path.Combine(folder, "Materials");
        if (!Directory.Exists(matFolder))
        {
            Directory.CreateDirectory(matFolder);
        }

        string modelFolder = Path.Combine(folder, "Model");
        if (!Directory.Exists(modelFolder))
        {
            Directory.CreateDirectory(modelFolder);
        }

        string prefabFolder = Path.Combine(folder, "Prefab");
        if (!Directory.Exists(prefabFolder))
        {
            Directory.CreateDirectory(prefabFolder);
        }

        string[] files = Directory.GetFiles(folder, "*.fbx", SearchOption.TopDirectoryOnly);
        foreach (var filePath in files)
        {
            Object[] representations = AssetDatabase.LoadAllAssetRepresentationsAtPath(filePath);

            ExtractAnimations(animFolder, representations);
            foreach (var rep in representations)
            {
                //约定有mesh文件的才导出
                if (rep is Mesh)
                {
                    ExtractMesh(modelFolder, filePath);
                    ExtractAvatar(modelFolder, filePath);
                    ExtractTexture(texFolder, filePath);
                    ExtractMaterial(matFolder, filePath);
                    ExtractPrefab(prefabFolder, filePath);
                }
            }
        }
        AssetDatabase.Refresh(ImportAssetOptions.Default);
    }
    
    private static void ExtractPrefab(string prefabFolder, string fbxPath)
    {
        string fbxName = Path.GetFileName(fbxPath);
        string newPath = Path.Combine(prefabFolder, Path.ChangeExtension(fbxName, ".prefab"));
        GameObject modelAsset = AssetDatabase.LoadAssetAtPath<GameObject>(fbxPath);
        GameObject go = PrefabUtility.InstantiatePrefab(modelAsset) as GameObject;
        Debug.Log($"Extract Prefab:{ PrefabUtility.SaveAsPrefabAsset(go, newPath)}");
        Object.DestroyImmediate(go);
    }

    private static void ExtractMaterial(string matFolder, string fbxPath)
    {
        Material mat = AssetDatabase.LoadAssetAtPath<Material>(fbxPath);
        if (mat != null)
        {
            string newPath = Path.Combine(matFolder, Path.ChangeExtension(mat.name, ".mat"));
            ExtractFromAsset(mat, newPath);
            Debug.Log($"Extract Material:{newPath}");

        }
    }

    private static void ExtractTexture(string texFolder, string filePath)
    {
        //extract Texture
        ModelImporter mi = AssetImporter.GetAtPath(filePath) as ModelImporter;
        if (mi.ExtractTextures(texFolder))
        {
            Debug.Log($"Extract texture:{texFolder}");
        }
    }

    private static void ExtractAnimations(string animFolder, Object[] representations)
    {
        foreach (var rep in representations)
        {
            if (rep is AnimationClip)
            {
                AnimationClip clip = rep as AnimationClip;
                string fbxPath = AssetDatabase.GetAssetPath(clip);
                string fbxName = Path.GetFileName(fbxPath);
                string newPath = Path.Combine(animFolder, Path.ChangeExtension(fbxName, ".anim"));
                AnimationClip newClip = new AnimationClip();
                EditorUtility.CopySerialized(clip, newClip);
                AssetDatabase.CreateAsset(newClip, newPath);
            }
            string astPath = AssetDatabase.GetAssetPath(rep);
        }
    }
    
    private static void ExtractMesh(string modelFolder, string fbxPath)
    {
        Mesh mesh = AssetDatabase.LoadAssetAtPath<Mesh>(fbxPath);
        string newPath = Path.Combine(modelFolder, Path.ChangeExtension(mesh.name, ".mesh"));        
        ExtractFromAsset(mesh, newPath);
    }

    private static void ExtractAvatar(string modelFolder, string fbxPath)
    {
        Avatar avt = AssetDatabase.LoadAssetAtPath<Avatar>(fbxPath);
        string newPath = Path.Combine(modelFolder, Path.ChangeExtension(avt.name, ".asset"));
        ExtractFromAsset(avt, newPath);
    }

    public static void ExtractFromAsset(Object subAsset, string destinationPath)
    {
        string assetPath = AssetDatabase.GetAssetPath(subAsset);

        var clone = Object.Instantiate(subAsset);
        AssetDatabase.CreateAsset(clone, destinationPath);

        var assetImporter = AssetImporter.GetAtPath(assetPath);
        assetImporter.AddRemap(new AssetImporter.SourceAssetIdentifier(subAsset), clone);

        AssetDatabase.WriteImportSettingsIfDirty(assetPath);
        AssetDatabase.ImportAsset(assetPath, ImportAssetOptions.ForceUpdate);
    }
}
