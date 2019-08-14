using System.Collections.Generic;
using UnityEditor;
using UnityEngine;

namespace AssetBundleBrowser
{

    public class AssetInfoGenerator : UnityEditor.Editor
    {
        [MenuItem("Assets/GenResSo")]
        public static void GenerateScirptObject()
        {
            AssetInfoScriptableObject aiSo = ScriptableObject.CreateInstance<AssetInfoScriptableObject>();
            aiSo.assetInfos = new List<AssetInfo>();
            string[] allBundles = AssetDatabase.GetAllAssetBundleNames();
            foreach (var bdName in allBundles)
            {
                string[] assetNames = AssetDatabase.GetAssetPathsFromAssetBundle(bdName);
                foreach (var assetName in assetNames)
                {
                    AssetInfo assetInfo = new AssetInfo();
                    assetInfo.bundleName = bdName;
                    assetInfo.assetPath = assetName;
                    assetInfo.type = System.IO.Path.GetExtension(assetName);
                    assetInfo.assetName = System.IO.Path.GetFileNameWithoutExtension(assetName);
                    aiSo.assetInfos.Add(assetInfo);
                }
            }
            AssetDatabase.CreateAsset(aiSo, "Assets/Resources/assetInfos.asset");
            AssetDatabase.SaveAssets();
            
            Debug.Log("Generate ScirptObject Done");
        }
    }
}