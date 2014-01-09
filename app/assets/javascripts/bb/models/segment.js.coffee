class WOTracker.Models.Segment extends Backbone.Model
  defaults: {
    name: 'New Superset'
    rest_time: 60
  }
  url: ->
    return '/' unless @collection
    url = @collection.url
    url += @id if @id
    url
  initialize: ->
    @view = new WOTracker.Views.SegmentView(model: this)
    @exercises = new WOTracker.Collections.Exercises()
    @exercises.parent = this
    @exercises.url = "#{@url()}/exercises/"
    @collection.on 'reset', @collectionReset, this if @collection
    @on 'change', ->
      @exercises.url = "#{@url()}/exercises/"
      @view.render()
      @save()
  collectionReset: ->
    @exercises.reset @get 'exercises'