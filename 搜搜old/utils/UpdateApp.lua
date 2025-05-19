function UpdateApp()

  import "android.graphics.drawable.ColorDrawable"



  appcode = tostring(this.getPackageManager().getPackageInfo(this.getPackageName(),
  ((782268899 / 2 / 2 - 8183) / 10000 - 6 - 231) / 9).versionName)

  Http.get("https://raw.githubusercontent.com/wenyiyimo/sousou/main/update.json", nil, "utf8", nil, function(a, b)
    if a == 200 then
      appicon = "icon.png"
      appname = "搜搜"
      appurl = "https://raw.githubusercontent.com/wenyiyimo/sousou/main/%E6%90%9C%E6%90%9C.apk"
      import "cjson"

      local jsondata = cjson.decode(b)
      appSize = appcode .. "  ---->  " .. jsondata.version
      if jsondata.version ~= appcode then
        import "android.graphics.Typeface"
        layout = {
          LinearLayout, -- 线性布局
          orientation = 'vertical', -- 方向
          layout_width = 'fill', -- 宽度
          -- layout_height='wrap',--高度
          -- background='#00FFFFFF',--背景颜色或图片路径
          --  padding="10dp",--填充边距

          gravity = "left|center",
          {
            TextView, -- 文本控件
            -- gravity='center';--重力
            text = "APP有更新", -- 显示文字
            layout_width = 'wrap', -- 宽度
            textSize = '18dp', -- 文字大小
            layout_margin = "10dp",
            layout_marginBottom = "20dp",
            textColor = 0xff227CEA, -- 文字颜色
            Typeface = Typeface.defaultFromStyle(Typeface.BOLD)
          },
          {
            LinearLayout, -- 线性布局
            orientation = 'horizontal', -- 方向
            gravity = 'top|left', -- 重力
            layout_width = 'fill', -- 宽度
            layout_height = 'wrap', -- 高度
            --  background='#00FFFFFF',--背景颜色或图片路径

            {
              ImageView, -- 图片控件
              src = appicon, -- 图片路径
              layout_width = '40dp', -- 宽度
              layout_height = '40dp', -- 高度
              layout_marginLeft = '16dp' -- 左距
              --  layout_marginRight='16dp';--右距

            },

            {
              LinearLayout, -- 线性布局
              orientation = 'vertical', -- 方向
              layout_width = 'fill', -- 宽度
              layout_weight = '1', -- 剩余属性
              layout_marginLeft = '10dp', -- 左距
              gravity = 'center|left', -- 重力
              {
                TextView, -- 文本控件
                -- gravity='center';--重力
                text = appname, -- 显示文字
                textSize = '16dp', -- 文字大小
                textColor = 0x99000000,
                --   Typeface=Typeface.defaultFromStyle(Typeface.BOLD);
              },
              {
                TextView, -- 文本控件
                --  gravity='center';--重力
                --   layout_height='fill';--高度
                --  Typeface=Typeface.defaultFromStyle(Typeface.BOLD);
                text = appSize, -- 显示文字
                textSize = '12dp', -- 文字大小
                id = "daxi",
                textColor = 0x99000000,
              }
            }
          },
          {
            LinearLayout, -- 线性布局
            orientation = 'vertical', -- 方向
            layout_width = 'fill', -- 宽度
            layout_height = '16dp', -- 高度
            --  background='#66FFFFFF',--背景颜色或图片路径
            {
              ProgressBar, -- 进度条
              layout_width = 'fill', -- 进度条宽度
              layout_marginLeft = '16dp', -- 左距
              layout_marginRight = '16dp', -- 右距
              visibility = 8, -- 不可视4--隐藏8--显示0
              id = "downProgress",
              -- 长形进度条
              style = '?android:attr/progressBarStyleHorizontal'
            }
          },
          {
            LinearLayout, -- 线性布局
            orientation = 'horizontal', -- 方向
            layout_width = 'fill', -- 宽度
            gravity = 'center|left', -- 卡片重力
            {
              LinearLayout, -- 线性布局
              orientation = 'horizontal', -- 方向
              layout_width = 'fill', -- 宽度
              -- layout_weight='1';--剩余属性
              gravity = 'center|right', -- 卡片重力
              layout_margin = "20dp",

              {
                TextView, -- 文本控件
                gravity = 'center|right', -- 重力
                text = '复制链接', -- 显示文字
                textColor = 0xff227CEA, -- 文字颜色
                textSize = '14dp', -- 文字大小
                Typeface = Typeface.defaultFromStyle(Typeface.BOLD),
                id = "copyButton"
              },
              {
                TextView, -- 文本控件
                gravity = 'center|right', -- 重力
                --   padding="16dp",--填充边距
                text = '下载', -- 显示文字
                textColor = 0xff227CEA, -- 文字颜色
                textSize = '14dp', -- 文字大小
                layout_marginLeft = "20dp",
                Typeface = Typeface.defaultFromStyle(Typeface.BOLD),
                id = "downButton"
              }
            }

          }
        };

        -- 普通对话框
        dialog = Dialog(activity)
        dialog.setTitle("APP有更新")
        dialog.setContentView(loadlayout(layout)) -- 设置自定义视图
        dialog.setCanceledOnTouchOutside(false);
        -- dialog.setCancelable(false);
        dialog.getWindow().setBackgroundDrawable(ColorDrawable(0xffffffff))

        local p = dialog.getWindow().getAttributes()
        p.dimAmount = 0.5
        p.width = activity.width * 0.8

        --   p.height=300;
        dialog.getWindow().setAttributes(p);
        dialog = dialog.show()

        copyButton.onClick = function() -- 点击事件

          Toast.makeText(activity, "已复制成功", Toast.LENGTH_SHORT).show()
          import "android.content.Context"
          activity.getSystemService(Context.CLIPBOARD_SERVICE).setText(appurl)
        end;

        function xdc(url, path)
          require "import"
          import "java.net.URL"
          local ur = URL(url)
          import "java.io.File"
          file = File(path);
          con = ur.openConnection();
          co = con.getContentLength();
          is1= con.getInputStream();
          bs = byte[1024]
          local len, read = 0, 0
          import "java.io.FileOutputStream"
          wj = FileOutputStream(path);
          len = is1.read(bs)
          while len ~= -1 do
            wj.write(bs, 0, len);
            read = read + len
            pcall(call, "ding", read, co)
            len = is1.read(bs)
          end
          wj.close();
          is1.close();
          -- pcall(call, "dstop", co)
          pcall(call, "dstop", read)
          -- 安装APK
          activity.installApk(path)
        end
        function download(url, path)
          thread(xdc, url, path)
        end

        downButton.onClick = function() -- 点击事件
          if downButton.Text == "下载" then
            -- downProgress.setVisibility(View.VISIBLE)
            downPath = "/storage/emulated/0/搜搜/" .. appname .. ".apk" -- 下载到xx路径
            daxi.Text = "连接服务器中..."

            --   print("无密码",res)
            download("https://raw.githubusercontent.com/wenyiyimo/sousou/main/%E6%90%9C%E6%90%9C.apk", downPath)

           elseif downButton.Text == "安装" then
            import "android.content.Intent"
            function installApk(path)
              if activity.getPackageManager().canRequestPackageInstalls() and 0==this.checkSelfPermission("android.permission.READ_EXTERNAL_STORAGE") then--存储权限检测

                import "android.net.Uri"
                intent = Intent(Intent.ACTION_VIEW)
                intent.setDataAndType(Uri.parse("file://" .. path),
                "application/vnd.android.package-archive")
                intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                activity.startActivity(intent)
               else
                print("需要给予安装与存储读取权限")
                import "android.provider.Settings"
                activity.startActivity(Intent(Settings.ACTION_MANAGE_UNKNOWN_APP_SOURCES,Uri.parse("package:"..activity.getPackageName())))
                activity.requestPermissions({"android.permission.READ_EXTERNAL_STORAGE","android.permission.INTERNET"},1)
              end
            end






            installApk(downPath)

           else
          end
        end;

        import "android.graphics.PorterDuffColorFilter"
        import "android.graphics.PorterDuff"
        downProgress.ProgressDrawable
        .setColorFilter(PorterDuffColorFilter(0xff227CEA, PorterDuff.Mode.SRC_ATOP)) -- 长条形进度条颜色
        function ding(a, b) -- 已下载，总长度(byte)
          daxi.Text = "正在下载：" .. string.format("%0.2f", a / 1024 / 1024) .. "MB"
          -- .. string.format("%0.2f", b / 1024 / 1024) .. "MB"
          -- downProgress.progress = (a / b * 100)
          --  text2.Text="正在下载……"..(a/b*100).."%"
          -- downButton.Text = string.format('%.2f', (a / b * 100)) .. "%"
        end

        -- 下载完成后调用
        function dstop(c) -- 总长度
          downButton.Text = "安装"
          --  daxi.Text = "下载完成：" .. string.format("%0.2f", c / 1024 / 1024) .. "MB"
        end
      end
    end
  end)
end
