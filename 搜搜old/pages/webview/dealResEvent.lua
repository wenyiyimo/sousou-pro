

resBody={

    CardView,
    -- orientation = "horizontal",
    layout_height = "fill",
    layout_width = "fill",
    radius = "15dp",

    {
      LinearLayout, -- 线性布局
      orientation = 'vertical', -- 方向
      layout_width = 'fill', -- 宽度
      layout_height = 'fill', -- 高度
     
      background = '#ffFFFFFF', -- 背景颜色或图片路径
      orientation="vertical";

      {
        TextView,
        layout_width = "fill",
        layout_height = "wrap",
        layout_margin = "10dp",

        layout_gravity = 'center',
        gravity = 'center',
        text = "已发现的视频资源",
        textColor = ColorStyles().black,
        Typeface = Typeface.createFromFile(File(activity.getLuaDir() .. "/static/font/zt1.ttf")),
        textSize = '16dp',
        singleLine = true,
        ellipsize = "marquee",
        selected = true
      },
      {
        RecyclerView,
        layout_height = "wrap",
        id = "res_list",
        layout_width = "fill"
      },

  }}
resItem= {

    LinearLayout,
    orientation = "vertical",
    layout_width = "fill",
    layout_height = "wrap",
    {
      CardView,
      -- orientation = "horizontal",
      layout_height = "wrap",
      layout_width = "fill",
      radius = "15dp",
      layout_margin = "16dp",
      {
        LinearLayout,
        orientation = "vertical",
        layout_width = "fill",
        id ="singleItem",
        {
          TextView,
          id = "name",
          layout_margin = "16dp",
          layout_width = "fill",
          textColor = 0xff000000,
          Typeface = Typeface.createFromFile(File(activity.getLuaDir() .. "/static/font/zt1.ttf")),
          textSize = '16dp',
          singleLine = true,
          ellipsize = "marquee",
          selected = true
        },
        {
          layout_height = "1.2dp",
          layout_width = "fill",
          TextView,
          backgroundColor = 0x22000000
        },
        {
          TextView,
          id = "url",
          layout_margin = "16dp",
          textSize = '14dp',
          layout_width = "fill",
          --textColor = 0xff000000
        }
    }}
  }





res.onClick=function()
  isPop=true
  resPop = PopupWindow(activity)
  resPop.setContentView(loadlayout(resBody))
  resPop.setWidth(activity.width) -- 设置宽度
  resPop.setHeight(activity.height * 0.8)
  resPop.setFocusable(false) -- 设置可获得焦点
  resPop.setTouchable(true).setClippingEnabled(false) -- 设置启用剪辑
  .setBackgroundDrawable(nil)
  -- 设置可触摸
  -- 设置点击外部区域是否可以消失
  resPop.setOutsideTouchable(true)
  activity.getWindow().attributes.systemUiVisibility = View.SYSTEM_UI_FLAG_HIDE_NAVIGATION or
  View.SYSTEM_UI_FLAG_IMMERSIVE
  res_list.setLayoutManager(StaggeredGridLayoutManager(1, StaggeredGridLayoutManager.VERTICAL))


  local res_adp =
  LuaRecyclerAdapter(resDatas,
  resItem,
  {
    onBindViewHolder = function(holder, position)
      local view = holder.view.getTag()
      local data = resDatas[position+1]

      view.name.setText(tostring(data.name))
      view.url.setText(tostring(data.url))
      view.singleItem.onClick=function()

        local site={}
        site.name="temp"
        site.type="temp"
        activity.newActivity("pages/play/play", {{site, {["标题"]=data.name,["地址"]=data.url}}})
      end
    end,

  })




  res_list.setAdapter(res_adp)

  resPop.showAtLocation(menu, Gravity.BOTTOM, 0, 0)
  resPop.onDismiss=function()
    isPop=false
  end
end

