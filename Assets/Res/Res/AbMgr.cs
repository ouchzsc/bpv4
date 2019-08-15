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
        [HideInInspector]
        public AssetBundleManifest manifest;
        public static AbMgr instance;
        public bool loadInEditor = false;

        private void Awake()
        {
            instance = this;
            LoadManifest(Path.Combine(Application.streamingAssetsPath, "StandaloneWindows"));
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