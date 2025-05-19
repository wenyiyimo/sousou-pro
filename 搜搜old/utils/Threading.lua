function Threading(threadNum,timeP,func,datas)
  local self={
    threadNum=threadNum,
    timePeriod=timeP,
    func=func,
    datas=datas,
    num=1,
    pool={}
  }
  local function run()
    if self.num<=#self.datas then
      for i=1, self.threadNum do
        if self.num>#self.datas then
         else
          if self.pool[i] then
            --print(self.pool[i].getState())
            if self.pool[i].isInterrupted() then

              self.pool[i] = thread(self.func,self.datas[self.num])


              self.num=self.num+1
            end
           else

            self.pool[i] = thread(self.func,self.datas[self.num])
            self.num=self.num+1
          end
        end
      end

      if self.num<= #self.datas then
        -- print(self.num)
        task(self.timePeriod,run)
      end
     else
    end
  end

  local function interrupt()
    for k,v in pairs(self.pool)do
      v.interrupt()
    end
  end
  return{
    run=run,
    interrupt=interrupt
  }
end