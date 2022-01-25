class FishingX

  isActive: false
  isPulling: false

  constructor: ->
    $.on 'f11', @toggle

  checkIsFishing: ->

    color = 0xFFFFFF
    start = Client.point [94, 94]
    end = Client.point [98, 97]

    p1 = @findColor color, start, end
    unless p1 then return false

    return true

  checkShape: ->

    # 0, return
    # 1, return
    # 2, pull

    color = 0xFFFFC0
    start = Client.point [35, 8]
    end = Client.point [65, 18]

    p1 = @findColor color, start, end
    unless p1 then return 0

    p2 = @findColor color, [start[0], p1[1] + 5], end
    unless p2 then return 0

    if p1[0] - p2[0] > (Client.vw 2) then return 1
    return 2

  checkStart: ->

    color = 0xFFE92C
    start = Client.point [82, 87]
    end = Client.point [87, 97]

    p1 = @findColor color, start, end
    if p1 then return false

    return true

  findColor: (color, start, end) ->
    [x, y] = ColorManager.find color, start, end
    if x * y > 0 then return [x, y]
    return false

  next: ->

    @isPulling = false

    Timer.add 'fishing', 2e3, =>
      $.press 'l-button'
      Timer.add 'fishing', 1e3, @start

  pull: ->
    @isPulling = true
    $.press 'l-button:down'
    Timer.add 50, -> $.press 'l-button:up'

  start: ->
    Timer.add 'fishing/notice', 60e3, -> Sound.beep 3
    $.press 'l-button'

  toggle: ->

    @isActive = !@isActive

    Timer.remove 'fishing/watch'
    Timer.remove 'fishing'
    Timer.remove 'fishing/notice'

    if @isActive
      Scene.name = 'fishing'
      Timer.loop 'fishing/watch', 100, @watch
      msg = 'enter fishing mode'
      Hud.render 5, msg
    else
      Scene.name = 'unknown'
      msg = 'leave fishing mode'
      Hud.render 5, msg

  watch: ->

    unless @checkIsFishing() then return

    shape = @checkShape()

    unless shape

      if @isPulling
        @next()
        return

      unless @checkStart() then return
      @start()
      return

    unless shape == 2 then return

    @pull()

# execute
Fishing = new FishingX()