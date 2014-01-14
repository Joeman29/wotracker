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
      @save()
      @view.render()
    @on 'invalid', ->
      @attributes = @previousAttributes()
      alert @validationError
  validate: (attrs, options)->
    if(attrs.name.length < 1)
      return 'Cannot be blank'
    unless $.isNumeric(attrs.rest_time)
      return 'Rest time must be a number'
  collectionReset: ->
    @exercises.reset @get 'exercises'