


function getBodySiteData()

  homeClassDatas={}
  homeClassPages={}
  homeClassAdapters={}
  home_class_datas={}


  homeBodyout.removeAllViews()
  dataUtil.getTagDatas({
    site = homeSite,
    callback = function(res)
      -- showToast(dump(res))
      -- showToast(dump(homeSite))
      if res.flag then
        home_class_datas=res.datas


        for i, v in ipairs(res.datas[1]) do

          table.insert(homeClassDatas,{})
          table.insert(homeClassPages,1)
          table.insert(homeClassAdapters,LuaCustRecyclerAdapter(AdapterCreator({
            getItemCount = function()
              return #homeClassDatas[i]
            end,
            getItemViewType = function(position)
              return 0
            end,
            onCreateViewHolder = function(parent, viewType)
              local views = {}
              local holder
              if isMobile then
                holder = LuaCustRecyclerHolder(loadlayout(getVHcomponent(), views))
               else
                holder = LuaCustRecyclerHolder(loadlayout(getHHcomponent(), views))
              end
              holder.view.setTag(views)
              return holder
            end,
            onBindViewHolder = function(holder, position)
              -- print(data[position+1][1])
              local view = holder.view.getTag()
              view.title.text = homeClassDatas[i][position + 1]['标题']
              if homeClassDatas[i][position + 1]['状态'] and #homeClassDatas[i][position + 1]['状态'] > 0 then
                view.state.text = homeClassDatas[i][position + 1]['状态']
               else
                view.state.setVisibility(View.GONE)
              end
              if homeClassDatas[i][position + 1]['评分'] and #homeClassDatas[i][position + 1]['评分'] > 0 then
                view.rate.text = homeClassDatas[i][position + 1]['评分']
               else
                view.rate.setVisibility(View.GONE)
              end
              view.href.text = homeClassDatas[i][position + 1]['地址']

              local url = homeClassDatas[i][position + 1]['图片']
              glideImg(view.img, url)

              -- 子项目点击事件
              -- 为Item设置点击事件
              view.img.onClick = function()
                activity.newActivity("pages/play/play", {{homeSite, homeClassDatas[i][position + 1]}})
              end;
              if #homeClassDatas[i] == position + 1 and #homeClassDatas[i] ~= 0 then
                homeClassPages[i] = homeClassPages[i] + 1
                dataUtil.getClassDatas({
                  page = homeClassPages[i],
                  tag = i,
                  site = homeSite,
                  tagOrders = home_class_datas[2],
                  tagNames = home_class_datas[1],
                  callback = function(ress)
                    if ress.flag then
                      for k, v in pairs(ress.datas) do
                        table.insert(homeClassDatas[i], v)

                      end
                      homeClassAdapters[i].notifyDataSetChanged()
                    end
                  end
                })
              end
            end
          })))
          homeBodyout.addView(loadlayout({
            LinearLayout, -- 线性布局
            orientation = "vertical", -- 水平方向
            layout_height = "wrap",
            layout_width = "fill",
            {
              CardView,
              layout_margin = MarginStyles().medium,
              layout_width = "fill",
              layout_height = "wrap",
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
                  LinearLayout, -- 线性布局
                  orientation = "horizontal", -- 水平方向
                  layout_width = "fill", -- 布局宽度
                  layout_height = "fill", -- 布局高度
                  onClick = function()
                    activity.newActivity("pages/sougou/sougou")
                  end,
                  {
                    ImageView, -- 图片框控件
                    layout_gravity = "center", -- 重力居中
                    layout_width = ImageStyles().width_small, -- 布局宽度
                    layout_height = ImageStyles().height_small, -- 布局高度
                    src = "static/img/home/hot.png" -- 视图路径
                  },
                  {
                    TextView, -- 文本框控件
                    layout_gravity = "center", -- 重力居中
                    text = v,
                    layout_marginLeft = MarginStyles().small,
                    textSize = TextStyles().big, -- 文本大小
                    textColor = ColorStyles().black -- 文本颜色
                    -- Typeface=Typeface.createFromFile(File(activity.getLuaDir().."/static/font/zt1.ttf"));

                  },
                  {
                    LinearLayout, -- 线性布局
                    layout_weight = "1" -- 重力分配
                  }, -- 线性布局 结束
                  {
                    TextView, -- 文本框控件
                    layout_marginRight = MarginStyles().tiny, -- 布局右距
                    layout_gravity = "center", -- 重力居中
                    text = ">",

                    textSize = TextStyles().large -- 文本大小
                  }

                },
                {
                  RecyclerView,
                  layout_width = "fill", -- 布局宽度
                  layout_height = "wrap", -- 布局高度
                  id = "home_recycler_out_" .. tostring(i)
                }

              }
            }
          }))
          getIdByString("home_recycler_out_" .. tostring(i)).setLayoutManager(StaggeredGridLayoutManager(homeRowNum, StaggeredGridLayoutManager.HORIZONTAL))


          getIdByString("home_recycler_out_" .. tostring(i)).setAdapter(homeClassAdapters[i])
          --print(getIdByString("home_recycler_out_" .. tostring(index)))
          task(500*i,function()
            dataUtil.getClassDatas({
              page = 1,
              tag = i,
              site = homeSite,
              tagOrders = home_class_datas[2],
              tagNames = home_class_datas[1],
              callback = function(rest)
                if rest.flag then
                  for k, v in pairs(rest.datas) do
                    table.insert(homeClassDatas[i], v)

                  end
                  homeClassAdapters[i].notifyDataSetChanged()
                end
              end
            })

          end)
        end



      end
    end
  })
end

getBodySiteData()