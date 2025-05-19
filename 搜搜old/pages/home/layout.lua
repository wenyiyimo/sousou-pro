
function getLunboItem()
  return {
    LinearLayout,
    layout_width = "fill",
    layout_height = "fill",
    orientation = "vertical", -- 布局方向
    {
      CardView,
      layout_marginLeft = MarginStyles().small,
      layout_marginRight = MarginStyles().small,
      layout_width = "80%w",
      layout_height = "fill",
      cardElevation = "0dp",
      radius = RadiusStyles().big,
      {
        FrameLayout,
        layout_width = "fill",
        layout_height = "fill",
        {
          ImageView, -- 图片控件
          layout_width = 'fill', -- 图片宽度
          layout_height = 'fill', -- 图片高度
          -- adjustViewBounds=true, --自适应大小
          scaleType = "centerCrop",
          -- src = data.img,
          id = "img"
        },

        {
          LinearLayout,
          layout_width = "fill",
          layout_height = "wrap",
          layout_margin = MarginStyles().small,
          orientation = "vertical", -- 布局方向
          layout_gravity = "left|bottom", -- 重力居中

          {
            TextView, -- 文本框控件
            -- text = data.title,
            id = "title",
            singleLine = true,
            ellipsize = "marquee",
            selected = true,
            textColor = ColorStyles().white,
            -- Typeface = Typeface.DEFAULT_BOLD, -- 字体
            Typeface = Typeface.createFromFile(File(activity.getLuaDir() .. "/static/font/zt1.ttf")),
            textSize = TextStyles().big_little -- 文本大小
          },
          {
            LinearLayout,
            layout_width = "fill",
            layout_height = "wrap",
            -- layout_margin = MarginStyles().small,
            orientation = "horizontal", -- 布局方向
            layout_gravity = "left|bottom", -- 重力居中
            {
              TextView, -- 文本框控件
              -- text = data.info,
              id = "info",
              singleLine = true,
              ellipsize = "marquee",
              selected = true,
              layout_weight = 1,
              textSize = TextStyles().medium, -- 文本大小
              textColor = ColorStyles().white,
              Typeface = Typeface.createFromFile(File(activity.getLuaDir() .. "/static/font/zt1.ttf"))
              -- Typeface = Typeface.DEFAULT_BOLD -- 字体
            },
            {
              TextView, -- 文本框控件
              -- text = data.state,
              layout_gravity = "right|bottom", -- 重力居中
              id = "state",
              singleLine = true,
              ellipsize = "marquee",
              selected = true,
              textSize = TextStyles().medium, -- 文本大小
              textColor = ColorStyles().white, -- 文本颜色
              -- Typeface = Typeface.DEFAULT_BOLD, -- 字体
              Typeface = Typeface.createFromFile(File(activity.getLuaDir() .. "/static/font/zt1.ttf"))

            }

          }
        }
      }
    }
  }
end

function getVHcomponent(data)
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
    layout_width = "wrap", -- 布局宽度
    layout_height = "wrap", -- 布局高度
    gravity = "center", -- 重力居中
    {
      LinearLayout,
      orientation = "vertical", -- 布局方向
      layout_width = "25%w", -- 布局宽度
      layout_height = "wrap", -- 布局高度
      layout_margin = "2%w",

      {
        CardView,
        layout_width = "fill",
        layout_height = "35%w",
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
              layout_margin = MarginStyles().tiny,
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
        --textColor = ColorStyles().black,
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
function getHHcomponent(data)
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
    layout_width = "wrap", -- 布局宽度
    layout_height = "wrap", -- 布局高度
    {
      LinearLayout,
      orientation = "vertical", -- 布局方向
      layout_width = "10%w", -- 布局宽度
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
              layout_margin = MarginStyles().tiny,
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
        -- textColor = ColorStyles().black,
        layout_marginTop = "1%w",
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

function getVcomponent(data)
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
      layout_width = "30%w", -- 布局宽度
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
        selected = true,
        layout_marginTop = "2%w",
        --textColor = ColorStyles().black,
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
function getHcomponent(data)
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
      layout_width = "10%w", -- 布局宽度
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

function getTcomponent()
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
-- function getHcomponent(data)
--     if not data then
--         data = {
--             img = '',
--             title = '',
--             state = '',
--             href = '',
--             rate = ''
--         }
--     end
--     return {
--         LinearLayout,
--         orientation = "vertical", -- 布局方向
--         layout_width = "wrap", -- 布局宽度
--         layout_height = "wrap", -- 布局高度
--         {
--             LinearLayout,
--             orientation = "vertical", -- 布局方向
--             layout_width = "50%w", -- 布局宽度
--             layout_height = "wrap", -- 布局高度
--             layout_margin = MarginStyles().small,

--             {
--                 MaterialCardView,
--                 layout_width = "fill",
--                 layout_height = "34%w",
--                 Radius = RadiusStyles().small,
--                 padding = MarginStyles().small,
--                 {
--                     FrameLayout,
--                     layout_width = "fill",
--                     layout_height = "fill",
--                     {
--                         ImageView,
--                         id = "img",
--                         src = data.img,
--                         layout_width = "fill",
--                         layout_height = "fill",
--                         scaleType = "centerCrop"
--                     },
--                     {
--                         MaterialCardView,
--                         Radius = RadiusStyles().tiny,
--                         layout_gravity = "left|top", -- 重力居中
--                         {
--                             TextView, -- 文本框控件
--                             text = data.state,
--                             id = "state",
--                             singleLine = true,
--                             ellipsize = "marquee",
--                             selected = true,
--                             textSize = TextStyles().small, -- 文本大小
--                             textColor = ColorStyles().white, -- 文本颜色
--                             backgroundColor = ColorStyles().little_blue -- 背景颜色
--                         }
--                     },
--                     {
--                         MaterialCardView,
--                         Radius = RadiusStyles().tiny,
--                         layout_gravity = "right|bottom", -- 重力居中
--                         {
--                             TextView, -- 文本框控件
--                             text = data.rate,
--                             id = "rate",
--                             singleLine = true,
--                             ellipsize = "marquee",
--                             selected = true,
--                             textSize = TextStyles().small, -- 文本大小
--                             textColor = ColorStyles().white, -- 文本颜色
--                             backgroundColor = ColorStyles().little_blue -- 背景颜色
--                         }
--                     }
--                 }
--             },
--             {
--                 TextView, -- 文本框控件
--                 layout_marginRight = MarginStyles().tiny, -- 布局右距
--                 layout_gravity = "center", -- 重力居中
--                 text = data.title,
--                 id = "title",
--                 singleLine = true,
--                 ellipsize = "marquee",
--                 selected = true,
--                 layout_marginTop = MarginStyles().small,
--                 Typeface = Typeface.DEFAULT_BOLD, -- 字体
--                 textSize = TextStyles().big_little -- 文本大小
--             },
--             {
--                 TextView, -- 文本框控件
--                 layout_width = 0, -- 布局宽度
--                 layout_height = 0, -- 布局高度
--                 id = "href",
--                 selected = true,
--                 text = data.href
--             }
--         }
--     }

-- end



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
        textColor = 0x99000000,
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
        textColor = 0x99000000,
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


function getTcomponent()
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