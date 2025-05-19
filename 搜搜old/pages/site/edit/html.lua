if sites[siteIndex]["SITE"][itemIndex] then
 else

  sites[siteIndex]["SITE"][itemIndex] = cjson.decode([[{
  "isClass": true,
  "type":"html",
  "class_header": "{\"user-agent\":\"Mozilla/5.0 (Linux; Android 12; M2007J17C Build/SKQ1.211006.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/119.0.6045.193 Mobile Safari/537.36\"}",
  "play_header": "{\"user-agent\":\"Mozilla/5.0 (Linux; Android 12; M2007J17C Build/SKQ1.211006.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/119.0.6045.193 Mobile Safari/537.36\"}",
  "search_range": "ulPicTxt clearfix(.-)</ul>",
  "search_header": "{\"user-agent\":\"Mozilla/5.0 (Linux; Android 12; M2007J17C Build/SKQ1.211006.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/119.0.6045.193 Mobile Safari/537.36\"}",
  "isSearch": true,
  "class_item": "a href=\"([^<>]-)\" title=\"(.-)\".-img src=\"(.-)\".-<span class=\"sBottom\"><span>(.-)<em>",
  "class_order": "地址&&&标题&&&图片&&&状态",
  "search_picture_url": "",
  "play_order": "地址&&&标题",
  "play_list": "ul(.-)</ul>",
  "class_url": "https://v.nmvod.cn/vod-list-id-ORDER-pg-PAGE-order--by-time.html",
  "class_href": "URL",
  "class_name": "追剧&&&电影&&&动漫&&&综艺",
  "play_range": "class=\"numList\">(.-)</div",
  "search_picture": "",
  "play_href": "URL",
  "search_item": "a href=\"([^<>]-)\".-src=\"([^<>]-)\".-sTit\">([^<>]-)</span>.-评分：</em>([^<>]-)</span>",
  "search_post": "{\"wd\":\"searchKey\"}",
  "name": "",
  "search_url": "https://v.nmvod.cn/index.php?m=vod-search",
  "play_tag_name": "href=\"javascript:;\">([^<>]-)</a></li>",
  "class_first": "1",
  "class_range": "<ul.-resize_list(.-)</body>",
  "class_order_key": "2&&&1&&&4&&&3",
  "class_second": "2",
  "search_href": "URL",
  "play_state": "color=\"red\">([^<>]-)</font></div><div class=",
  "class_picture": "",
  "play_next_href": "",
  "play_next_href_url": "",
  "play_item": "href=\"(.-)\" target=\"_self\" title=\".-\">(.-)</a>",
  "except": ".js&&&url=",
  "play_tag_range": "",
  "search_order": "地址&&&图片&&&标题&&&状态"
 }]])
end

setBodyItem("name", "站源名称", sites[siteIndex]["SITE"][itemIndex].name)
setBodyItem("class_header", "分类header(可为空)", sites[siteIndex]["SITE"][itemIndex].class_header)
setBodyItem("class_name", "分类标签(&&&)", sites[siteIndex]["SITE"][itemIndex].class_name)
setBodyItem("class_url", "分类地址(&&&、PAGE、ORDER)", sites[siteIndex]["SITE"][itemIndex].class_url)
setBodyItem("class_order_key", "分类关键词(&&&)", sites[siteIndex]["SITE"][itemIndex].class_order_key)
setBodyItem("class_first", "首页数值(一般为1，可为空)", sites[siteIndex]["SITE"][itemIndex].class_first)
setBodyItem("class_second", "第二页数值(一般为2)", sites[siteIndex]["SITE"][itemIndex].class_second)
setBodyItem("class_range", "数据范围", sites[siteIndex]["SITE"][itemIndex].class_range)
setBodyItem("class_item", "获取每条", sites[siteIndex]["SITE"][itemIndex].class_item)
setBodyItem("class_order", "获取顺序", sites[siteIndex]["SITE"][itemIndex].class_order)
setBodyItem("class_href", "补充剧集地址(URL)", sites[siteIndex]["SITE"][itemIndex].class_href)
setBodyItem("class_picture", "补充图片地址(URL)", sites[siteIndex]["SITE"][itemIndex].class_picture)

setBodyItem("search_header", "搜索header(可为空)", sites[siteIndex]["SITE"][itemIndex].search_header)
setBodyItem("search_url", "搜索地址(searchKey)", sites[siteIndex]["SITE"][itemIndex].search_url)
setBodyItem("search_post", "post请求数据{\"wd\":\"searchKey\"}", sites[siteIndex]["SITE"][itemIndex].search_post)
setBodyItem("search_range", "数据范围", sites[siteIndex]["SITE"][itemIndex].search_range)
setBodyItem("search_item", "获取每条", sites[siteIndex]["SITE"][itemIndex].search_item)
setBodyItem("search_order", "获取顺序", sites[siteIndex]["SITE"][itemIndex].search_order)
setBodyItem("search_href", "补充剧集地址(URL)", sites[siteIndex]["SITE"][itemIndex].search_href)
setBodyItem("search_picture", "补充图片地址(URL)", sites[siteIndex]["SITE"][itemIndex].search_picture)

setBodyItem("play_header", "剧集header(可为空)", sites[siteIndex]["SITE"][itemIndex].play_header)
setBodyItem("play_state", "剧集状态", sites[siteIndex]["SITE"][itemIndex].play_state)
setBodyItem("play_tag_range", "线路标签范围", sites[siteIndex]["SITE"][itemIndex].play_tag_range)
setBodyItem("play_tag_name", "线路标签名称", sites[siteIndex]["SITE"][itemIndex].play_tag_name)

setBodyItem("play_range", "剧集数据范围", sites[siteIndex]["SITE"][itemIndex].play_range)
setBodyItem("play_list", "剧集列表", sites[siteIndex]["SITE"][itemIndex].play_list)

setBodyItem("play_item", "剧集每条", sites[siteIndex]["SITE"][itemIndex].play_item)
setBodyItem("play_order", "剧集获取顺序", sites[siteIndex]["SITE"][itemIndex].play_order)
setBodyItem("play_href", "剧集补充地址(URL)", sites[siteIndex]["SITE"][itemIndex].play_href)
setBodyItem("play_next_href", "剧集播放地址", sites[siteIndex]["SITE"][itemIndex].play_next_href)
setBodyItem("play_next_href_url", "补充播放地址(URL)", sites[siteIndex]["SITE"][itemIndex].play_next_href_url)

setBodyItem("except", "嗅探排除", sites[siteIndex]["SITE"][itemIndex].except)

