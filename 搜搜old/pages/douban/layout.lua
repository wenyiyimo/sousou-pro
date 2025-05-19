layout=loadlayout({
   LinearLayout,
   layout_width = "fill",
   orientation = "vertical",
   id = "发现页面",
   backgroundColor=ColorStyles().white,
   {
      LinearLayout,
      layout_height = "fill",
      layout_width = "fill",
      orientation = "vertical",
      {
         LinearLayout,
         layout_width = "fill",
         layout_height = ButtonStyles().height_large,
         gravity = "center",
         {
            TextView,
            id = "bt",
            text = "豆瓣影评-douban",
            textSize = TextStyles().large_little,
            gravity = "center",
            layout_weight = "1",
            textColor=ColorStyles().blue,
            --Typeface=Typeface.DEFAULT_BOLD;
            Typeface=Typeface.createFromFile(File(activity.getLuaDir().."/static/font/font.ttf"));
         }
      },
      {
         LinearLayout,
         layout_height = "fill",
         layout_width = "fill",
         orientation = "vertical",
         {
            LinearLayout,
            orientation = "horizontal",
            layout_height = ButtonStyles().height_big,
            layout_width = "fill",
            elevation = ElevationStyles().tiny,
            {
               Button,
               layout_height = ButtonStyles().height_big_little,
               layout_width = "20%w",
               id = "b1",
               background = "",
               text = "最受欢迎",
               textSize = TextStyles().medium,
               Typeface=Typeface.createFromFile(File(activity.getLuaDir().."/static/font/font.ttf"));
               layout_weight='1',
            },
            {
               Button,
               layout_height = ButtonStyles().height_big_little,
               layout_width = "20%w",
               id = "b2",
               background = "",
               text = "新片评论",
               textSize = TextStyles().medium,
               layout_weight='1',
               Typeface=Typeface.createFromFile(File(activity.getLuaDir().."/static/font/font.ttf"));
            },

         },
         {
            LinearLayout;

            layout_width="match_parent";
            layout_height="4dp";
            backgroundColor=ColorStyles().white,
            {
               CardView;
               id="scrollbar";
               layout_width="20%w";
               backgroundColor=ColorStyles().blue;
               layout_marginLeft="15%w";
               layout_height="match_parent";
            };
         };
         {
            ViewPager;
            id = "findPage",
            layout_width = "fill",
            layout_height = "fill",
         }
      }
   }
})



find1=loadlayout({
  LinearLayout,
  orientation = "vertical",
  {
    LinearLayout,
    id = "find_progressbar1",
    gravity = "center",
    layout_width = "fill",
    layout_height = "fill",
    {
      ProgressBar,

      layout_gravity = "center",

      id = "progressbar1",
      indeterminate = true,

      layout_width = "fill",
      layout_height = "20%w",

    }
  },

    {
      RecyclerView;
      layout_height="fill";
      id="hotout";
      layout_width="fill";
    };
  
})


find2=loadlayout({
  LinearLayout,
  orientation = "vertical",
  {
    LinearLayout,
    id = "find_progressbar2",
    gravity = "center",
    layout_width = "fill",
    layout_height = "fill",
    {
      ProgressBar,
      layout_gravity = "center",
      id = "progressbar2",
      layout_width = "fill",
      layout_height = "20%w",
    }
  },
  {
      RecyclerView;
      layout_height="fill";
      layout_width="fill";
      id="newout";
      layout_width="fill";
    };
})