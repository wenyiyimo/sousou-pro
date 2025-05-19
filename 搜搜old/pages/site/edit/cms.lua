if sites[siteIndex]["SITE"][itemIndex] then
 else
 sites[siteIndex]["SITE"][itemIndex] = cjson.decode([[{
  "isClass": true,
  "type":"cms",
  "name": "",
  "class_header": "{\"user-agent\":\"Mozilla/5.0 (Linux; Android 12; M2007J17C Build/SKQ1.211006.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/119.0.6045.193 Mobile Safari/537.36\"}",
  "play_header": "{\"user-agent\":\"Mozilla/5.0 (Linux; Android 12; M2007J17C Build/SKQ1.211006.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/119.0.6045.193 Mobile Safari/537.36\"}",
  "search_header": "{\"user-agent\":\"Mozilla/5.0 (Linux; Android 12; M2007J17C Build/SKQ1.211006.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/119.0.6045.193 Mobile Safari/537.36\"}",
  "isSearch": true,
  "cms_url":"",
  "except": ".js&&&url="
 }]])
end

setBodyItem("name", "站源名称", sites[siteIndex]["SITE"][itemIndex].name)
setBodyItem("cms_url", "站源地址", sites[siteIndex]["SITE"][itemIndex].cms_url)

setBodyItem("class_header", "分类header(可为空)", sites[siteIndex]["SITE"][itemIndex].class_header)
setBodyItem("search_header", "搜索header(可为空)", sites[siteIndex]["SITE"][itemIndex].search_header)
setBodyItem("play_header", "剧集header(可为空)", sites[siteIndex]["SITE"][itemIndex].play_header)


setBodyItem("except", "嗅探排除", sites[siteIndex]["SITE"][itemIndex].except)