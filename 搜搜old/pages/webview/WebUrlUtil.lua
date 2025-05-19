import("cjson");
import "utils.FileUtil"



function WebUrlUtil()
  local webUrlFileUtil = FileUtil("webUrlHistory.json")


  local uhistorys = webUrlFileUtil.getDatas()


  local function getUrlNum(data)
    for k, v in pairs(uhistorys) do

      if v.url==data.url then
        return k
      end
    end
    return -1
  end


  local function getHistorys()
    uhistorys=webUrlFileUtil.getDatas()
    return uhistorys;
  end;

  local function setHistory(value)
    if not uhistorys or tostring(uhistorys)=="nil"then
      uhistorys=getHistorys()
    end
    local num = getUrlNum(value);
    if num >=0 then
      table.remove(uhistorys, num);
    end;

    table.insert(uhistorys, 1, value);
    if length(uhistorys) > 100 then
      table.remove(uhistorys);
    end

    uhistorys=webUrlFileUtil.setDatas(uhistorys)
    return uhistorys
  end;

  local function clearHistorys()
    uhistorys= {};
    uhistorys=webUrlFileUtil.setDatas(uhistorys)
    return {};
  end;
  local function removeHistory(key)
    
    if not uhistorys or tostring(uhistorys)=="nil"then
      uhistorys=getHistorys()
    end
    
    table.remove(uhistorys, key);
    uhistorys=webUrlFileUtil.setDatas(uhistorys)
    return uhistorys;
  end;
  return {

    getHistorys = getHistorys,
    setHistory = setHistory,
    removeHistory = removeHistory,
    clearHistorys = clearHistorys
  };
end