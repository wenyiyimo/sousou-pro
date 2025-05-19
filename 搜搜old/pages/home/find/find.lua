import "pages.home.find.layout"
--import "pages.home.find.weather"

if isMobile then
  mv_more.setNumColumns(2)
  more_more.setNumColumns(2)
 else
  mv_more.setNumColumns(4)
  more_more.setNumColumns(4)
end
local mv_more_datas = {{
    title = "奇艺榜单",
    img = "static/img/more/phb.png"
    }, {
    title = "豆瓣影评",
    img = "static/img/more/douban.png"
    }, {
    title = "待开发",
    img = "static/img/more/icon.png"
}}
local more_more_datas = {{
    title = "本地视频",
    img = "static/img/more/video.png"
  },
  {
    title = "游戏娱乐",
    img = "static/img/more/game.png"
  },
  {
    title = "待开发",
    img = "static/img/more/icon.png"
}}
local mv_more_adapter = LuaAdapter(activity, mv_more_datas, more_item)
local more_more_adapter = LuaAdapter(activity, more_more_datas, more_item)
mv_more.adapter = mv_more_adapter
more_more.adapter = more_more_adapter

mv_more.onItemClick = function(l, v, p, s)
  if v.Tag.title.Text == "奇艺榜单" then
    activity.newActivity("pages/qiyi/qiyi")
   elseif v.Tag.title.Text == "豆瓣影评" then
    activity.newActivity("pages/douban/douban")
   else
    showToast("待开发，敬请期待！")
  end
end
more_more.onItemClick = function(l, v, p, s)
  if v.Tag.title.Text == "本地视频" then
    -- showToast("待开发，敬请期待！")
    activity.newActivity("pages/video/video")
   elseif v.Tag.title.Text == "游戏娱乐" then
    -- showToast("待开发，敬请期待！")
    activity.newActivity("pages/game/game")
   else
    showToast("待开发，敬请期待！")
  end
end
