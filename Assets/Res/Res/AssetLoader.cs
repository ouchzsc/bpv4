using System.Collections;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;

namespace Res
{
    public class AssetLoader
    {
        private static readonly Dictionary<string, BundleLoader> BundleLoaderPool =
            new Dictionary<string, BundleLoader>();

        public object Asset { get; private set; }

        private readonly AssetInfo _assetInfo;

        private readonly HashSet<User> _loaderUsers;

        private int _bundleNumToLoad;

        private List<string> _allBundleNames;

        private bool _isStarted;

        public AssetLoader(AssetInfo assetInfo)
        {
            _assetInfo = assetInfo;
            _loaderUsers = new HashSet<User>();
            _allBundleNames = new List<string>(AbMgr.instance.manifest.GetAllDependencies(_assetInfo.bundleName));
            _allBundleNames.Add(_assetInfo.bundleName);
            _bundleNumToLoad = _allBundleNames.Count;
        }

        public void Start()
        {
            if (_isStarted)
                return;
            _isStarted = true;
            foreach (var bdName in _allBundleNames)
            {
                if (BundleLoaderPool.TryGetValue(bdName, out var bundleLoader))
                {
                    if (bundleLoader.assetBundle != null)
                        DeCnt();
                }
                else
                {
                    bundleLoader = new BundleLoader(bdName);
                    BundleLoaderPool.Add(bdName, bundleLoader);
                    bundleLoader.Start();
                }

                bundleLoader.AddAssetLoader(this);
            }
        }

        public void DeCnt()
        {
            _bundleNumToLoad--;
            if (_bundleNumToLoad == 0)
            {
                AbMgr.instance.StartCoroutine(util_LoadAsset(_assetInfo.bundleName, _assetInfo.assetName, OnAssetLoaded));
            }
        }

        private void OnAssetLoaded(object obj)
        {
            Asset = obj;
            foreach (var customer in _loaderUsers.ToList())
            {
                customer.OnAssetLoaded(Asset);
            }
        }

        public void AddLoaderUser(User user)
        {
            _loaderUsers.Add(user);
        }

        public void RemoveLoaderUser(User user)
        {
            _loaderUsers.Remove(user);
            if (_loaderUsers.Count == 0)
            {
                foreach (var bdName in _allBundleNames)
                {
                    BundleLoaderPool.TryGetValue(bdName, out var bundleLoader);
                    bundleLoader?.RemoveAssetLoader(this);
                }
            }
        }

        private IEnumerator util_LoadAsset(string bundleName, string assetName, LoadDoneDelegate loadDone)
        {
            BundleLoaderPool.TryGetValue(bundleName, out var bundleLoader);
            if (bundleLoader != null)
            {
                var assetReq = bundleLoader.assetBundle.LoadAssetAsync(assetName);
                yield return assetReq;
                loadDone(assetReq.asset);
            }
            else
            {
                Debug.LogError($"load asset {assetName} failed");
                
                loadDone(null);
            }
        }
    }
}