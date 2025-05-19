home_douban = {}
home_douban.class_first = '1'
home_douban.class_second = '2'
home_douban.class_order_key = "tv&tag=国产剧&&&movie&tag=热门&&&movie&tag=动漫&&&tv&tag=综艺"
home_douban.class_url = "https://movie.douban.com/j/search_subjects?type=ORDER&page_limit=10&page_start=PAGE0"
home_douban.class_name = "电视剧&&&电影&&&动漫&&&综艺"
home_douban.class_order = "状态&&&评分&&&标题&&&地址&&&图片"
home_douban.class_range = ""
home_douban.class_item = [["episodes_info":"(.-)",.-"rate":"(.-)",.-"title":"(.-)",.-"url":"(.-)",.-"cover":"(.-)",]]
home_douban.class_header =
[[{"User-Agent":"MicroMessenger/","Referer":"https://servicewechat.com/wx2f9b06c1de1ccfca/91/page-frame.html"}]]

home_qiyi = {}
home_qiyi.class_first = '1'
home_qiyi.class_second = '2'
home_qiyi.class_order_key = "-1&&&2&&&1&&&4&&&6"
home_qiyi.class_url =
"https://pub.m.iqiyi.com/h5/main/hotList/interRep/?channelId=ORDER&dim=hour&type=realTime&pageNum=PAGE&len=10"
home_qiyi.class_name = "推荐&&&电视剧&&&电影&&&动漫&&&综艺"
home_qiyi.class_range = ""
home_qiyi.class_item =
[["mainTitle":"(.-)",.-"subtitle":"(.-)",.-"imageUrl":"(.-)",.-"lowerRightCorner":"(.-)",.-"hot_idx":"(.-)",]]
home_qiyi.class_order = "标题&&&介绍&&&图片&&&状态&&&热度"
home_qiyi.class_header = ""

sougou = {}
sougou.class_first = '0'
sougou.class_second = '1'
sougou.class_order_key = "teleplay&&&film&&&cartoon&&&tvshow&&&documentary"
sougou.class_url = "https://wapv.sogou.com/napi/video/classlist?listTab=ORDER&start=PAGE0&len=10"
sougou.class_name = "电视剧&&&电影&&&动漫&&&综艺&&&纪录片"
sougou.class_range = ""
sougou.class_item =
[[,"name":"(.-)",.-"year":"(.-)",.-"v_picurl":"(.-)",.-"score":"(.-)",.-"episode":"(.-)",.-"url":"(.-)",]]
sougou.class_order = "标题&&&年份&&&图片&&&评分&&&状态&&&地址"
sougou.class_header = [[{"user-agent":"Mozilla/5.0 (Linux; Android 12; M2007J17C Build/SKQ1.211006.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/119.0.6045.193 Mobile Safari/537.36"}]]
sougou.class_href = "https://wapv.sogou.comURL"