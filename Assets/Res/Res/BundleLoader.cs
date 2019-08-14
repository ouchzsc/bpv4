using System.Collections;
using System.Collections.Generic;
using System.IO;
using UnityEngine;

namespace Res
{
    public class BundleLoader
    {
        public AssetBundle assetBundle;
        private readonly string _bundleName;
        private readonly HashSet<AssetLoader> _assetLoaders;

        public BundleLoader(string bundleName)
        {
            _bundleName = bundleName;
            _assetLoaders = new HashSet<AssetLoader>();
        }

        public void Start()
        {
            AbMgr.instance.StartCoroutine(util_LoadBundle(_bundleName, LoadDone));
        }

        public void AddAssetLoader(AssetLoader assetLoader)
        {
            _assetLoaders.Add(assetLoader);
        }

        public void RemoveAssetLoader(AssetLoader assetLoader)
        {
            _assetLoaders.Remove(assetLoader);
            if (_assetLoaders.Count == 0)
            {
                if (assetBundle)
                    assetBundle.Unload(true);
            }
        }

        private void LoadDone(object obj)
        {
            assetBundle = obj as AssetBundle;
            foreach (var item in _assetLoaders)
            {
                item.DeCnt();
            }

            if (_assetLoaders.Count == 0)
                assetBundle.Unload(true);
        }
        
        
        public IEnumerator util_LoadBundle(string bundleName, LoadDoneDelegate loadDone)
        {
            var bundleReq = AssetBundle.LoadFromFileAsync(Path.Combine(Application.streamingAssetsPath, bundleName));
            yield return bundleReq;
            if (loadDone != null)
                loadDone(bundleReq.assetBundle);
        }
    }
}