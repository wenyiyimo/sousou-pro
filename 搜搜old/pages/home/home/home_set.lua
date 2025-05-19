home_set_out.onClick=function()
  set_pop_out={
    LinearLayout;
    background="#ffffffff";
    layout_height="fill";
    orientation="vertical";
    layout_width="fill";
    id="setlayout";
    {
      ScrollView;
      VerticalScrollBarEnabled=false;
      layout_width="match_parent";
      {
        LinearLayout;
        layout_height="fill";
        orientation="vertical";
        layout_width="fill";

        {
          LinearLayout;
          layout_height="wrap_content";
          orientation="vertical";
          layout_margin="10dp";
          layout_width="match_parent";
          {
            TextView;
            text="设置";
            textColor="0xff227CEA";
            layout_margin="10dp";
            textSize="20dp";
          };
          {
            LinearLayout;
            id="setViewLine";
            layout_height="wrap_content";
            orientation="horizontal";
            layout_margin="15dp";
            layout_width="match_parent";

            {
              TextView;
              textSize="16dp";
              layout_weight="1";
              text="推荐行数";
            };
            {
              TextView;
              textSize="16dp";
              text="1";
              Typeface=Typeface.createFromFile(File(activity.getLuaDir().."/static/font/font.ttf"));
              textColor=0xff227CEA,
              id="reNumText";
            };
          };
          {
            LinearLayout;
            layout_height="wrap_content";
            orientation="horizontal";
            layout_margin="10dp";
            layout_width="match_parent";
            {
              TextView;
              textSize="16dp";
              layout_weight="1";
              text="重置快捷栏";
              id="requickout";
            };
          };
          {
            LinearLayout;
            layout_height="wrap_content";
            orientation="horizontal";
            layout_margin="10dp";
            layout_width="match_parent";
            {
              TextView;
              textSize="16dp";
              layout_weight="1";
              text="设置推荐数据";
              id="setreout";
            };
          };
          {
            RecyclerView,
            layout_width = "fill", -- 布局宽度
            layout_height = "wrap", -- 布局高度
            id = "home_set_recycler_view"
          }
        };
      };

    };
  };


  local setPop = PopupWindow(activity).setContentView(loadlayout(set_pop_out)).setWidth(activity.width) -- 设置宽度
  .setHeight(activity.height*0.8).setFocusable(true) -- 设置可获得焦点
  .setTouchable(true).setClippingEnabled(false) -- 设置启用剪辑
  .setBackgroundDrawable(nil) -- 设置可触摸
  .setOutsideTouchable(true)
  activity.getWindow().attributes.systemUiVisibility = View.SYSTEM_UI_FLAG_HIDE_NAVIGATION or View.SYSTEM_UI_FLAG_IMMERSIVE
  setPop.showAtLocation(homeBodyRoot, Gravity.BOTTOM, 0, 0)
  setPop.onDismiss = function()

  end

  reNumText.text=tostring(homeRowNum)
  setViewLine.onClick=function()
    if length(homeClassAdapters)>0 then


     else
      showToast("设置失败，首页数据为空！")
      return
    end


    if tointeger(reNumText.text)<5 then
      homeRowNum=homeRowNum+1


     else
      homeRowNum=1

    end
    reNumText.text=tostring(homeRowNum)
    settingUtil.setSetting("homeRowNum",homeRowNum)
    -- showToast("设置成功，重启APP生效！")

    for i=1,length(homeClassAdapters) do

      getIdByString("home_recycler_out_" .. tostring(i)).setLayoutManager(StaggeredGridLayoutManager(homeRowNum, StaggeredGridLayoutManager.HORIZONTAL))

    end
    showToast("设置成功！")


  end

  requickout.onClick=function()
    local defaultMenu={}
    function setDefaultMenu(name,icon,page)

      local game={}
      game.icon=icon
      game.name=name
      game.page=page
      table.insert(defaultMenu,game)

    end

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


    settingUtil.setSetting("homeMenu",defaultMenu)

    menuDatas=defaultMenu

    menuAdapter.notifyDataSetChanged()

  end
  home_set_recycler_view.setLayoutManager(StaggeredGridLayoutManager(2, StaggeredGridLayoutManager.VERTICAL))
  home_set_recycler_adapter=LuaCustRecyclerAdapter(AdapterCreator({
    getItemCount = function()
      return #homeActivesites
    end,
    getItemViewType = function(position)
      return 0
    end,
    onCreateViewHolder = function(parent, viewType)
      local views = {}
      local holder

      holder = LuaCustRecyclerHolder(loadlayout({

        LinearLayout, -- 线性布局
        orientation = "vertical", -- 水平方向
        layout_height = "wrap",
        layout_width = "fill",
        {
          CardView,
          layout_margin = MarginStyles().medium,
          layout_width = "fill",
          layout_height = "wrap",
          id="card",
          cardElevation = RadiusStyles().small,
          Radius = RadiusStyles().small,
          padding = MarginStyles().small,
          cardBackgroundColor = "#ffffffff", -- 卡片背景色
          {
            LinearLayout, -- 线性布局
            orientation = "vertical", -- 水平方向
            layout_margin = MarginStyles().small, -- 布局边距
            layout_width = "fill", -- 布局宽度
            layout_height = "fill", -- 布局高度
            {
              TextView;
              textSize="16dp";
              layout_weight="1";
              layout_margin = MarginStyles().small,
              id="name";
            };
            {
              TextView;
              textSize="13dp";
              id="site";
              layout_margin = MarginStyles().small, -- 布局边距
            };
          }
        }

      }, views))

      holder.view.setTag(views)
      return holder
    end,
    onBindViewHolder = function(holder, position)
      -- print(data[position+1][1])
      local view = holder.view.getTag()
      local data=homeActivesites[position+1]
      view.name.text=data[2]
      view.site.text=data[4]
      if data[1]==homeSiteUrl and data[2]==homeSiteName then
        view.card.cardBackgroundColor=0xff227CEA

        view.name.textColor=0xffffffff
        view.site.textColor=0xffffffff
       else
        view.card.cardBackgroundColor=0xffffffff
        view.name.textColor=0xff000000
        view.site.textColor=0x99000000
      end

      view.card.onClick=function()

        homeSiteUrl=data[1]
        homeSiteName=data[2]

        settingUtil.setSetting("homeSiteName", homeSiteName)
        settingUtil.setSetting("homeSiteUrl", homeSiteUrl)

        -- showToast("设置首页数据成功，重启APP生效！")
        home_set_recycler_adapter.notifyDataSetChanged()

        homeSiteUrl = homeActivesites[position+1][1]
        homeSiteName = homeActivesites[position+1][2]
        settingUtil.setSetting("homeSiteName", homeSiteName)
        settingUtil.setSetting("homeSiteUrl", homeSiteUrl)

        homeSite= homeActivesites[position+1][3]
        getBodySiteData()
        showToast("设置成功！")
      end

    end
  }))

  home_set_recycler_view.adapter=home_set_recycler_adapter
end