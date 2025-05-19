webView.setOnKeyListener(View.OnKeyListener {
  onKey = function(view, keyCode, event)

    if event.getAction() == KeyEvent.ACTION_DOWN then

      if fullscreen then

        --xwebchromeclient.onHideCustomView()

       else
        if isPop then
          if resPop then
            resPop.dismiss()
            resPop = false
          end
          if searchPop then

            searchPop.dismiss()
            searchPop = false
          end
          if menuPop then
            if toolPop then
              toolPop.dismiss()
              toolPop=false
             else
              menuPop.dismiss()
              menuPop = false
            end
          end
         elseif viewSource then

          viewSource=false
          webView.loadUrl(replace(webView.getUrl(),"view-source:",""))

         else
          local webname = webView.getUrl()
          -- print(webname..".........."..webDefaultUrl)
          if webDefaultUrl == webname then

            activity.finish()
           else
            if webView.canGoBack() then

              if endswith(webDefaultUrl, "/") and not endswith(webname, "/") then
                if webname .. "/" == webDefaultUrl then
                  activity.finish()
                end
               elseif not endswith(webDefaultUrl, "/") and endswith(webname, "/") then
                if webname == webDefaultUrl .. "/" then
                  activity.finish()
                end

              end

              webView.goBack()
             else
              if navUrl then
                activity.finish()
               else
                webView.loadUrl(webDefaultUrl)
                webView.clearHistory()
              end
            end
          end
        end
      end
      return true


    end
  end
})





function onKeyDown(code, event)
  if string.find(tostring(event), "KEYCODE_BACK") ~= nil then
    if fullscreen then

     else
      if isPop then

       elseif viewSource then


       else
        local webname = webView.getUrl()
        -- print(webname..".........."..webDefaultUrl)
        if webDefaultUrl == webname then

          activity.finish()
         else
          if webView.canGoBack() then


           else


            if navUrl then
              activity.finish()
             else
              webView.loadUrl(webDefaultUrl)
              webView.clearHistory()
            end
          end
        end
      end

    end
    return true
  end
end

