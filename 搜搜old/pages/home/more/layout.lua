-- layout = loadlayout({
--     LinearLayout,
--     layout_height = "fill",
--     layout_width = "fill",
--     backgroundColor = ColorStyles().white,
--     orientation = 'vertical',
--     {
--         RecyclerView,
--         layout_width = "fill", -- 布局宽度
--         layout_height = "wrap", -- 布局高度
--         id = "siteout"
--     },
--     {
--         RecyclerView,
--         layout_width = "fill", -- 布局宽度
--         layout_height = "wrap", -- 布局高度
--         id = "classout"
--     },
--     {
--         RecyclerView,
--         layout_width = "fill", -- 布局宽度
--         layout_height = "wrap", -- 布局高度
--         id = "bodyout"
--     },
--     {
--         LinearLayout,
--         layout_marginTop = "15%h",
--         layout_width = "120dp",
--         layout_height = "120dp",
--         orientation = "vertical",
--         layout_gravity = "center",
--         id = 'loading',
--         BackgroundDrawable = setProgress(ColorStrings().blue)
--     }
-- })
function getVMcomponent(data)
  if not data then
    data = {
      img = '',
      title = '',
      state = '',
      href = '',
      rate = ''
    }
  end
  return {
    LinearLayout,
    orientation = "vertical", -- 布局方向
    layout_width = "fill", -- 布局宽度
    layout_height = "wrap", -- 布局高度
    gravity = "center", -- 重力居中
    {
      LinearLayout,
      orientation = "vertical", -- 布局方向
      layout_width = "fill", -- 布局宽度
      layout_height = "wrap", -- 布局高度
      layout_margin = "2%w",

      {
        CardView,
        layout_width = "fill",
        layout_height = "42%w",
        Radius = RadiusStyles().small,
        padding = MarginStyles().small,
        {
          FrameLayout,
          layout_width = "fill",
          layout_height = "fill",
          {
            ImageView,
            id = "img",
            src = data.img,
            layout_width = "fill",
            layout_height = "fill",
            scaleType = "centerCrop"
          },
          {
            CardView,
            Radius = RadiusStyles().small,
            layout_gravity = "left|bottom", -- 重力居中
            cardBackgroundColor = ColorStyles().little_blue, -- 背景颜色

            {
              TextView, -- 文本框控件
              text = data.state,
              id = "state",
              layout_margin = MarginStyles().tiny,
              singleLine = true,
              ellipsize = "marquee",
              selected = true,
              textSize = TextStyles().small, -- 文本大小
              textColor = ColorStyles().white -- 文本颜色

            }
          },
          {
            CardView,
            Radius = RadiusStyles().small,
            cardBackgroundColor = ColorStyles().little_blue, -- 背景颜色
            layout_gravity = "right|top", -- 重力居中
            {
              TextView, -- 文本框控件
              text = data.rate,
              id = "rate",
              singleLine = true,
              ellipsize = "marquee",
              selected = true,
              layout_margin = MarginStyles().tiny,
              textSize = TextStyles().small, -- 文本大小
              textColor = ColorStyles().white -- 文本颜色

            }
          }
        }
      },
      {
        TextView, -- 文本框控件
        layout_gravity = "center", -- 重力居中
        text = data.title,
        id = "title",
        singleLine = true,
        ellipsize = "marquee",
       -- textColor = ColorStyles().black,
        selected = true,
        layout_marginTop = "2%w",
        Typeface = Typeface.DEFAULT_BOLD, -- 字体
        textSize = TextStyles().big_little -- 文本大小
      },
      {
        TextView, -- 文本框控件
        layout_width = 0, -- 布局宽度
        layout_height = 0, -- 布局高度
        id = "href",
        selected = true,
        text = data.href
      }
    }
  }

end
function getHMcomponent(data)
  if not data then
    data = {
      img = '',
      title = '',
      state = '',
      href = '',
      rate = ''
    }
  end
  return {
    LinearLayout,
    orientation = "vertical", -- 布局方向
    layout_width = "fill", -- 布局宽度
    layout_height = "wrap", -- 布局高度
    {
      LinearLayout,
      orientation = "vertical", -- 布局方向
      layout_width = "fill", -- 布局宽度
      layout_height = "wrap", -- 布局高度
      layout_margin = "1%w",

      {
        CardView,
        layout_width = "fill",
        layout_height = "14%w",
        Radius = RadiusStyles().small,
        padding = MarginStyles().small,
        {
          FrameLayout,
          layout_width = "fill",
          layout_height = "fill",
          {
            ImageView,
            id = "img",
            src = data.img,
            layout_width = "fill",
            layout_height = "fill",
            scaleType = "centerCrop"
          },
          {
            CardView,
            Radius = RadiusStyles().small,
            cardBackgroundColor = ColorStyles().little_blue, -- 背景颜色
            layout_gravity = "left|bottom", -- 重力居中
            {
              TextView, -- 文本框控件
              text = data.state,
              id = "state",
              singleLine = true,
              ellipsize = "marquee",
              selected = true,
              textSize = TextStyles().small, -- 文本大小
              textColor = ColorStyles().white, -- 文本颜色
              layout_margin = MarginStyles().tiny
            }
          },
          {
            CardView,
            Radius = RadiusStyles().small,
            cardBackgroundColor = ColorStyles().little_blue, -- 背景颜色
            layout_gravity = "right|top", -- 重力居中
            {
              TextView, -- 文本框控件
              text = data.rate,
              id = "rate",
              singleLine = true,
              ellipsize = "marquee",
              selected = true,
              layout_margin = MarginStyles().tiny,
              textSize = TextStyles().small, -- 文本大小
              textColor = ColorStyles().white -- 文本颜色

            }
          }
        }
      },
      {
        TextView, -- 文本框控件
        layout_gravity = "center", -- 重力居中
        text = data.title,
        id = "title",
        singleLine = true,
        ellipsize = "marquee",
        selected = true,
        layout_marginTop = "1%w",
       -- textColor = ColorStyles().black,
        Typeface = Typeface.DEFAULT_BOLD, -- 字体
        textSize = TextStyles().big_little -- 文本大小
      },
      {
        TextView, -- 文本框控件
        layout_width = 0, -- 布局宽度
        layout_height = 0, -- 布局高度
        id = "href",
        selected = true,
        text = data.href
      }
    }
  }

end

function getTMcomponent()
  return {
    LinearLayout,
    Orientation = "vertical",
    layout_width = "wrap",
    layout_height = "fill",
    Gravity = "center",
    backgroundColor = ColorStyles().white,
    {
      CardView,

      Elevation = "0dp",
      layout_width = "wrap",
      layout_height = "wrap",
      radius = RadiusStyles().medium,
      layout_margin = MarginStyles().tiny,
      -- CardBackgroundColor = 0xffffffff,
      {
        LinearLayout,
        Orientation = "vertical",
        layout_width = "wrap",
        layout_height = "fill",
        Gravity = "center",
        id = "card",
        padding = PaddingStyles().small,
        {
          TextView,
          id = "text",
          -- layout_marginLeft = MarginStyles().small,
          -- layout_marginRight = MarginStyles().small,
          Gravity = "center",
          Typeface = Typeface.createFromFile(File(activity.getLuaDir() .. "/static/font/zt2.ttf")),
          -- textColor = 0xC9000000,
          -- Typeface = L0_0.Typeface.defaultFromStyle(L0_0.Typeface.BOLD),
          --  layout_margin = MarginStyles().tiny,
          textSize = TextStyles().medium
        }
      }
    }
  }
end

function getVHMcomponent(data)
  if not data then
    data = {
      img = '',
      title = '',
      state = '',
      href = '',
      rate = ''
    }
  end
  return {
    LinearLayout,
    orientation = "vertical", -- 布局方向
    layout_width = "fill", -- 布局宽度
    layout_height = "wrap", -- 布局高度
    gravity = "center", -- 重力居中
    {
      LinearLayout,
      orientation = "vertical", -- 布局方向
      layout_width = "fill", -- 布局宽度
      layout_height = "wrap", -- 布局高度
      layout_margin = "2%w",

      {
        CardView,
        layout_width = "fill",
        layout_height = "30%w",
        Radius = RadiusStyles().small,
        padding = MarginStyles().small,
        {
          FrameLayout,
          layout_width = "fill",
          layout_height = "fill",
          {
            ImageView,
            id = "img",
            src = data.img,
            layout_width = "fill",
            layout_height = "fill",
            scaleType = "centerCrop"
          },
          {
            CardView,
            Radius = RadiusStyles().small,
            layout_gravity = "left|bottom", -- 重力居中
            cardBackgroundColor = ColorStyles().little_blue, -- 背景颜色

            {
              TextView, -- 文本框控件
              text = data.state,
              id = "state",
              layout_margin = MarginStyles().tiny,
              singleLine = true,
              ellipsize = "marquee",
              selected = true,
              textSize = TextStyles().small, -- 文本大小
              textColor = ColorStyles().white -- 文本颜色

            }
          },
          {
            CardView,
            Radius = RadiusStyles().small,
            cardBackgroundColor = ColorStyles().little_blue, -- 背景颜色
            layout_gravity = "right|top", -- 重力居中
            {
              TextView, -- 文本框控件
              text = data.rate,
              id = "rate",
              singleLine = true,
              ellipsize = "marquee",
              selected = true,
              layout_margin = MarginStyles().tiny,
              textSize = TextStyles().small, -- 文本大小
              textColor = ColorStyles().white -- 文本颜色

            }
          }
        }
      },
      {
        TextView, -- 文本框控件
        layout_gravity = "center", -- 重力居中
        text = data.title,
        id = "title",
        singleLine = true,
        ellipsize = "marquee",
        selected = true,
        layout_marginTop = "2%w",
       -- textColor = ColorStyles().black,
        Typeface = Typeface.DEFAULT_BOLD, -- 字体
        textSize = TextStyles().big_little -- 文本大小
      },
      {
        TextView, -- 文本框控件
        layout_width = 0, -- 布局宽度
        layout_height = 0, -- 布局高度
        id = "href",
        selected = true,
        text = data.href
      }
    }
  }

end
function getHHMcomponent(data)
  if not data then
    data = {
      img = '',
      title = '',
      state = '',
      href = '',
      rate = ''
    }
  end
  return {
    LinearLayout,
    orientation = "vertical", -- 布局方向
    layout_width = "fill", -- 布局宽度
    layout_height = "wrap", -- 布局高度
    {
      LinearLayout,
      orientation = "vertical", -- 布局方向
      layout_width = "fill", -- 布局宽度
      layout_height = "wrap", -- 布局高度
      layout_margin = "1%w",

      {
        CardView,
        layout_width = "fill",
        layout_height = "9%w",
        Radius = RadiusStyles().small,
        padding = MarginStyles().small,
        {
          FrameLayout,
          layout_width = "fill",
          layout_height = "fill",
          {
            ImageView,
            id = "img",
            src = data.img,
            layout_width = "fill",
            layout_height = "fill",
            scaleType = "centerCrop"
          },
          {
            CardView,
            Radius = RadiusStyles().small,
            cardBackgroundColor = ColorStyles().little_blue, -- 背景颜色
            layout_gravity = "left|bottom", -- 重力居中
            {
              TextView, -- 文本框控件
              text = data.state,
              id = "state",
              singleLine = true,
              ellipsize = "marquee",
              selected = true,
              textSize = TextStyles().small, -- 文本大小
              textColor = ColorStyles().white, -- 文本颜色
              layout_margin = MarginStyles().tiny
            }
          },
          {
            CardView,
            Radius = RadiusStyles().small,
            cardBackgroundColor = ColorStyles().little_blue, -- 背景颜色
            layout_gravity = "right|top", -- 重力居中
            {
              TextView, -- 文本框控件
              text = data.rate,
              id = "rate",
              singleLine = true,
              ellipsize = "marquee",
              selected = true,
              layout_margin = MarginStyles().tiny,
              textSize = TextStyles().small, -- 文本大小
              textColor = ColorStyles().white -- 文本颜色

            }
          }
        }
      },
      {
        TextView, -- 文本框控件
        layout_gravity = "center", -- 重力居中
        text = data.title,
        id = "title",
        singleLine = true,
        ellipsize = "marquee",
        selected = true,
        layout_marginTop = "1%w",
       -- textColor = ColorStyles().black,
        Typeface = Typeface.DEFAULT_BOLD, -- 字体
        textSize = TextStyles().big_little -- 文本大小
      },
      {
        TextView, -- 文本框控件
        layout_width = 0, -- 布局宽度
        layout_height = 0, -- 布局高度
        id = "href",
        selected = true,
        text = data.href
      }
    }
  }

end

