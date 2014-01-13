$(document).ready ->
   $(@).trigger('myPageLoadEvent')
$(document).on('page:load', ->
   $(@).trigger('myPageLoadEvent')
)
$.widget('custom.spinnerLike', $.ui.spinner, {
  _buttonHtml: ->
    return ''
})
$.widget('custom.frontMenu', $.ui.menu, {
  _create:->
    e = @_super()
    @.element.css('z-index', 99)
    return e
})
$.widget('custom.borderlessButton', $.ui.button, {
  _create:->
    e = @_super()
    @.element.removeClass('ui-state-default')
    return e
})

#flashCount=0
$(document).on('myPageLoadEvent', ->
#  if flashCount == 0
#    flashMessage=$(".notice").text()
#    if flashMessage
  #$("#workouts-area").accordion({collapsible: true, active:false})
  #$(".btngrp a").button()
  $(".workout-edit-button").borderlessButton(icons:{primary: 'ui-icon-pencil'})
  $(".workout-play-button").borderlessButton(icons:{primary: 'ui-icon-play'})
  $(".workout-delete-button").borderlessButton(icons:{primary: 'ui-icon-trash'})
  $(".btngrp a").click (e)->
    e.stopPropagation()
  $("button, input[type='submit']").button()
  $("input.number").spinner()
  $("input[type!='submit'], textarea").spinnerLike()
  $("nav a").on('mouseover', ->
    $(@).addClass('ui-state-default')
  )
  $("nav a").on('mouseout', ->
    $(@).removeClass('ui-state-default')
  )
  $(".sidebar1 ul").frontMenu()
)