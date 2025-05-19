import "cjson"
import "utils.util"
import "utils.FileUtil"

function SettingUtil()

  local settingFileUtil = FileUtil("setting.json")

  local self = {
    setting = settingFileUtil.getDatas()
  }
  local function getSetting()
    self.setting = settingFileUtil.getDatas()
    return self.setting;
  end


  local function setSetting(key, value)
    self.setting[key] = value
    settingFileUtil.setDatas(self.setting)
    return self.setting;
  end
  local function getSettingKey(key,value)

    if tostring(self.setting[key]) == "nil" then
      if tostring(value) == "nil" then
        self.setting[key]=false
       else
        self.setting[key]=value
      end
      settingFileUtil.setDatas(self.setting)
    end
    return self.setting[key]
  end


  local function init()
    self.setting.agreePolicy = false
    self.setting.autoFullScreen = true
    self.setting.showPlayRate = true
    self.setting.searchMode = false
    self.setting.showPlayProgress = true
    self.setting.loadImg = false
    self.setting.isijk=true
    self.setting.searchHistory = {}
    settingFileUtil.setDatas(self.setting)
    return self.setting

  end
  return {
    init = init,
    getSetting = getSetting,
    setSetting = setSetting,
    getSettingKey=getSettingKey
  }
end
