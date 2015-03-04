###
おみくじを引いて結果を出力するだけのJS
###
window.onload = ->

  ###
  Model
  ###
  class Omikuji
    constructor: (options) ->
      @count = 0
      @name  = options.name
      @percentage = options.percentage
      return

    countup: ->
      @count += 1
      return

  ###
  Collection
  ###
  class OmikujiBox
    constructor: ->
      @models = [
        new Omikuji({ name: "大吉", percentage: 5 })
        new Omikuji({ name: "中吉", percentage: 40 })
        new Omikuji({ name: "小吉", percentage: 40 })
        new Omikuji({ name: "凶", percentage: 15 })
      ]
      @setRanges()
      return

    setRanges: ->
      total = 0
      @models.forEach (model) ->
        model.under = total
        total += model.percentage
        model.top = total
        return
      return

    pull: ->
      random = Math.round(Math.random() * 100)
      matchIndex = 0
      @models.forEach (model, idx) ->
        if model.under <= random and model.top > random
          matchIndex = idx
        return

      @models[matchIndex].countup()
      return @models[matchIndex]

    result: ->
      console.log "------ #{num}回引いた結果 ------"
      @models.forEach (model) ->
        console.log "#{model.name} : #{model.count}回"
        return
      return

  num = 100
  document.getElementById("omikuji").addEventListener "click", ->
    ###
    100回引いた結果を出力
    ###
    box = new OmikujiBox()
    for i in [0...num]
      box.pull()
    box.result()
    return

