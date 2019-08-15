using System.Collections.Generic;
using UnityEngine;
#if UNITY_EDITOR
using UnityEditor;
#endif
namespace Res
{
    public class User
    {
        private readonly AssetInfo _assetInfo;
        private AssetLoader _assetLoader;
        private LoadDoneDelegate _loadDone;

        private static readonly Dictionary<AssetInfo, AssetLoader> AssetLoaderPool =
            new Dictionary<AssetInfo, AssetLoader>();

        public User(AssetInfo assetInfo)
        {
            _assetInfo = assetInfo;
        }

        public void Load(LoadDoneDelegate loadDone)
        {
#if UNITY_EDITOR
            if (AbMgr.instance.loadInEditor)
            {
                object obj = AssetDatabase.LoadAssetAtPath<Object>(_assetInfo.assetPath);
                loadDone(obj);
                return;
            }
#endif
            if (AssetLoaderPool.TryGetValue(_assetInfo, out var assetLoader))
            {
                if (assetLoader.Asset != null)
                {
                    loadDone(assetLoader.Asset);
                }
            }
            else
            {
                assetLoader = new AssetLoader(_assetInfo);
                AssetLoaderPool.Add(_assetInfo, assetLoader);
                assetLoader.Start();
            }

            _assetLoader = assetLoader;
            _loadDone = loadDone;
            assetLoader.AddLoaderUser(this);
        }

        public void Release()
        {
            _assetLoader.RemoveLoaderUser(this);
            _assetLoader = null;
            _loadDone = null;
        }

        public void OnAssetLoaded(object asset)
        {
            if (_loadDone != null)
                _loadDone(asset);
        }

#if Unity_Editor
        public void LoadInEditor(LoadDoneDelegate loadDone)
        {            
            AssetDataBase.
        }
#endif
    }
}