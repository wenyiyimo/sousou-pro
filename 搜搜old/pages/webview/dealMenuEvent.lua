local menuBody = {
  CardView,
  -- orientation = "horizontal",
  layout_height = "fill",
  layout_width = "fill",
  radius = "15dp",

  backgroundColor = 0xffffffff,
  {
    LinearLayout, -- 线性布局
    layout_width = 'fill', -- 宽度
    layout_height = 'fill', -- 高度
    -- background = '#ffFFFFFF', -- 背景颜色或图片路径
    orientation = "vertical",
    layout_margin = '24dp', -- 布局左距
    {
      RecyclerView,
      layout_height = "fill",
      id = "tool_list",
      layout_width = "fill"
    }

  }
}

toolItem = {

  LinearLayout, -- 线性布局
  layout_width = 'fill', -- 宽度
  layout_height = 'wrap', -- 高度
  background = '#ffFFFFFF', -- 背景颜色或图片路径
  orientation = "vertical",
  {

    LinearLayout, -- 线性布局
    layout_width = 'fill', -- 宽度
    layout_height = 'fill', -- 高度
    background = '#ffFFFFFF', -- 背景颜色或图片路径
    orientation = "vertical",
    layout_marginBottom = "20dp",
    -- layout_margin = '24dp', -- 布局左距
    gravity = "center",
    id = "singleItem",
    {
      ImageView,
      layout_width = "20dp",
      layout_height = "20dp",
      id = "icon",
      ColorFilter = "#33000000"
    },
    {
      TextView,
      layout_width = "wrap_content",
      layout_height = "wrap_content",
      id = "name",
      text = "工具名称",
      textColor = "#99000000",
      textSize = "14dp",
      layout_marginTop = "8dp"
    }
  }
}

local toolDatas = {{
    ["icon"] = "static/img/webview/plus.png",
    ["name"] = "添加书签",
    ["id"] = "addMark"

    }, {
    ["icon"] = "static/img/webview/mark.png",
    ["name"] = "书签",
    ["id"] = "mark"
    }, {
    ["icon"] = "static/img/webview/his.png",
    ["name"] = "历史记录",
    ["id"] = "history"
    }, {
    ["icon"] = "static/img/webview/change.png",
    ["name"] = "切换ua",
    ["id"] = "agent"
    }, {
    ["icon"] = "static/img/webview/set_home.png",
    ["name"] = "设为主页",
    ["id"] = "home"
    }, {
    ["icon"] = "static/img/webview/html.png",
    ["name"] = "查看源码",
    ["id"] = "html"
    }, {
    ["icon"] = "static/img/webview/cookie.png",
    ["name"] = "获取cookie",
    ["id"] = "cookie"
    }, {
    ["icon"] = "static/img/webview/close.png",
    ["name"] = "关闭",
    ["id"] = "close"
}}

menu.onClick = function()
  isPop = true
  menuPop = PopupWindow(activity).setContentView(loadlayout(menuBody)).setWidth(activity.width) -- 设置宽度
  .setHeight(500).setFocusable(false) -- 设置可获得焦点
  .setTouchable(true).setClippingEnabled(false) -- 设置启用剪辑
  .setBackgroundDrawable(nil) -- 设置可触摸
  .setOutsideTouchable(true)
  activity.getWindow().attributes.systemUiVisibility = View.SYSTEM_UI_FLAG_HIDE_NAVIGATION or View.SYSTEM_UI_FLAG_IMMERSIVE
  menuPop.showAtLocation(menu, Gravity.BOTTOM, 0, 0)
  menuPop.onDismiss = function()
    isPop = false
  end

  tool_list.setLayoutManager(StaggeredGridLayoutManager(4, StaggeredGridLayoutManager.VERTICAL))

  toolAdapter = LuaRecyclerAdapter(toolDatas, toolItem, {
    onBindViewHolder = function(holder, position)
      local view = holder.view.getTag()
      local data = toolDatas[position + 1]
      view.name.setText(data.name)
      view.icon.setImageBitmap(loadbitmap(data.icon))

      view.singleItem.onClick = function()
        if data.id == "close" then
          menuPop.dismiss()
         elseif data.id == "cookie" then
          local cookieTipout = {
            LinearLayout,
            background = "#ffffffff",
            layout_height = "fill",
            orientation = "vertical",
            layout_width = "fill",
            gravity = 'center',
            {
              TextView, -- 文本框控件
              textSize = "16dp",
              text = "请选择获取cookie", -- 文本内容
              layout_width = 'fill',
              layout_height = 'wrap',
              layout_margin = '15dp', -- 布局边距
              textColor = "#227CEA"
              -- Typeface=Typeface.createFromFile(File(activity.getLuaDir().."/static/font.ttf"));
            },
            {
              LinearLayout, -- 线性布局
              layout_width = 'fill',
              layout_height = 'wrap',
              orientation = 'horizontal',
              gravity = 'right',
              -- layout_margin='15dp',--布局边距

              {
                TextView, -- 文本框控件
                text = '当前地址', -- 文本内容
                textSize = "16dp",
                textColor = "#227CEA",
                layout_margin = '15dp', -- 布局边距
                onClick = function()
                  systemUtil.copyContent(getCookie(webView.getUrl()))
                  cookieDialog.dismiss()
                end
              },
              {
                TextView, -- 文本框控件
                text = '域名cookie', -- 文本内容
                textSize = "16dp",
                textColor = "#227CEA",
                layout_margin = '15dp', -- 布局边距
                onClick = function()
                  local rootUrl = Uri.parse(webView.getUrl()).authority
                  systemUtil.copyContent(getCookie(rootUrl))
                  cookieDialog.dismiss()
                end
              },
              {
                TextView, -- 文本框控件;
                text = '取消', -- 文本内容
                textSize = "16dp",
                layout_margin = '15dp', -- 布局边距
                textColor = "#227CEA",
                onClick = function()
                  cookieDialog.dismiss()
                end
              }
            }

          }
          cookieDialog = Dialog(activity).setContentView(loadlayout(cookieTipout))

          cookieDialog.getWindow().setBackgroundDrawable(ColorDrawable(0xffffffff))
          -- 设置触摸弹窗外部隐藏弹窗

          cookieDialog.setCanceledOnTouchOutside(true);
          local p = cookieDialog.getWindow().getAttributes()
          p.dimAmount = 0
          p.width = activity.width * 0.8

          -- p.height=activity.Height*0.74;
          cookieDialog.getWindow().setAttributes(p);
          -- dialog.getWindow().getDecorView().setPadding(0,0,0,0)

          cookieDialog.show()

         elseif data.id == "html" then

          webView.loadUrl("view-source:"..webView.getUrl())
          viewSource=true
          menuPop.dismiss()

         elseif data.id == "home" then
          settingUtil.setSetting("webDefaultUrl", webView.getUrl())
          showToast("设置成功！")
         elseif data.id == "agent" then

          local agentTipout = {

            LinearLayout,
            background = "#ffffffff",
            layout_height = "fill",
            orientation = "vertical",
            layout_width = "fill",
            gravity = 'center',
            {
              TextView, -- 文本框控件
              textSize = "16dp",
              text = "请设置UA", -- 文本内容
              layout_width = 'fill',
              layout_height = 'wrap',
              layout_margin = '15dp', -- 布局边距
              textColor = "#227CEA"
              -- Typeface=Typeface.createFromFile(File(activity.getLuaDir().."/static/font.ttf"));
            },
            {
              LinearLayout, -- 线性布局
              layout_width = 'fill',
              layout_height = 'wrap',
              orientation = 'horizontal',
              gravity = 'right',
              -- layout_margin='15dp',--布局边距

              {
                TextView, -- 文本框控件
                text = '手机', -- 文本内容
                textSize = "16dp",
                textColor = "#227CEA",
                layout_margin = '15dp', -- 布局边距
                onClick = function()
                  webDefaultUA =
                  "Mozilla/5.0 (Linux; Android 10; Pixel 3 XL) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.152 Mobile Safari/537.36"
                  settingUtil.setSetting("webDefaultUA", webDefaultUA)
                  webView.reload()
                  agentDialog.dismiss()
                end
              },
              {
                TextView, -- 文本框控件
                text = '电脑', -- 文本内容
                textSize = "16dp",
                textColor = "#227CEA",
                layout_margin = '15dp', -- 布局边距
                onClick = function()
                  webDefaultUA =
                  "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.152 Safari/537.36"
                  settingUtil.setSetting("webDefaultUA", webDefaultUA)
                  webView.reload()
                  agentDialog.dismiss()
                end
              },
              {
                TextView, -- 文本框控件
                text = '平板', -- 文本内容
                textSize = "16dp",
                textColor = "#227CEA",
                layout_margin = '15dp', -- 布局边距
                onClick = function()
                  webDefaultUA =
                  "Mozilla/5.0 (iPad; CPU OS 14_4 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/14.0.3 Mobile/15E148 Safari/604.1"
                  settingUtil.setSetting("webDefaultUA", webDefaultUA)
                  webView.reload()
                  agentDialog.dismiss()
                end
              },

              {
                TextView, -- 文本框控件
                text = '自定义', -- 文本内容
                textSize = "16dp",
                textColor = "#227CEA",
                layout_margin = '15dp', -- 布局边距
                onClick = function()
                  agentDialog.dismiss()
                  userDialog = AlertDialog.Builder(this).setTitle("自定义UA").setView(loadlayout({
                    LinearLayout,
                    background = "0xFFFFFFFF",
                    orientation = "vertical",
                    layout_height = "match_parent",
                    layout_width = "fill",

                    {
                      EditText,
                      Text = "",
                      id = "uatext",
                      hint = "请填写UA",
                      -- Typeface = L4_14.Typeface.defaultFromStyle(L4_14.Typeface.BOLD),
                      layout_marginTop = "10dp",
                      layout_width = "80%w",
                      layout_gravity = "center",
                      MaxLines = 1, -- 设置最大输入行数
                      MaxEms = 100000,
                      Typeface = Typeface.DEFAULT_BOLD,
                      textSize = "13dp",
                      background = "#00000000"
                    },
                    {
                      LinearLayout,
                      layout_width = "80%w",
                      layout_height = "1dp",
                      layout_marginTop = "-2dp",
                      layout_gravity = "center",
                      backgroundColor = 0xff227CEA,
                      id = "弹窗下划线"
                    }
                  })) -- .setMessage("消息")
                  .setPositiveButton("确定", {
                    onClick = function(v)
                      webDefaultUA = uatext.text

                      settingUtil.setSetting("webDefaultUA", webDefaultUA)
                      webView.reload()
                    end
                  }).setNegativeButton("取消", nil).show()
                  userDialog.create()

                  -- 更改Button颜色
                  import "android.graphics.Color"
                  userDialog.getButton(userDialog.BUTTON_POSITIVE).setTextColor(0xff227CEA)
                  userDialog.getButton(userDialog.BUTTON_NEGATIVE).setTextColor(0xff227CEA)
                  userDialog.getButton(userDialog.BUTTON_NEUTRAL).setTextColor(0xff227CEA)

                  -- 更改Title颜色
                  import "android.text.SpannableString"
                  import "android.text.style.ForegroundColorSpan"
                  import "android.text.Spannable"
                  sp = SpannableString("设置UA")
                  sp.setSpan(ForegroundColorSpan(0xff227CEA), 0, #sp, Spannable.SPAN_EXCLUSIVE_INCLUSIVE)
                  userDialog.setTitle(sp)

                end
              },
              {
                TextView, -- 文本框控件;
                text = '取消', -- 文本内容
                textSize = "16dp",
                layout_margin = '15dp', -- 布局边距
                textColor = "#227CEA",
                onClick = function()
                  agentDialog.dismiss()
                end
              }
            }

          }
          agentDialog = Dialog(activity).setContentView(loadlayout(agentTipout))

          agentDialog.getWindow().setBackgroundDrawable(ColorDrawable(0xffffffff))
          -- 设置触摸弹窗外部隐藏弹窗

          agentDialog.setCanceledOnTouchOutside(true);
          local p = agentDialog.getWindow().getAttributes()
          p.dimAmount = 0
          p.width = activity.width * 0.8

          -- p.height=activity.Height*0.74;
          agentDialog.getWindow().setAttributes(p);
          -- dialog.getWindow().getDecorView().setPadding(0,0,0,0)

          agentDialog.show()

         elseif data.id == "history" then
          local hisBody = {
            LinearLayout,
            layout_height = "fill",
            layout_width = "fill",
            orientation = "vertical",
            backgroundColor = "#ffffff",
            {
              LinearLayout,
              layout_height = "50dp",
              layout_width = "fill",
              orientation = "horizontal",
              layout_margin="10dp";
              gravity="center",
              {

                TextView,
                layout_width = "wrap_content",
                layout_height = "wrap_content",
                Typeface = Typeface.createFromFile(File(activity.getLuaDir() .. "/static/font/zt1.ttf")),

                text = "历史",
                textColor = 0xff227CEA,
                textSize = "18dp",
                layout_weight=1,
              },

              {
                ImageView, -- 图片控件
                layout_width = '30dp', -- 图片宽度
                layout_height = '30dp', -- 图片高度
                src = "static/img/webview/delete.png",
                layout_marginLeft = '10dp',
                --    id="homeButton"; ColorFilter='#5C5C5C';--图片着色
                scaleType = 'fitXY', -- 图片拉伸
                id = 'clearHis',
                ColorFilter = "#99000000",
                layout_gravity = 'center' -- 重力
              }

            },
            {
              RecyclerView,
              id = "hisList",
              layout_height = "fill",
              layout_width = "fill"
            }
          }
          hisItem = {
            LinearLayout,
            layout_width = "fill",
            orientation = "vertical",
            descendantFocusability = ViewGroup.FOCUS_BLOCK_DESCENDANTS, -- 阻止内部控件抢占焦点，如Button及其子控件
            {
              TextView,
              layout_height = "1dp",
              layout_width = "fill",
              backgroundColor = 0x55000000,
              singleLine = true,
              gravity = "left|center"
            },
            {
              LinearLayout,
              layout_height = "40dp",
              layout_width = "fill",
              orientation = "horizontal",
              gravity = "left|center",
              id = "singleItem",
              layout_margin = '10dp',
              {
                ImageView,
                layout_height = "30dp",
                layout_width = "30dp",
                layout_marginRight = '10dp',
                layout_gravity = "left|center",
                scaleType = 'centerCrop', -- 图片拉伸
                id = 'icon'
                -- ColorFilter = "#33000000"
              },
              {
                TextView,
                id = "name",
                layout_height = "30dp",
                layout_width = "fill",
                textColor=0xff000000,
                singleLine = true,
                gravity = "left|center",
                layout_weight = "1"

              }
            }

          }

          hisPop = PopupWindow(activity).setContentView(loadlayout(hisBody)).setWidth(activity.width) -- 设置宽度
          .setHeight(activity.height * 0.8).setFocusable(false) -- 设置可获得焦点
          .setTouchable(true).setClippingEnabled(false) -- 设置启用剪辑
          .setBackgroundDrawable(nil) -- 设置可触摸
          .setOutsideTouchable(true)
          activity.getWindow().attributes.systemUiVisibility =
          View.SYSTEM_UI_FLAG_HIDE_NAVIGATION or View.SYSTEM_UI_FLAG_IMMERSIVE
          hisPop.showAtLocation(menu, Gravity.BOTTOM, 0, 0)

          toolPop=hisPop
          hisPop.onDismiss = function()
            toolPop = false
          end


          hisList.setLayoutManager(StaggeredGridLayoutManager(1, StaggeredGridLayoutManager.VERTICAL))
          historys = webUrlUtil.getHistorys()
          hisAdapter = LuaCustRecyclerAdapter(AdapterCreator({
            getItemCount = function()
              if not historys or tostring(historys)=="nil" then
                historys = webUrlUtil.getHistorys()
              end
              return #historys
            end,
            getItemViewType = function(position)
              return 0
            end,
            onCreateViewHolder = function(parent, viewType)
              local views = {}
              holder = LuaCustRecyclerHolder(loadlayout(hisItem, views))
              holder.view.setTag(views)
              return holder
            end,
            onBindViewHolder = function(holder, position)
              local view = holder.view.getTag()
              view.name.setText(historys[position + 1].name)

              glideImg(view.icon, historys[position + 1].icon)

              view.singleItem.onClick = function()
                hisPop.dismiss()
                menuPop.dismiss()
                webView.loadUrl(historys[position + 1].url)
              end
              view.singleItem.onLongClick = function()
                local hisTipout = {

                  LinearLayout,
                  background = "#ffffffff",
                  layout_height = "fill",
                  orientation = "vertical",
                  layout_width = "fill",
                  gravity = 'center',
                  {
                    TextView, -- 文本框控件
                    textSize = "16dp",
                    text = "请选择操作", -- 文本内容
                    layout_width = 'fill',
                    layout_height = 'wrap',
                    layout_margin = '15dp', -- 布局边距
                    textColor = "#227CEA"
                    -- Typeface=Typeface.createFromFile(File(activity.getLuaDir().."/static/font.ttf"));
                  },
                  {
                    LinearLayout, -- 线性布局
                    layout_width = 'fill',
                    layout_height = 'wrap',
                    orientation = 'horizontal',
                    gravity = 'right',
                    -- layout_margin='15dp',--布局边距
                    {
                      TextView, -- 文本框控件
                      text = '删除', -- 文本内容
                      textSize = "16dp",
                      textColor = "#227CEA",
                      layout_margin = '15dp', -- 布局边距
                      onClick = function()

                        historys = webUrlUtil.removeHistory(position + 1)
                        hisAdapter.notifyDataSetChanged()
                        hisDialog.dismiss()
                      end
                    },

                    {
                      TextView, -- 文本框控件
                      text = '复制', -- 文本内容
                      textSize = "16dp",
                      textColor = "#227CEA",
                      layout_margin = '15dp', -- 布局边距
                      onClick = function()
                        systemUtil.copyContent(historys[position + 1].url)
                        hisDialog.dismiss()
                      end
                    },

                    {
                      TextView, -- 文本框控件;
                      text = '取消', -- 文本内容
                      textSize = "16dp",
                      layout_margin = '15dp', -- 布局边距
                      textColor = "#227CEA",
                      onClick = function()
                        hisDialog.dismiss()
                      end
                    }

                  }

                }
                hisDialog = Dialog(activity).setContentView(loadlayout(hisTipout))

                hisDialog.getWindow().setBackgroundDrawable(ColorDrawable(0xffffffff))
                -- 设置触摸弹窗外部隐藏弹窗

                hisDialog.setCanceledOnTouchOutside(true);
                local p = hisDialog.getWindow().getAttributes()
                p.dimAmount = 0
                p.width = activity.width * 0.8

                -- p.height=activity.Height*0.74;
                hisDialog.getWindow().setAttributes(p);
                -- dialog.getWindow().getDecorView().setPadding(0,0,0,0)

                hisDialog.show()
              end
            end
          }))
          hisList.setAdapter(hisAdapter)
          clearHis.onClick = function()
            local hisClearTipout = {

              LinearLayout,
              background = "#ffffffff",
              layout_height = "fill",
              orientation = "vertical",
              layout_width = "fill",
              gravity = 'center',
              {
                TextView, -- 文本框控件
                textSize = "16dp",
                text = "确定要清空历史吗？", -- 文本内容
                layout_width = 'fill',
                layout_height = 'wrap',
                layout_margin = '15dp', -- 布局边距
                textColor = "#227CEA"
                -- Typeface=Typeface.createFromFile(File(activity.getLuaDir().."/static/font.ttf"));
              },
              {
                LinearLayout, -- 线性布局
                layout_width = 'fill',
                layout_height = 'wrap',
                orientation = 'horizontal',
                gravity = 'right',
                -- layout_margin='15dp',--布局边距
                {
                  TextView, -- 文本框控件;
                  text = '取消', -- 文本内容
                  textSize = "16dp",
                  layout_margin = '15dp', -- 布局边距
                  textColor = "#227CEA",
                  onClick = function()
                    hisTipDialog.dismiss()
                  end
                },
                {
                  TextView, -- 文本框控件
                  text = '确定', -- 文本内容
                  textSize = "16dp",
                  textColor = "#227CEA",
                  layout_margin = '15dp', -- 布局边距
                  onClick = function()
                    historys = {}
                    webUrlUtil.clearHistorys()
                    hisAdapter.notifyDataSetChanged()
                    hisTipDialog.dismiss()
                  end
                }
              }

            }
            hisTipDialog = Dialog(activity).setContentView(loadlayout(hisClearTipout))

            hisTipDialog.getWindow().setBackgroundDrawable(ColorDrawable(0xffffffff))
            -- 设置触摸弹窗外部隐藏弹窗

            hisTipDialog.setCanceledOnTouchOutside(true);
            local p = hisTipDialog.getWindow().getAttributes()
            p.dimAmount = 0
            p.width = activity.width * 0.8

            -- p.height=activity.Height*0.74;
            hisTipDialog.getWindow().setAttributes(p);
            -- dialog.getWindow().getDecorView().setPadding(0,0,0,0)

            hisTipDialog.show()

          end

         elseif data.id == "mark" then

          local markBody = {
            LinearLayout,
            layout_height = "fill",
            layout_width = "fill",
            orientation = "vertical",
            backgroundColor = "#ffffff",
            {
              LinearLayout,
              layout_height = "50dp",
              layout_width = "fill",
              orientation = "horizontal",
              layout_margin="10dp";
              gravity = 'left|center', -- 重力
              {

                TextView,
                layout_width = "wrap_content",
                layout_height = "wrap_content",
                Typeface = Typeface.createFromFile(File(activity.getLuaDir() .. "/static/font/zt1.ttf")),
                layout_weight=1,
                text = "书签",
                textColor = 0xff227CEA,
                textSize = "18dp",
                --layout_margin= "8dp"
              },
              {
                ImageView, -- 图片控件
                layout_width = '30dp', -- 图片宽度
                layout_height = '30dp', -- 图片高度
                src = "static/img/webview/share.png",
                layout_marginLeft = '10dp',
                --    id="homeButton"; ColorFilter='#5C5C5C';--图片着色
                scaleType = 'fitXY', -- 图片拉伸
                id = 'shareMark',
                ColorFilter = "#99000000",
                layout_gravity = 'center' -- 重力
              },


              {
                ImageView, -- 图片控件
                layout_width = '30dp', -- 图片宽度
                layout_height = '30dp', -- 图片高度
                src = "static/img/webview/delete.png",
                layout_marginLeft = '20dp',
                --    id="homeButton"; ColorFilter='#5C5C5C';--图片着色
                scaleType = 'fitXY', -- 图片拉伸
                id = 'clearMark',
                ColorFilter = "#99000000",
                layout_gravity = 'center' -- 重力
              }

            },
            {
              RecyclerView,
              id = "markList",
              layout_height = "fill",
              layout_width = "fill"
            }
          }
          markItem = {
            LinearLayout,
            layout_width = "fill",
            orientation = "vertical",
            descendantFocusability = ViewGroup.FOCUS_BLOCK_DESCENDANTS, -- 阻止内部控件抢占焦点，如Button及其子控件



            {
              TextView,
              layout_height = "1dp",
              layout_width = "fill",
              backgroundColor = 0x55000000,
              singleLine = true,
              gravity = "left|center"
            },
            {
              LinearLayout,
              layout_height = "40dp",
              layout_width = "fill",
              orientation = "horizontal",
              gravity = "left|center",
              id = "singleItem",
              layout_margin="10dp",
              {
                ImageView,
                layout_height = "30dp",
                layout_width = "30dp",
                layout_marginRight = '10dp',
                layout_gravity = "left|center",
                scaleType = 'centerCrop', -- 图片拉伸
                id = 'icon'
                -- ColorFilter = "#33000000"
              },
              {
                TextView,
                id = "name",
                layout_height = "30dp",
                layout_width = "fill",
                textColor=0xff000000,
                singleLine = true,
                gravity = "left|center",
                layout_weight = "1"

              }
            }

          }
          markPop = PopupWindow(activity).setContentView(loadlayout(markBody)).setWidth(activity.width) -- 设置宽度
          .setHeight(activity.height * 0.8).setFocusable(false) -- 设置可获得焦点
          .setTouchable(true).setClippingEnabled(false) -- 设置启用剪辑
          .setBackgroundDrawable(nil) -- 设置可触摸
          .setOutsideTouchable(true)
          activity.getWindow().attributes.systemUiVisibility =
          View.SYSTEM_UI_FLAG_HIDE_NAVIGATION or View.SYSTEM_UI_FLAG_IMMERSIVE
          markPop.showAtLocation(menu, Gravity.BOTTOM, 0, 0)

          toolPop=markPop
          markPop.onDismiss = function()
            toolPop = false
          end



          markList.setLayoutManager(StaggeredGridLayoutManager(1, StaggeredGridLayoutManager.VERTICAL))
          hearts = webHeartUtil.getHearts()
          markAdapter = LuaCustRecyclerAdapter(AdapterCreator({
            getItemCount = function()

              if not hearts or tostring(hearts)=="nil" then

                hearts = webHeartUtil.getHearts()
              end
              return #hearts
            end,
            getItemViewType = function(position)
              return 0
            end,
            onCreateViewHolder = function(parent, viewType)
              local views = {}
              holder = LuaCustRecyclerHolder(loadlayout(markItem, views))
              holder.view.setTag(views)
              return holder
            end,
            onBindViewHolder = function(holder, position)
              local view = holder.view.getTag()
              view.name.setText(hearts[position + 1].name)
              glideImg(view.icon, hearts[position + 1].icon)
              view.singleItem.onClick = function()
                markPop.dismiss()
                menuPop.dismiss()
                webView.loadUrl(hearts[position + 1].url)
              end
              view.singleItem.onLongClick = function()
                local markTipout = {

                  LinearLayout,
                  background = "#ffffffff",
                  layout_height = "fill",
                  orientation = "vertical",
                  layout_width = "fill",
                  gravity = 'center',
                  {
                    TextView, -- 文本框控件
                    textSize = "16dp",
                    text = "请选择操作", -- 文本内容
                    layout_width = 'fill',
                    layout_height = 'wrap',
                    layout_margin = '15dp', -- 布局边距
                    textColor = "#227CEA"
                    -- Typeface=Typeface.createFromFile(File(activity.getLuaDir().."/static/font.ttf"));
                  },
                  {
                    LinearLayout, -- 线性布局
                    layout_width = 'fill',
                    layout_height = 'wrap',
                    orientation = 'horizontal',
                    gravity = 'right',
                    -- layout_margin='15dp',--布局边距
                    {
                      TextView, -- 文本框控件
                      text = '删除', -- 文本内容
                      textSize = "16dp",
                      textColor = "#227CEA",
                      layout_margin = '15dp', -- 布局边距
                      onClick = function()

                        hearts = webHeartUtil.removeHeart(position + 1)
                        markAdapter.notifyDataSetChanged()
                        markDialog.dismiss()
                      end
                    },
                    {
                      TextView, -- 文本框控件
                      text = '置顶', -- 文本内容
                      textSize = "16dp",
                      textColor = "#227CEA",
                      layout_margin = '15dp', -- 布局边距
                      onClick = function()

                        hearts = webHeartUtil.setTopHeart(position + 1)
                        markAdapter.notifyDataSetChanged()
                        markDialog.dismiss()
                      end
                    },
                    {
                      TextView, -- 文本框控件
                      text = '置底', -- 文本内容
                      textSize = "16dp",
                      textColor = "#227CEA",
                      layout_margin = '15dp', -- 布局边距
                      onClick = function()

                        hearts = webHeartUtil.setBottomHeart(position + 1)
                        markAdapter.notifyDataSetChanged()
                        markDialog.dismiss()
                      end
                    },
                    {
                      TextView, -- 文本框控件
                      text = '复制', -- 文本内容
                      textSize = "16dp",
                      textColor = "#227CEA",
                      layout_margin = '15dp', -- 布局边距
                      onClick = function()
                        systemUtil.copyContent(hearts[position + 1].url)
                        markDialog.dismiss()
                      end
                    },

                    {
                      TextView, -- 文本框控件;
                      text = '取消', -- 文本内容
                      textSize = "16dp",
                      layout_margin = '15dp', -- 布局边距
                      textColor = "#227CEA",
                      onClick = function()
                        markDialog.dismiss()
                      end
                    }

                  }

                }
                markDialog = Dialog(activity).setContentView(loadlayout(markTipout))

                markDialog.getWindow().setBackgroundDrawable(ColorDrawable(0xffffffff))
                -- 设置触摸弹窗外部隐藏弹窗

                markDialog.setCanceledOnTouchOutside(true);
                local p = markDialog.getWindow().getAttributes()
                p.dimAmount = 0
                p.width = activity.width * 0.8

                -- p.height=activity.Height*0.74;
                markDialog.getWindow().setAttributes(p);
                -- dialog.getWindow().getDecorView().setPadding(0,0,0,0)

                markDialog.show()
              end
            end
          }))
          markList.setAdapter(markAdapter)
          clearMark.onClick = function()
            local markClearTipout = {

              LinearLayout,
              background = "#ffffffff",
              layout_height = "fill",
              orientation = "vertical",
              layout_width = "fill",
              gravity = 'center',
              {
                TextView, -- 文本框控件
                textSize = "16dp",
                text = "确定要清空书签吗？", -- 文本内容
                layout_width = 'fill',
                layout_height = 'wrap',
                layout_margin = '15dp', -- 布局边距
                textColor = "#227CEA"
                -- Typeface=Typeface.createFromFile(File(activity.getLuaDir().."/static/font.ttf"));
              },
              {
                LinearLayout, -- 线性布局
                layout_width = 'fill',
                layout_height = 'wrap',
                orientation = 'horizontal',
                gravity = 'right',
                -- layout_margin='15dp',--布局边距
                {
                  TextView, -- 文本框控件;
                  text = '取消', -- 文本内容
                  textSize = "16dp",
                  layout_margin = '15dp', -- 布局边距
                  textColor = "#227CEA",
                  onClick = function()
                    markTipDialog.dismiss()
                  end
                },
                {
                  TextView, -- 文本框控件
                  text = '确定', -- 文本内容
                  textSize = "16dp",
                  textColor = "#227CEA",
                  layout_margin = '15dp', -- 布局边距
                  onClick = function()
                    hearts = {}
                    webHeartUtil.clearHearts()
                    markAdapter.notifyDataSetChanged()
                    markTipDialog.dismiss()
                  end
                }
              }

            }
            markTipDialog = Dialog(activity).setContentView(loadlayout(markClearTipout))

            markTipDialog.getWindow().setBackgroundDrawable(ColorDrawable(0xffffffff))
            -- 设置触摸弹窗外部隐藏弹窗

            markTipDialog.setCanceledOnTouchOutside(true);
            local p = markTipDialog.getWindow().getAttributes()
            p.dimAmount = 0
            p.width = activity.width * 0.8

            -- p.height=activity.Height*0.74;
            markTipDialog.getWindow().setAttributes(p);
            -- dialog.getWindow().getDecorView().setPadding(0,0,0,0)

            markTipDialog.show()

          end

          shareMark.onClick=function()

            local temp={}
            temp.type="WEBHEART"
            temp.datas=webHeartUtil.getHearts()

            File("/sdcard/搜搜/share/").mkdirs()
            local fileName="/sdcard/搜搜/share/".."webHearts_"..tostring(os.time())..".sousou"

            io.open(fileName, "w"):write(cjson.encode(temp)):close()
            --showToast("已导出至"..fileName.."!")
            systemUtil.copyContent(fileName,false)
            systemUtil.shareFile(fileName)
            --dialogsiteplay.dismiss()

          end
         elseif data.id == "addMark" then
          webHeartUtil.setHeart({
            ["name"] = webView.getTitle(),
            ["url"] = webView.getUrl(),
            ["icon"] = icon,
            ['time'] = os.date("%Y-%m-%d %H:%M:%S", os.time())

          })
          showToast("书签添加成功！")
        end

      end
    end
  })
  tool_list.setAdapter(toolAdapter)

end
