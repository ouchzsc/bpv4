using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[CreateAssetMenu(fileName = "Data", menuName = "ScriptableObjects/AssetInfoScriptableObject", order = 1)]
public class AssetInfoScriptableObject : ScriptableObject
{
    public List<AssetInfo> assetInfos;
}

[System.Serializable]
public class AssetInfo
{
    public string assetPath;
    public string bundleName;
    public string assetName;
    public string type;
}
