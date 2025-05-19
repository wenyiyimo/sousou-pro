import "java.io.File"
import "cjson"

function FileUtil(name)

  local basePath = "sdcard/搜搜/"
  if not File(basePath).exists() then
    File(basePath).mkdirs()
  end
  local self = {
    name = basePath .. name
  }
  local function getDatas()
    if File(self.name).exists() then
      self.datas = cjson.decode(io.open(self.name):read("*a"))
     else
      io.open(self.name, "w"):write("[]"):close()
      self.datas = {}
    end
    return self.datas
  end

  local function setDatas(datas)
    if type(datas) == "string" then
      io.open(self.name, "w"):write(datas):close()
     elseif type(datas) == "table" then
      local temp = cjson.encode(datas)
      io.open(self.name, "w"):write(temp):close()
    end
  end
  local function saveDatas(datas)
    if type(datas) == "string" then
      io.open(self.name, "w"):write(datas):close()
     elseif type(datas) == "table" then
      local temp = cjson.encode(datas)
      io.open(self.name, "w"):write(temp):close()
    end
  end

  return {
    getDatas = getDatas,
    setDatas = setDatas,
    saveDatas = saveDatas
  }
end
