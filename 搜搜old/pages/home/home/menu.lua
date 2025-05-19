
local defaultMenu={}
function setDefaultMenu(name,icon,page)

  local game={}
  game.icon=icon
  game.name=name
  game.page=page
  table.insert(defaultMenu,game)

end



local menuItem = {
  CardView;
  layout_width="wrap";
  cardBackgroundColor="#00ffffff";
  layout_height="wrap";
  cardElevation="0dp";
  radius="0dp";
  id='itemout',--控件ID
  {
    LinearLayout;
    orientation="vertical";
    background="#ffffff";
    layout_width="wrap";
    layout_height="fill";
    layout_marginLeft="5dp",
    layout_marginRight="5dp",
    {
      CircleImageView;
      layout_width="30dp";
      id="iconout",
      --src="static/img/home/game.png";
      layout_height="30dp";
      layout_gravity="center",
    };
    {
      TextView;
      layout_width="wrap";
      -- text="游戏";
      singleLine = true,
      ellipsize = "marquee",
      selected = true,
      layout_marginTop="5dp";
      layout_height="wrap";
      gravity="center";
      textSize="13dp";
      Visibility=8,
      id="nameout",
      textColor="#FF000000";
      -- Typeface=Typeface.createFromFile(File(activity.getLuaDir().."/static/font.ttf"));
    };
  };
};
setDefaultMenu("浏览器","static/img/home/web1.png","pages/webview/webview")
setDefaultMenu("日程","static/img/home/sy.png","pages/calendar/calendar")
setDefaultMenu("分类","static/img/home/class.png","pages/sougou/sougou")
setDefaultMenu("游戏","static/img/home/game.png","pages/game/game")
setDefaultMenu("排行","static/img/home/top.png","pages/qiyi/qiyi")
setDefaultMenu("热评","static/img/home/say.png","pages/douban/douban")
setDefaultMenu("历史","static/img/home/history.png","pages/history/history")
setDefaultMenu("收藏","static/img/home/follow.png","pages/heart/heart")
setDefaultMenu("下载","static/img/home/down.png","pages/download/download")
setDefaultMenu("站点","static/img/home/Ds.png","pages/station/station")



menuDatas=settingUtil.getSettingKey("homeMenu",defaultMenu)


menuout.setLayoutManager(StaggeredGridLayoutManager(1, StaggeredGridLayoutManager.HORIZONTAL))

menuAdapter=LuaCustRecyclerAdapter(AdapterCreator({
  getItemCount = function()
    return #menuDatas
  end,
  getItemViewType = function(position)
    return 0
  end,
  onCreateViewHolder = function(parent, viewType)
    local views = {}
    local holder

    holder = LuaCustRecyclerHolder(loadlayout(menuItem, views))

    holder.view.setTag(views)
    return holder
  end,
  onBindViewHolder = function(holder, position)
    -- print(data[position+1][1])
    local view = holder.view.getTag()
    view.nameout.text = menuDatas[position + 1].name
    -- glideImg(view.iconout,menuDatas[position + 1].icon)

    view.iconout.setImageBitmap(loadbitmap(menuDatas[position + 1].icon))

    view.itemout.onClick=function()
      activity.newActivity(menuDatas[position + 1].page)
    end

    view.itemout.onLongClick=function()
      local dialog = AlertDialog.Builder(this).setTitle("请选择操作").setPositiveButton(
      "置顶", {
        onClick = function(v)
          table.insert(menuDatas,1,table.remove(menuDatas,position+1))
          menuAdapter.notifyDataSetChanged()
          settingUtil.setSetting("homeMenu",menuDatas)

        end
      })
      .setNeutralButton("取消",nil)
      .setNegativeButton("置底", {

        onClick = function(v)
          table.insert(menuDatas,table.remove(menuDatas,position+1))
          menuAdapter.notifyDataSetChanged()
          settingUtil.setSetting("homeMenu",menuDatas)

        end

      }).show()
      dialog.create()
      -- 更改Button颜色
      import "android.graphics.Color"
      dialog.getButton(dialog.BUTTON_POSITIVE).setTextColor(0xff227CEA)
      dialog.getButton(dialog.BUTTON_NEGATIVE).setTextColor(0xff227CEA)
      dialog.getButton(dialog.BUTTON_NEUTRAL).setTextColor(0xff227CEA)
    end

  end
}))
menuout.adapter=menuAdapter