using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[CreateAssetMenu(fileName = "Data", menuName = "ScriptableObjects/AssetInfoScriptableObject", order = 1)]
public class AssetInfoScriptableObject : ScriptableObject
{
    public List<AssetInfo> assetInfos;
}

[System.Serializable]
public struct AssetInfo
{
    public string assetPath;
    public string bundleName;
    public string assetName;
    public string type;

    public AssetInfo(string assetPath, string bundleName, string assetName, string type)
    {
        this.assetPath = assetPath;
        this.bundleName = bundleName;
        this.assetName = assetName;
        this.type = type;
    }
}
