using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using UnityEngine;
using UnityEngine.Serialization;

namespace Res
{
    public delegate void LoadDoneDelegate(object asset);
    
    public class AbMgr : MonoBehaviour
    {
        public AssetBundleManifest manifest;
        public List<AssetInfo> assetInfos;
        public Dictionary<string, AssetInfo> assetInfoMap;
        public static AbMgr instance;

        private void Awake()
        {
            instance = this;
            //LoadAssetInfo();
            LoadManifest(Path.Combine(Application.streamingAssetsPath, "StandaloneWindows"));
        }

        private void LoadAssetInfo()    
        {
            AssetInfoScriptableObject aiSo = Resources.Load("assetInfos") as AssetInfoScriptableObject;
            assetInfos = aiSo.assetInfos;
            assetInfoMap = new Dictionary<string, AssetInfo>();
            foreach (var assetInfo in assetInfos)
            {
                assetInfoMap.Add(assetInfo.assetName, assetInfo);
            }
        }

        private void LoadManifest(string manifestPath)
        {
            AssetBundle assetBundle = AssetBundle.LoadFromFile(manifestPath);
            manifest = assetBundle.LoadAsset<AssetBundleManifest>("AssetBundleManifest");
        }

        public User CreateBy(AssetInfo assetInfo)
        {
            return new User(assetInfo);
        }

        public User Create(string assetPath, string bundleName, string assetName, string type)
        {
            AssetInfo assetInfo = new AssetInfo(assetPath, bundleName, assetName, type);
            return new User(assetInfo);
        }
    }
}