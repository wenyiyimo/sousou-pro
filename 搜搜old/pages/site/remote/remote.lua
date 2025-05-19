require("import");
import("common.BaseActivity");
import("pages.site.remote.layout");
activity.setContentView(layout);

bodyout.setLayoutManager(StaggeredGridLayoutManager(1, StaggeredGridLayoutManager.VERTICAL))

local sites = siteUtil.getSites()

adapter = LuaCustRecyclerAdapter(AdapterCreator({

  getItemCount = function()
    return #sites
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
    -- print(data[position+1][1])
    view = holder.view.getTag()
    view.title.text = sites[position + 1].NAME
    view.contact.text = "联系方式：" .. sites[position + 1].CONTACT
    view.author.text = "作者："..sites[position + 1].AUTHOR
    view.switch.checked=sites[position + 1].isActive
    view.switch.ThumbDrawable.setColorFilter(PorterDuffColorFilter(0xff227CEA, PorterDuff.Mode.SRC_ATOP))
    view.switch.TrackDrawable.setColorFilter(PorterDuffColorFilter(0xff227CEA, PorterDuff.Mode.SRC_ATOP))
    view.switch.setOnCheckedChangeListener({
      onCheckedChanged = function(buttonView, isChecked)
        sites[position + 1].isActive = isChecked
        siteUtil.setSites(sites)
      end
    })

    view.title.onClick = function()
      if (sites[position + 1].URL == "自定义数据") then
        activity.newActivity("pages/site/list/list", {position + 1,true})
       else
        activity.newActivity("pages/site/list/list", {position + 1,false})
      end
    end
    view.contact.onLongClick = function()
      systemUtil.copyContent(sites[position + 1].CONTACT)
    end
    view.setTop.onClick = function()
      sites = siteUtil.setSiteTop(position + 1)
      adapter.notifyDataSetChanged()
    end
    view.setBottom.onClick = function()
      sites = siteUtil.setSiteBottom(position + 1)
      adapter.notifyDataSetChanged()
    end
    view.share.onClick = function()

      local temp={}
      temp.type="SITE"
      temp.datas=sites[position + 1].SITE

      File("/sdcard/搜搜/share/").mkdirs()

      local fileName="/sdcard/搜搜/share/"..sites[position + 1].NAME.."_"..tostring(os.time())..".sousou"
      io.open(fileName, "w"):write(cjson.encode(temp)):close()
      --showToast("已导出至"..fileName.."!")
      systemUtil.copyContent(fileName,false)
      systemUtil.shareFile(fileName)

      --[[local tipout={

        LinearLayout;
        background="#ffffffff";
        layout_height="fill";
        orientation="vertical";
        layout_width="fill";
        gravity='center',
        {
          TextView,--文本框控件
          textSize="16dp",
          text="请选择操作",--文本内容
          layout_width='fill',
          layout_height='wrap',
          layout_margin='15dp',--布局边距
          textColor="#227CEA";
          --Typeface=Typeface.createFromFile(File(activity.getLuaDir().."/static/font.ttf"));
        },
        {
          LinearLayout,--线性布局
          layout_width='fill',
          layout_height='wrap',
          orientation='horizontal',
          gravity='right',
          -- layout_margin='15dp',--布局边距
          {
            TextView,--文本框控件;
            text='导出',--文本内容
            textSize="16dp",
            layout_margin='15dp',--布局边距
            textColor="#227CEA";
            onClick=function ()
              local temp={}
              temp.type="SITE"
              temp.datas=sites[position + 1].SITE

              File("/sdcard/搜搜/share/").mkdirs()

              local fileName="/sdcard/搜搜/share/"..sites[position + 1].NAME.."_"..tostring(os.time())..".sousou"
              io.open(fileName, "w"):write(cjson.encode(temp)):close()
              showToast("已导出至"..fileName.."!")
              systemUtil.copyContent(fileName,false)
              dialogsiteplay.dismiss()
            end
          },
          {
            TextView,--文本框控件
            text='复制',--文本内容
            textSize="16dp",
            textColor="#227CEA";
            layout_margin='15dp',--布局边距
            onClick=function ()
              if (sites[position + 1].URL == "自定义数据") then
                systemUtil.copyContent(cjson.encode(sites[position + 1]))
               else
                local temp = {}
                temp.NAME = sites[position + 1].NAME
                temp.URL = sites[position + 1].URL
                systemUtil.copyContent(cjson.encode(temp))
              end
              dialogsiteplay.dismiss()
            end
          },
          {
            TextView,--文本框控件;
            text='取消',--文本内容
            textSize="16dp",
            layout_margin='15dp',--布局边距
            textColor="#227CEA";
            onClick=function ()
              dialogsiteplay.dismiss()
            end
          },

        }

      }
      dialogsiteplay=Dialog(activity)

      --设置弹窗布局
      dialogsiteplay.setContentView(loadlayout(tipout))
      --设置弹窗位置

      dialogsiteplay.getWindow().setBackgroundDrawable(ColorDrawable(0xffffffff))
      --设置触摸弹窗外部隐藏弹窗

      dialogsiteplay.setCanceledOnTouchOutside(true);
      local p=dialogsiteplay.getWindow().getAttributes()
      p.dimAmount=0
      p.width=activity.width*0.8

      --p.height=activity.Height*0.74;
      dialogsiteplay.getWindow().setAttributes(p);
      --dialog.getWindow().getDecorView().setPadding(0,0,0,0)

      dialogsiteplay.show()
]]







    end
    view.delete.onClick = function()
      if (sites[position + 1].URL == "自定义数据") then
        dialog = AlertDialog.Builder(this).setTitle("确定清空自定义数据吗？").setPositiveButton(
        "确定", {
          onClick = function(v)
            sites = siteUtil.resetMySite(position + 1)
            adapter.notifyDataSetChanged()
          end
        }).setNegativeButton("取消", nil).show()
        dialog.create()
        -- 更改Button颜色
        import "android.graphics.Color"
        dialog.getButton(dialog.BUTTON_POSITIVE).setTextColor(0xff227CEA)
        dialog.getButton(dialog.BUTTON_NEGATIVE).setTextColor(0xff227CEA)
        dialog.getButton(dialog.BUTTON_NEUTRAL).setTextColor(0xff227CEA)
       else
        dialog = AlertDialog.Builder(this).setTitle("确定删除该订阅吗？").setPositiveButton("确定", {
          onClick = function(v)
            sites = siteUtil.deleteSite(position + 1)
            adapter.notifyDataSetChanged()
          end
        }).setNegativeButton("取消", nil).show()
        dialog.create()
        -- 更改Button颜色
        import "android.graphics.Color"
        dialog.getButton(dialog.BUTTON_POSITIVE).setTextColor(0xff227CEA)
        dialog.getButton(dialog.BUTTON_NEGATIVE).setTextColor(0xff227CEA)
        dialog.getButton(dialog.BUTTON_NEUTRAL).setTextColor(0xff227CEA)
      end

    end
  end
}))

-- RecyclerView绑定适配器
bodyout.setAdapter(adapter)

popaddsite.onClick = function()

  dialog = AlertDialog.Builder(this).setTitle("添加订阅").setView(loadlayout(addSite)) -- .setMessage("消息")
  .setPositiveButton("添加", {
    onClick = function(v)

      if siteurl.Text ~= "" and #siteurl.Text > 0 then
        siteurl.Text = trim(siteurl.Text)
        local siteflag = siteUtil.checkSiteUrlExist(siteurl.Text)
        if siteflag then

          Http.get(siteurl.Text, nil, "utf8", nil, function(a, b)
            if a == 200 then
              local jsondata = cjson.decode(b)

              if judgeKeyInTable(jsondata, "NAME") and judgeKeyInTable(jsondata, "URL") and
                judgeKeyInTable(jsondata, "SITE") then
                if not judgeKeyInTable(jsondata, "CONTACT") then
                  jsondata.CONTACT = "无"
                end
                if not judgeKeyInTable(jsondata, "AUTHOR") then
                  jsondata.AUTHOR = "无"
                end
                jsondata.isActive = true
                table.insert(sites, jsondata)
                siteUtil.setSites(sites)
                showToast("添加成功！")
                adapter.notifyDataSetChanged()
               else
                showToast("数据格式错误！")
              end
             else
              showToast("该链接返回结果错误！")
            end
          end)
         elseif siteurl.Text and #siteurl.Text>10 and startswith(siteurl.Text,"{") and endswith(siteurl.Text,"}")
          local copydata=cjson.decode(siteurl.Text)
          if copydata.URL and copydata.NAME and copydata.URL~="自定义数据" then
            local siteflag = siteUtil.checkSiteUrlExist(copydata.URL)
            if siteflag then

              Http.get(copydata.URL, nil, "utf8", nil, function(a, b)
                if a == 200 then
                  local jsondata = cjson.decode(b)

                  if judgeKeyInTable(jsondata, "NAME") and judgeKeyInTable(jsondata, "URL") and
                    judgeKeyInTable(jsondata, "SITE") then
                    if not judgeKeyInTable(jsondata, "CONTACT") then
                      jsondata.CONTACT = "无"
                    end
                    if not judgeKeyInTable(jsondata, "AUTHOR") then
                      jsondata.AUTHOR = "无"
                    end
                    jsondata.isActive = true
                    table.insert(sites, jsondata)
                    siteUtil.setSites(sites)
                    adapter.notifyDataSetChanged()
                   else
                    showToast("数据格式错误！")
                  end
                 else
                  showToast("该链接返回结果错误！")
                end
              end)
             else
              showToast("请检查输入的链接，是否已经存在或者链接不是以http开头。")
            end
           elseif copydata.URL and copydata.URL=="自定义数据" and copydata.SITE then


            local siteIndex=siteUtil.getMySiteIndex()
            for k,v in pairs(copydata.SITE)do
              if v.name and #v.name>=2 then

                local flag = true
                for m, n in pairs(sites[siteIndex].SITE) do
                  if v.name == n.name then
                    flag = false
                    break
                  end
                end
                if flag then
                  table.insert(sites[siteIndex].SITE,v)
                  siteUtil.setSites(sites)
                end
              end
            end
            showToast("站源添加成功！")

           elseif copydata.name then

            local sites = siteUtil.getSites()
            local siteIndex=siteUtil.getMySiteIndex()


            local flag = true
            for k, v in pairs(sites[siteIndex].SITE) do
              if v.name == copydata.name then
                flag = false
                break
              end
            end
            if flag then
              table.insert(sites[siteIndex].SITE, copydata)
              siteUtil.setSites(sites)
              adapter.notifyDataSetChanged()
              showToast("站源添加成功！")
             else
              showToast("站源名称已存在！")
            end
           else
            showToast("错误的数据格式！")
          end
         else
          showToast("请检查输入的链接，是否已经存在或者链接不是以http开头。")
        end
      end
    end
  }) --  .setNeutralButton("取消",nil)
  .setNegativeButton("取消", nil).show()
  dialog.create()

  --[=[    --更改消息颜色
   message=dialog.findViewById(android.R.id.message)
   message.setTextColor(0xff227CEA)
  ]=]
  -- 更改Button颜色
  import "android.graphics.Color"
  dialog.getButton(dialog.BUTTON_POSITIVE).setTextColor(0xff227CEA)
  dialog.getButton(dialog.BUTTON_NEGATIVE).setTextColor(0xff227CEA)
  dialog.getButton(dialog.BUTTON_NEUTRAL).setTextColor(0xff227CEA)

  -- 更改Title颜色
  import "android.text.SpannableString"
  import "android.text.style.ForegroundColorSpan"
  import "android.text.Spannable"
  local sp = SpannableString("添加订阅")
  sp.setSpan(ForegroundColorSpan(0xff227CEA), 0, #sp, Spannable.SPAN_EXCLUSIVE_INCLUSIVE)
  dialog.setTitle(sp)
end
