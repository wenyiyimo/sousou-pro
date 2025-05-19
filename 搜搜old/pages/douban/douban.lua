require("import");
import("common.BaseActivity");
import "pages.douban.layout"

activity.setContentView(layout);


local vpger_find = ArrayList()
vpger_find.add(find1)
vpger_find.add(find2)

findPage.setAdapter(BasePagerAdapter(vpger_find))

-- 加载进度条颜色开始
progressbar1.IndeterminateDrawable.setColorFilter(PorterDuffColorFilter(ColorStyles().blue, PorterDuff.Mode.SRC_ATOP))

progressbar2.IndeterminateDrawable.setColorFilter(PorterDuffColorFilter(ColorStyles().blue, PorterDuff.Mode.SRC_ATOP))
-- 加载进度条颜色结束

-- 页面切换开始
function changetab(num)
 b1.textColor = ColorStyles().black
 b2.textColor = ColorStyles().black

 b1.textSize = TextSizes().medium
 b2.textSize = TextSizes().medium

 local button = loadstring("return b" .. tostring(num))()
 button.textColor = ColorStyles().blue
 button.textSize = TextSizes().big
end

findPage.addOnPageChangeListener {
 onPageScrolled = function(a, b, c)
  changetab(a + 1)
  scrollbar.setX(activity.getWidth() / 2 * (b + a) + activity.getWidth() * 0.15)
 end
}
b1.onClick = function()
 findPage.setCurrentItem(0)
end

b2.onClick = function()
 findPage.setCurrentItem(1)
end
-- 页面切换结束

-- 获取评论开始
itemout = {
 LinearLayout,
 layout_height = "wrap",
 orientation = "vertical",
 layout_width = "fill",
 {
  TextView,
  layout_width = 'fill',
  layout_height = '1dp',
  backgroundColor = ColorStyles().light,
  layout_marginBottom = MarginStyles().big -- 布局底距="0dp";
 },
 {
  LinearLayout,
  layout_height = "fill",
  orientation = "vertical",
  layout_width = "fill",
  id = "singleItem",
  {
   LinearLayout,
   orientation = "horizontal",
   layout_width = "fill",
   layout_height = ButtonStyles().height_medium,

   layout_marginLeft = MarginStyles().big,
   layout_marginRight = MarginStyles().big,
   {
    CardView,
    layout_width = ButtonStyles().width_medium_little,
    layout_height = ButtonStyles().height_medium_little,
    layout_gravity = "center",
    cardElevation = "0dp",
    radius = RadiusStyles().big,
    {
     ImageView, -- 圆形图片控件
     layout_width = "fill", -- 布局宽度
     layout_height = "fill", -- 布局高度
     -- src="icon.png",--视图路径
     id = 'userpic' -- 控件ID
    }
   },
   {
    LinearLayout,
    layout_height = "wrap",
    orientation = "vertical",
    layout_width = "fill",
    layout_gravity = "center",
    layout_marginLeft = MarginStyles().big, -- 布局左距
    {
     TextView, -- 文本框控件
     id = 'usernameout', -- 控件ID
     textSize = TextStyles().medium,

     Typeface = Typeface.createFromFile(File(activity.getLuaDir() .. "/static/font/font.ttf"))
    },
    {
     TextView, -- 文本框控件
     id = 'titledateout', -- 控件ID
     textSize = TextStyles().small
    }

   }

  },
  {
   TextView, -- 文本框控件
   layout_margin = MarginStyles().big,
   layout_width = 'fill',
   layout_height = 'wrap',
   id = 'titleout', -- 控件ID
   textSize = TextStyles().big_little,
   textColor = ColorStyles().black,
   Typeface = Typeface.createFromFile(File(activity.getLuaDir() .. "/static/font/font.ttf"))
  },
  {
   LinearLayout,
   orientation = "horizontal",
   layout_width = "fill",
   layout_height = ButtonStyles().height_5large,
   layout_marginTop = "1dp",
   layout_margin = MarginStyles().big,
   layout_marginBottom = MarginStyles().large, -- 布局底距
   {
    CardView,
    layout_width = ButtonStyles().height_2large,
    layout_height = "fill",
    layout_gravity = "center",
    cardElevation = "0dp",
    radius = RadiusStyles().small,
    cardBackgroundColor = ColorStyles().gray,

    {
     ImageView,
     id = "picout",
     layout_width = "fill",
     layout_height = "fill",
     scaleType = "centerCrop"

    }

   },
   {
    LinearLayout,
    layout_height = "fill",
    orientation = "vertical",
    layout_width = "fill",
    layout_marginLeft = MarginStyles().big, -- 布局左距
    -- layout_marginRight='4%w',--布局右距

    {
     TextView, -- 文本框控件
     layout_width = 'fill',
     layout_height = 'wrap',
     id = 'subtitleout', -- 控件ID
     textSize = TextStyles().medium,
     textColor = ColorStyles().black
     -- Typeface=Typeface.createFromFile(File(activity.getLuaDir().."/static/font.ttf"));
    }

   }
  }

 },
 {
  TextView, -- 文本框控件
  layout_width = '0',
  layout_height = '0',
  id = 'hrefout', -- 控件ID
  textSize = "0dp"
 },
 {
  TextView, -- 文本框控件
  layout_width = '0',
  layout_height = '0',
  id = 'iconhrefout', -- 控件ID
  textSize = "0dp"
 }
}
local hotpage = 1
local find_data = {}
hotout.setLayoutManager(StaggeredGridLayoutManager(1, StaggeredGridLayoutManager.VERTICAL))
hot_adapter = LuaCustRecyclerAdapter(AdapterCreator({

 getItemCount = function()
  return #find_data
 end,

 getItemViewType = function(position)
  return 0
 end,

 onCreateViewHolder = function(parent, viewType)
  local views = {}
  holder = LuaCustRecyclerHolder(loadlayout(itemout, views))
  holder.view.setTag(views)
  return holder
 end,
 onBindViewHolder = function(holder, position)
  -- print(find_data[position+1][3])
  view = holder.view.getTag()
  view.titledateout.text = find_data[position + 1][4]
  view.usernameout.text = find_data[position + 1][3]

  view.titleout.text = find_data[position + 1][5]
  view.subtitleout.text = find_data[position + 1][6]
  view.hrefout.text = find_data[position + 1][7]
  view.iconhrefout.text = find_data[position + 1][8]
  glideImg(view.userpic,find_data[position + 1][2])

  glideImg(view.picout,find_data[position + 1][1])
  -- 使用glide加载图片(加载贼流畅)


  -- 为Item设置点击事件
  view.singleItem.onClick = function()
   Http.get(find_data[position + 1][7], nil, "utf8", nil, function(a, b)
    if a == 200 then
     local htmldata = cjson.decode(b).html
     activity.newActivity("pages/douban/detail/detail",
     {find_data[position + 1][8], find_data[position + 1][3], find_data[position + 1][4],
      find_data[position + 1][5], htmldata})

    end
   end)
  end;
  if #find_data == position + 1 + 3 and #find_data ~= 0 then
   hotpage = hotpage + 1

   gethotdata(hotpage)
  end
  --[=[  view.singleItem.onLongClick = function()
         activity.newActivity("pages/play/detail",{item})
      end;
  ]=]
 end
}))

-- RecyclerView绑定适配器

hotout.setAdapter(hot_adapter)

-- hotadp=LuaAdapter(activity,itemout)
local new_data = {}
newout.setLayoutManager(StaggeredGridLayoutManager(1, StaggeredGridLayoutManager.VERTICAL))
newadp = LuaCustRecyclerAdapter(AdapterCreator({

 getItemCount = function()
  return #new_data
 end,

 getItemViewType = function(position)
  return 0
 end,

 onCreateViewHolder = function(parent, viewType)
  local views = {}
  holder = LuaCustRecyclerHolder(loadlayout(itemout, views))
  holder.view.setTag(views)
  return holder
 end,
 onBindViewHolder = function(holder, position)
  -- print(find_data[position+1][3])
  view = holder.view.getTag()
  view.titledateout.text = new_data[position + 1][4]
  view.usernameout.text = new_data[position + 1][3]

  view.titleout.text = new_data[position + 1][5]
  view.subtitleout.text = new_data[position + 1][6]
  view.hrefout.text = new_data[position + 1][7]
  view.iconhrefout.text = new_data[position + 1][8]
  glideImg(view.userpic,new_data[position + 1][2])
  glideImg(view.picout,new_data[position + 1][1])

  -- 为Item设置点击事件
  view.singleItem.onClick = function()
   Http.get(new_data[position + 1][7], nil, "utf8", nil, function(a, b)
    if a == 200 then
     local htmldata = cjson.decode(b).html
     activity.newActivity("pages/home/find/detail/detail", {new_data[position + 1][8],
      new_data[position + 1][3],
      new_data[position + 1][4],
      new_data[position + 1][5], htmldata})

    end
   end)
  end;

 end
}))
-- hotout.setAdapter(hotadp)
newout.setAdapter(newadp)
-- https://movie.douban.com/review/best/?start=20
function getnewdata()
 -- print(url)
 url = "https://movie.douban.com/review/latest/?app_name=movie"

 httpUtil.request(url, nil, nil, function(a, b)
  if a == 200 then
   find_progressbar2.setVisibility(View.GONE)
   local datas = matchall('main review%-item(.-)回应</a>', b)
   for k, v in pairs(datas) do
    -- print(v)
    local title = trim(matchonce([[<h2><a href=".-">(.-)</a></h2>]], v))
    -- print(title)
    local pic = trim(matchonce([[src="(.-)" rel=]], v))
    local subtitle = trim(replace(
    matchonce([[<div class="short%-content">(.-)&nbsp;%(<a href="javascript]], v),
    [[<p class="spoiler-tip">这篇影评可能有剧透</p>]], ""))
    local href = trim(matchonce([[<h2><a href="(.-)">]], v))
    local titledate = trim(matchonce([[class="main%-meta">(.-)</span]], v))
    local usericon = trim(matchonce([[height="24" src="(.-)"]], v))
    local username = trim(matchonce([[class="name">(.-)</a>]], v))
    local top = trim(matchonce([[useful_count.-">(.-)</span>]], v))
    local bottom = trim(matchonce([[useless_count.-">(.-)</span>]], v))
    local film = trim(matchonce([[alt="(.-)" title=]], v))
    href = "https://movie.douban.com/j/review" .. split(href, "review")[2] .. "full"
    -- print(film)
    table.insert(new_data, {pic, usericon, username, titledate, title, subtitle, href, usericon})
   end
   newadp.notifyDataSetChanged()
  end
 end)
end
getnewdata()
function gethotdata(page)
 url = "https://movie.douban.com/review/best/?start=" .. tostring(20 * (page - 1))
 httpUtil.request(url, function(a, b)
  if a == 200 then
   if page == 1 then
    find_progressbar1.setVisibility(View.GONE)
   end

   local datas = matchall('main review%-item(.-)回应</a>', b)
   if not datas then
    showToast("没有更多了")

    return
   end
   for k, v in pairs(datas) do
    --   print(v)
    local title = trim(matchonce([[<h2><a href=".-">(.-)</a></h2>]], v))
    -- print(title)
    local pic = trim(matchonce([[src="(.-)" rel=]], v))
    local subtitle = split(matchonce([[<div class="short%-content">(.-)&nbsp;%(<a href="javascript]], v),
    "</p>")
    if #subtitle == 1 then
     subtitle = trim(subtitle[1])
     else
     subtitle = trim(subtitle[2])
    end
    local href = trim(matchonce([[<h2><a href="(.-)">]], v))
    local titledate = trim(matchonce([[class="main%-meta">(.-)</span]], v))
    local usericon = trim(matchonce([[height="24" src="(.-)"]], v))
    local username = trim(matchonce([[class="name">(.-)</a>]], v))
    local top = trim(matchonce([[useful_count.-">(.-)</span>]], v))
    local bottom = trim(matchonce([[useless_count.-">(.-)</span>]], v))
    local film = trim(matchonce([[alt="(.-)" title=]], v))
    href = "https://movie.douban.com/j/review" .. split(href, "review")[2] .. "full"
    -- print(film)

    table.insert(find_data, {pic, usericon, username, titledate, title, subtitle, href, usericon})
   end

   hot_adapter.notifyDataSetChanged()
  end
 end)
end
gethotdata(hotpage)
-- 获取评论结束


