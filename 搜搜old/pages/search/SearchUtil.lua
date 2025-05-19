import("cjson");
function SearchUtil(setting,settingUtil)
  local self = {
    settingUtil=settingUtil,
    setting = setting,
    searchHistory = setting.searchHistory
  };
  local function getSearchHistory()
    self.searchHistory = self.setting.searchHistory;
    return self.searchHistory;
  end;
  local function setSearchHistory(value)
    local flag, num = judgeValueInTable(self.searchHistory, value);
    if flag then
      table.remove(self.searchHistory, num);
    end;
    table.insert(self.searchHistory, 1, value);
    if #self.searchHistory > 20 then
      table.remove(self.searchHistory);
    end;
    self.setting=self.settingUtil.setSetting("searchHistory",self.searchHistory)
    return self.setting.searchHistory
  end;
  local function clearSearchHistory()
    self.searchHistory = {};
    self.setting=self.settingUtil.setSetting("searchHistory", []);
    return self.searchHistory;
  end;
  local function removeSearchHistory(key)
    table.remove(self.searchHistory, key);
    self.setting=self.settingUtil.setSetting("searchHistory", self.searchHistory);
    return self.searchHistory;
  end;
  return {
    getSearchHistory = getSearchHistory,
    searchHistory = self.searchHistory,
    setSearchHistory = setSearchHistory,
    removeSearchHistory = removeSearchHistory,
    clearSearchHistory = clearSearchHistory
  };
end;
