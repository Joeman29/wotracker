# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
window.WorkoutPlayer = {
  Timers:[]
}

class WorkoutPlayer.Player
  workoutTime: 0
  segmentTime: 0
  exerciseTime: 0
  playIndex: 0
  currSegIndex: 0
  setsLeft: 0
  setsDone: 0
  workout: {}
  initialize: (json)->
    @workout = json
    obj = this
    $("#finished").click (e)->
      obj.scrollNextExercise()
    @workoutTimer = @setInterval(->
      @workoutTime++
      currval = $("#workout-progress").progressbar('value')
      $("#workout-progress").progressbar('value', currval - 1)
      $("#actual-workout-time").text(@convertToTime(@workoutTime))
    , 1000)
    @segmentTimer = @setInterval(->
      @segmentTime++
    , 1000)
    @exerciseTimer = @setInterval(->
      @exerciseTime++
      $("#timer").text(@convertToTime(@exerciseTime))
      $("#exercise-progress").progressbar('value', @exerciseTime)
    , 1000)
    @playWorkout()
  playWorkout: ->
    if @workout.segments.length == 0
      $("#segment-name").text('Error: No data in workout')
      return
    $($("#workout-outline").find(".exercise-name")[0]).addClass('current-exercise')
    $($("#workout-outline").find(".segment-name")[0]).addClass('current-segment')
    $("#exercise-progress").progressbar()
    $("#workout-progress").progressbar({max: @workout.goal_time * 60, value: @workout.goal_time * 60 })
    @setsLeft = @workout.segments[0].sets
    @playSegment(@workout.segments[0])
  playSegment: (json)->
    @playIndex = 0
    @segmentTime = 0
    $("#segment-name").text(json.name)
    $("#segment-sets").text("#{json.sets} Sets")
    $("#segment-position").text(json.position)
    unless json.exercises.length
      @currSegIndex++
      if @workout.segments[@currSegIndex]
        @playSegment(@workout.segments[@currSegIndex])
      else
        @finishWorkout()
    else
      @playExercise(json.exercises[0])
  playExercise: (json)->
    @exerciseTime = 0
    $("#exercise-description").text(json.descript)
    kind = json.kind
    $("#exercise-name").text(json.name)
    if kind == 'Cardio/Aerobic' || kind == 'Stretch'
      $("#exercise-time").show().text(json.time + ' minute(s)')
      $("#timer, #exercise-progress").show()
      $("#exercise-progress").progressbar({value: 0, max: json.time *60})
      $("#finished").hide()
      time = json.time * 60000
      @setTimeout( ->
        @scrollNextExercise()
      , time)
    else
      $("#timer, #exercise-progress, #exercise-time").hide()
      $("#finished").show()
  scrollNextExercise: ->
    #$("audio").play()
    unless @workout.segments[@currSegIndex].exercises[@playIndex].timeset
      @workout.segments[@currSegIndex].exercises[@playIndex].timeset = []
    @workout.segments[@currSegIndex].exercises[@playIndex].timeset[@setsDone] = @exerciseTime
    @playIndex++
    nextEx = @workout.segments[@currSegIndex].exercises[@playIndex]
    if nextEx
      @advancePlayHead()
      @playExercise(nextEx)
    else
      @setsLeft--
      if @workout.segments[@currSegIndex + 1] || @setsLeft
        @rest(@workout.segments[@currSegIndex].rest_time)
      else
        @finishWorkout()
  rest: (time) ->
    @advancePlayHead()
    @exerciseTime = 0
    $("#exercise-name").text("Rest for #{time} seconds")
    $("#timer, #exercise-progress").show()
    $("#exercise-progress").progressbar({max: time})
    $("#finished").hide()
    @setTimeout( ->
        @setsDone++
        @workout.segments[@currSegIndex].time = @segmentTime
        if @setsLeft == 0
          @currSegIndex++
          @setsLeft = @workout.segments[@currSegIndex].sets
          @setsDone = 0
          @advancePlayHead()
          @advanceSegmentPlayHead()
        else
          @resetSegmentOutline()
        @playSegment(@workout.segments[@currSegIndex])
    , time * 1000)
  advancePlayHead: ->
    current = $("#workout-outline").find(".current-exercise")
    current.addClass('done').removeClass('not-done')
    $(current.nextAll(".exercise-name, .rest")[0]).addClass('current-exercise')
    current.removeClass('current-exercise')
  advanceSegmentPlayHead: ->
    current = $("#workout-outline").find('.current-segment')
    current.addClass('done').removeClass('not-done')
    current.removeClass('current-segment')
    $(current.nextAll(".segment-name")[0]).addClass('current-segment')
  resetSegmentOutline:->
    curr = $('.current-exercise')
    prevs = curr.prevUntil('.current-segment', '.exercise-name')
    console.log curr
    console.log prevs
    prevs.removeClass('done').addClass('not-done')
    curr.removeClass('current-exercise')
    prevs.last().addClass('current-exercise')
  finishWorkout: ->
    $("#workout-play-start-area").hide()
    @workout.time = @workoutTime
    @workout.completed_segments_attributes = @workout.segments
    delete @workout.segments
    for seg in @workout.completed_segments_attributes
      seg.completed_exercises_attributes = seg.exercises
      delete seg.exercises
    console.log JSON.stringify(@workout)
    @stopTimers()
    $.post($("#workout-play-area").data('return-url'), {workout: @workout}, (data, response)->
       console.log response
    )
    $("#finished").hide()
    $("#done-workout").button().show()
  stopTimers: ->
    WorkoutPlayer.Timers.forEach((timer)->
      clearInterval(timer)
    )
  setInterval: (callback, interval)->
    WorkoutPlayer.Timers.push setInterval($.proxy(callback, this), interval)
  setTimeout:(callback, interval) ->
    WorkoutPlayer.Timers.push setTimeout($.proxy(callback, this), interval)
  convertToTime: (num)->
     "#{('0' + Math.floor(num/60)).substr(-2)}:#{('0'+(num % 60)).substr(-2)}"


$(document).on 'myPageLoadEvent', ->
  $("#workout-play-start").click ->
      $(@).hide()
      $("#workout-play-start-area").dialog({width:'45%', position:{at:'center-5% top'}, modal: true})
      $("#workout-meta").dialog({width: '30%', position:{at:'right top'}})
      $("#workout-outline").dialog({width:'20%', position:{at:'left top'}})
      $("#exercise-meta").dialog({width:'45%', position:{at:'center-5% center'}})
      $.getJSON($("#workout-play-area").data('workout-url'), (data)->
        player = new WorkoutPlayer.Player()
        player.initialize(data)
      )

$(document).on('page:before-change', ->
  WorkoutPlayer.Timers.forEach((timer)->
    clearInterval(timer)
  )
)
