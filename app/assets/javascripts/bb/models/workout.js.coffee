class WOTracker.Models.Workout extends Backbone.Model
  initialize: ->
    @url = $("#workout-edit-area").data('loadurl')
    @segments =  new WOTracker.Collections.Segments(parent: this)
    @segments.url = "#{@url}/segments/"
    @view = new WOTracker.Views.WorkoutView({model: this})
    @on 'change', ->
      @save()
    @fetch(success: @initialLoad, error: @firstLoadError)
  initialLoad: (model, response, options)->
    model.segments.reset(model.get('segments'))
    model.view.firstLoad()
  firstLoadError: (obj, resp)->
    console.log 'error'
