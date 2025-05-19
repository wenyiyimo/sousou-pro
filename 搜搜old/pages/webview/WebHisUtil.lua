import("cjson");
import "utils.FileUtil"


function WebHisUtil()

  local webFileUtil = FileUtil("webSearchHistory.json")


  local historys = webFileUtil.getDatas()


  local function getHistorys()
    historys=webFileUtil.getDatas()
    return historys;
  end;
  local function setHistory(value)
    if not historys and tostring(historys)=="nil"then
      historys=getHistorys()
    end


    local flag, num = judgeValueInTable(historys, value);
    if flag then
      table.remove(historys, num);
    end;
    table.insert(historys, 1, value);
    if length(historys) > 20 then
      table.remove(historys);
    end;
    historys=webFileUtil.setDatas(historys)
    return historys
  end;




  local function clearHistorys()
    historys= {};
    historys=webFileUtil.setDatas(historys)
    return {};
  end;
  local function removeHistory(key)
    if not historys and tostring(historys)=="nil"then
      historys=getHistorys()
    end

    
    table.remove(historys, key);
    historys=webFileUtil.setDatas(historys)
    return historys;
  end;
  return {

    getHistorys = getHistorys,
    setHistory = setHistory,
    removeHistory = removeHistory,
    clearHistorys = clearHistorys
  };
end;
