using System.Collections;
using System.Collections.Generic;
using Res;
using UnityEngine;
using UnityEngine.Serialization;
using UnityEngine.UI;

public class ConsoleBoard : MonoBehaviour
{
    public AbMgr abMgr;
    public Dropdown dropdown;
    public AssetInfo assetInfo;
    private List<Dropdown.OptionData> _optionDatas;

    // Start is called before the first frame update
    void Start()
    {
        abMgr = AbMgr.instance;
        dropdown.ClearOptions();
        if (abMgr.assetInfos != null)
        {
            foreach (var ai in abMgr.assetInfos)
            {
                dropdown.options.Add(new Dropdown.OptionData(ai.assetName + ai.type));
            }
        }

        dropdown.onValueChanged.AddListener(OnOptionChange);
    }

    private void OnOptionChange(int arg0)
    {
        assetInfo = abMgr.assetInfos[arg0];
    }


    public void StartLoad()
    {
        var loader = abMgr.CreateBy(assetInfo);
        loader.Load((asset) =>
        {
            GameObject prefab = asset as GameObject;
            var go = Instantiate(prefab);
            go.name = assetInfo.assetName;
        });
//        loader.Release();
    }
}