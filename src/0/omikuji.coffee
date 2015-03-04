###
おみくじを引いて結果を出力するだけのJS
###
(->
  ###
  Model
  ###
  Omikuji = do ->
    Omikuji = (options) ->
      @count = 0
      @name  = options.name
      @percentage = options.percentage
      return
  
    Omikuji::countup = ->
      @count += 1
      return
    
    return Omikuji
  
  ###
  Collection
  ###
  OmikujiBox = do ->
    OmikujiBox = () ->
      @models = [
        new Omikuji({ name: "大吉", percentage: 5 })
        new Omikuji({ name: "中吉", percentage: 40 })
        new Omikuji({ name: "小吉", percentage: 40 })
        new Omikuji({ name: "凶", percentage: 15 })
      ]
      @setRanges()
      return
  
    OmikujiBox::setRanges = ->
      total = 0
      @models.forEach (model) ->
        model.under = total
        total += model.percentage
        model.top = total
        return
      return
  
    OmikujiBox::pull = ->
      random = Math.round(Math.random() * 100)
      matchIndex = 0
      idx = 0
      @models.forEach (model) ->
        if model.under <= random and model.top > random
          matchIndex = idx
        idx += 1
        return
  
      @models[matchIndex].countup()
      return @models[matchIndex]
    
    OmikujiBox::result = ->
      console.log "------ #{num}回引いた結果 ------"
      @models.forEach (model) ->
        console.log "#{model.name} : #{model.count}回"
        return
      return
    
    return OmikujiBox
  
  ###
  100回引いた結果を出力
  ###
  box = new OmikujiBox()
  num = 100
  for i in [0...num]
    box.pull()
  box.result()
  
)
